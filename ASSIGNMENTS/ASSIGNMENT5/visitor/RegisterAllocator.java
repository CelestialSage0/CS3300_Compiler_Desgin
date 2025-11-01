package visitor;

import java.util.*;

/**
 * Linear-scan register allocator for temps discovered by LivenessAnalysis.
 *
 * NOTES / assumptions:
 * - Uses 18 general-purpose registers: t0..t9 then s0..s7 (t registers
 * preferred).
 * - s0..s7 are callee-saved; t0..t9 are caller-saved (we do not emit
 * save/restore
 * in this allocator — that must be handled during final code emission).
 * - For each ProcedureIntervals (from LivenessAnalysis), we allocate registers
 * for all TempInterval objects recorded there.
 * - Spilled temps are assigned sequential stack slots starting at 0 (these will
 * be used as (SPILLEDARG i) or other stack locations in MiniRA emission).
 *
 * Integration:
 * - Construct with the map produced by LivenessAnalysis (procedureIntervals).
 * - Call allocateAll(); then getAllocationForProcedure(procName) to inspect
 * results.
 */
public class RegisterAllocator {

    // The registers available for general allocation (18 registers)
    private static final String[] REG_POOL = {
            // prefer t regs first (caller-saved), then s regs (callee-saved)
            "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9",
            "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7"
    };
    private final int R = REG_POOL.length; // 18

    public static class Allocation {
        public String temp; // "TEMP n"
        public String assignedReg; // e.g. "t3" or null if spilled
        public boolean spilled;
        public int stackSlot; // valid if spilled (>=0)
        public int first, last, def; // from interval

        public Allocation(String temp, int first, int last, int def) {
            this.temp = temp;
            this.first = first;
            this.last = last;
            this.def = def;
            this.assignedReg = null;
            this.spilled = false;
            this.stackSlot = -1;
        }
    }

    public static class ProcedureAllocationResult {
        public String procedureName;
        public Map<String, Allocation> allocations = new HashMap<>();
        public int stackSlotsNeeded = 0; // number of stack slots used for spilled temps
        public boolean anySpilled = false;
        public int numArgs = 0; // from procedure header in LivenessAnalysis (if known)
        public int maxCallArgs = 0; // placeholder (not computed here)
    }

    private Map<String, LivenessAnalysis.ProcedureIntervals> procedureIntervals;

    public RegisterAllocator(Map<String, LivenessAnalysis.ProcedureIntervals> procIntervals) {
        this.procedureIntervals = procIntervals;
    }

    /**
     * Run allocation for every procedure and return results map.
     */
    public Map<String, ProcedureAllocationResult> allocateAll() {
        Map<String, ProcedureAllocationResult> results = new HashMap<>();
        for (Map.Entry<String, LivenessAnalysis.ProcedureIntervals> e : procedureIntervals.entrySet()) {
            String proc = e.getKey();
            ProcedureAllocationResult r = allocateProcedure(e.getValue());
            results.put(proc, r);
        }
        return results;
    }

    /**
     * Linear-scan allocation for one procedure.
     *
     * Basic algorithm:
     * - Build an interval object for each temp with finite first/last.
     * - Sort intervals by increasing start (first).
     * - Keep an "active" list ordered by increasing end (last).
     * - When processing interval i:
     * expire intervals in active whose end < i.start
     * if active.size == R -> need to spill: pick the interval with largest end
     * (last)
     * if that interval's end > i.last -> spill it (give its register to i)
     * else spill i
     * else allocate a free register to i
     */
    private ProcedureAllocationResult allocateProcedure(LivenessAnalysis.ProcedureIntervals procIntervals) {
        ProcedureAllocationResult result = new ProcedureAllocationResult();
        result.procedureName = procIntervals.procedureName;

        // prepare intervals list
        List<Allocation> intervals = new ArrayList<>();

        for (Map.Entry<String, LivenessAnalysis.TempInterval> te : procIntervals.tempIntervals.entrySet()) {
            LivenessAnalysis.TempInterval ti = te.getValue();
            // Skip temps that were never used (firstUse may be Integer.MAX_VALUE)
            if (ti.firstUse == Integer.MAX_VALUE || ti.lastUse == Integer.MIN_VALUE) {
                continue;
            }
            Allocation a = new Allocation(te.getKey(), ti.firstUse, ti.lastUse, ti.definition);
            intervals.add(a);
        }

        // sort by increasing first (start)
        intervals.sort(Comparator.comparingInt(i -> i.first));

        // active list sorted by increasing last (end)
        List<Allocation> active = new ArrayList<>();
        // free registers stack (use as queue to prefer t0.. then s0..)
        Deque<String> freeRegs = new ArrayDeque<>();
        for (String r : REG_POOL)
            freeRegs.addLast(r);

        int nextStackSlot = 0;

        for (Allocation cur : intervals) {
            // expire old intervals
            expireOldIntervals(active, cur, freeRegs);

            if (active.size() == R) {
                // need to spill
                Allocation spill = active.get(active.size() - 1); // last interval (largest end)
                if (spill.last > cur.last) {
                    // spill 'spill' and give its register to cur
                    cur.assignedReg = spill.assignedReg;
                    cur.spilled = false;
                    // assign stack slot to spilled one
                    spill.spilled = true;
                    spill.stackSlot = nextStackSlot++;
                    result.anySpilled = true;
                    result.allocations.put(spill.temp, spill);
                    // replace spill in active with cur (maintain ordering by last)
                    active.remove(active.size() - 1);
                    insertActiveSorted(active, cur);
                    result.allocations.put(cur.temp, cur);
                } else {
                    // spill cur
                    cur.spilled = true;
                    cur.stackSlot = nextStackSlot++;
                    result.anySpilled = true;
                    result.allocations.put(cur.temp, cur);
                }
            } else {
                // there is a free register; give it to cur
                String reg = freeRegs.removeFirst();
                cur.assignedReg = reg;
                cur.spilled = false;
                insertActiveSorted(active, cur);
                result.allocations.put(cur.temp, cur);
            }
        }

        // any remaining in active should be recorded (they likely already are)
        for (Allocation a : active) {
            if (!result.allocations.containsKey(a.temp))
                result.allocations.put(a.temp, a);
        }

        result.stackSlotsNeeded = nextStackSlot;
        // numArgs: the LivenessAnalysis Procedure constructor parsed a param count into
        // 'params' local variable,
        // but didn't store it. If you want the argument count here, modify
        // LivenessAnalysis to store it.
        result.numArgs = 0; // placeholder

        // maxCallArgs requires scanning the procedure body for CALL nodes and counting
        // arguments;
        // add such a scan if you need this field accurate.
        result.maxCallArgs = 0;

        return result;
    }

    // remove intervals in active whose end < start; return their regs to freeRegs
    private void expireOldIntervals(List<Allocation> active, Allocation cur, Deque<String> freeRegs) {
        // We iterate from beginning while end < cur.first
        List<Allocation> toRemove = new ArrayList<>();
        for (Allocation a : active) {
            if (a.last < cur.first) {
                toRemove.add(a);
            } else {
                // because active is sorted by end, we can break early
                break;
            }
        }
        for (Allocation a : toRemove) {
            active.remove(a);
            if (!a.spilled && a.assignedReg != null) {
                freeRegs.addLast(a.assignedReg);
            }
        }
    }

    // insert into active so that active is sorted by increasing last (end)
    private void insertActiveSorted(List<Allocation> active, Allocation cur) {
        int i = 0;
        while (i < active.size() && active.get(i).last <= cur.last)
            i++;
        active.add(i, cur);
    }
}
