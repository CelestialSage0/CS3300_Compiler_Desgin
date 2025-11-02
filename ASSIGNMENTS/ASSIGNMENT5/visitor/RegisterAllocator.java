package visitor;

import java.util.*;
import visitor.LivenessAnalysis.ProcedureIntervals;
import visitor.LivenessAnalysis.TempInterval;

/**
 * RegisterAllocator - linear scan allocator that emits allocation changes at
 * specific positions.
 *
 * Usage:
 * RegisterAllocator ra = new RegisterAllocator();
 * List<RegisterAllocator.AllocationChange> changes =
 * ra.allocate(procIntervals);
 * // changes are sorted by position (and then by action) so you can apply them
 * incrementally
 */
public class RegisterAllocator {

    // The registers available for allocation (prefer s- regs first to reduce
    // caller-save pressure).
    private static final String[] REGISTERS = {
            "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
            "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
    };

    public static class AllocationChange {
        public final int position; // program position where change happens
        public final String tempId; // e.g. "TEMP 3"
        public final ChangeKind kind; // ADD, REMOVE, SPILL
        public final String where; // register name or "stack[n]"

        public enum ChangeKind {
            ADD, REMOVE, SPILL
        }

        public AllocationChange(int position, String tempId, ChangeKind kind, String where) {
            this.position = position;
            this.tempId = tempId;
            this.kind = kind;
            this.where = where;
        }

        @Override
        public String toString() {
            return String.format("pos=%d : %s %s -> %s", position, kind, tempId, where);
        }
    }

    // Internal representation for active intervals with assigned register or stack
    // slot.
    private static class ActiveInfo {
        TempInterval interval;
        String reg; // null if spilled
        Integer stackSlot; // null if in reg

        ActiveInfo(TempInterval interval, String reg, Integer stackSlot) {
            this.interval = interval;
            this.reg = reg;
            this.stackSlot = stackSlot;
        }
    }

    /**
     * Allocate registers for one procedure's intervals.
     * Returns a list of allocation changes which are sorted by position.
     */
    public List<AllocationChange> allocate(ProcedureIntervals proc) {
        // collect intervals
        List<TempInterval> intervals = new ArrayList<>();
        for (TempInterval t : proc.tempIntervals.values()) {
            // ignore temps that were never used (safety)
            if (t.firstUse == Integer.MAX_VALUE && t.definition == -1)
                continue;
            // treat start as definition if present else firstUse
            if (t.definition != -1) {
                t.firstUse = Math.min(t.firstUse, t.definition);
            }
            // some temps might only be defined but never used; still allocate a short live
            // range
            if (t.lastUse == Integer.MIN_VALUE) {
                t.lastUse = t.firstUse;
            }
            intervals.add(t);
        }

        // sort by increasing start (firstUse)
        intervals.sort(Comparator.comparingInt(i -> i.firstUse));

        // data structures
        List<AllocationChange> changes = new ArrayList<>();
        List<ActiveInfo> active = new ArrayList<>(); // sorted by increasing end (lastUse)
        Deque<String> freeRegs = new ArrayDeque<>();
        for (String r : REGISTERS)
            freeRegs.add(r);

        int nextStackSlot = 0;
        Map<String, ActiveInfo> tempToActive = new HashMap<>();
        Map<String, Integer> spilledSlots = new HashMap<>(); // track spill slots

        // helper to keep active sorted
        Runnable resortActiveByEnd = () -> active.sort(Comparator.comparingInt(a -> a.interval.lastUse));

        for (TempInterval cur : intervals) {
            int curStart = cur.firstUse;

            // Expire old intervals (end < curStart)
            List<ActiveInfo> expired = new ArrayList<>();
            for (ActiveInfo a : new ArrayList<>(active)) {
                if (a.interval.lastUse < curStart) {
                    expired.add(a);
                }
            }
            for (ActiveInfo e : expired) {
                active.remove(e);
                if (e.reg != null) {
                    freeRegs.addFirst(e.reg);
                    changes.add(new AllocationChange(curStart, e.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, e.reg));
                } else {
                    changes.add(new AllocationChange(curStart, e.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, "stack[" + e.stackSlot + "]"));
                }
                tempToActive.remove(e.interval.tempId);
            }

            // Now allocate for cur
            if (!freeRegs.isEmpty()) {
                // assign a register
                String reg = freeRegs.removeFirst();
                ActiveInfo info = new ActiveInfo(cur, reg, null);
                active.add(info);
                tempToActive.put(cur.tempId, info);
                resortActiveByEnd.run();
                changes.add(new AllocationChange(curStart, cur.tempId, AllocationChange.ChangeKind.ADD, reg));
            } else {
                // No free registers → spill
                ActiveInfo farthest = Collections.max(active, Comparator.comparingInt(a -> a.interval.lastUse));
                if (farthest.interval.lastUse > cur.lastUse) {
                    // spill the farthest and give its register to cur
                    String stolenReg = farthest.reg;
                    int slot = nextStackSlot++;
                    farthest.reg = null;
                    farthest.stackSlot = slot;
                    spilledSlots.put(farthest.interval.tempId, slot); // record spill

                    changes.add(new AllocationChange(curStart, farthest.interval.tempId,
                            AllocationChange.ChangeKind.SPILL, "stack[" + slot + "]"));
                    changes.add(new AllocationChange(curStart, farthest.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, stolenReg));

                    active.remove(farthest);
                    tempToActive.remove(farthest.interval.tempId);

                    ActiveInfo curInfo = new ActiveInfo(cur, stolenReg, null);
                    active.add(curInfo);
                    tempToActive.put(cur.tempId, curInfo);
                    resortActiveByEnd.run();

                    changes.add(new AllocationChange(curStart, cur.tempId, AllocationChange.ChangeKind.ADD, stolenReg));
                } else {
                    // spill current interval directly
                    int slot = nextStackSlot++;
                    spilledSlots.put(cur.tempId, slot); // record spill
                    ActiveInfo curInfo = new ActiveInfo(cur, null, slot);
                    tempToActive.put(cur.tempId, curInfo);
                    changes.add(new AllocationChange(curStart, cur.tempId,
                            AllocationChange.ChangeKind.SPILL, "stack[" + slot + "]"));
                }
            }
        }

        // Expire remaining active intervals
        for (ActiveInfo a : new ArrayList<>(active)) {
            int pos = a.interval.lastUse + 1;
            if (a.reg != null) {
                changes.add(new AllocationChange(pos, a.interval.tempId,
                        AllocationChange.ChangeKind.REMOVE, a.reg));
            } else {
                changes.add(new AllocationChange(pos, a.interval.tempId,
                        AllocationChange.ChangeKind.REMOVE, "stack[" + a.stackSlot + "]"));
            }
        }

        // Emit REMOVE for spilled-but-not-active temps
        for (TempInterval t : intervals) {
            if (!tempToActive.containsKey(t.tempId)) {
                int pos = t.lastUse + 1;

                // ---- IMPROVED: check if ANY REMOVE for this temp exists already (any
                // position)
                boolean anyRemoveExists = false;
                for (AllocationChange c : changes) {
                    if (c.tempId.equals(t.tempId) && c.kind == AllocationChange.ChangeKind.REMOVE) {
                        anyRemoveExists = true;
                        break;
                    }
                }
                if (anyRemoveExists) {
                    continue; // skip emitting duplicate REMOVE (prevents stack(?) duplicates)
                }
                // ---- end improved check

                Integer slot = spilledSlots.get(t.tempId); // use tracked slot
                String where = (slot != null) ? "stack[" + slot + "]" : "stack(?)";
                changes.add(new AllocationChange(pos, t.tempId,
                        AllocationChange.ChangeKind.REMOVE, where));
            }
        }

        // Sort changes for deterministic output
        changes.sort(Comparator
                .comparingInt((AllocationChange c) -> c.position)
                .thenComparing(c -> c.tempId)
                .thenComparing(c -> c.kind.toString()));

        return changes;
    }

    // convenience printer
    public static void printChanges(List<AllocationChange> changes) {
        for (AllocationChange c : changes) {
            System.out.println(c);
        }
    }

    // Example quick driver (you should invoke allocate(proc) from your pass where
    // you have ProcedureIntervals)
    public static void main(String[] args) {
        System.out.println(
                "RegisterAllocator: this main is only a placeholder. Use allocate(proc) with your ProcedureIntervals.");
    }
}
