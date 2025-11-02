package visitor;

import java.util.*;
import visitor.LivenessAnalysis.ProcedureIntervals;
import visitor.LivenessAnalysis.TempInterval;

public class RegisterAllocator {
    private static String[] REGISTERS = {
            "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
            "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
    };

    public static class AllocationChange {
        public int position;
        public String tempId;
        public ChangeKind kind;
        public String where;

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

    private static class ActiveInfo {
        TempInterval interval;
        String reg;
        Integer stackSlot;

        ActiveInfo(TempInterval interval, String reg, Integer stackSlot) {
            this.interval = interval;
            this.reg = reg;
            this.stackSlot = stackSlot;
        }
    }

    public List<AllocationChange> allocate(ProcedureIntervals proc) {
        List<TempInterval> intervals = new ArrayList<>();
        for (TempInterval t : proc.tempIntervals.values()) {
            if (t.firstUse == Integer.MAX_VALUE && t.definition == -1)
                continue;
            if (t.definition != -1) {
                t.firstUse = Math.min(t.firstUse, t.definition);
            }
            if (t.lastUse == Integer.MIN_VALUE) {
                t.lastUse = t.firstUse;
            }
            intervals.add(t);
        }
        intervals.sort(Comparator.comparingInt(i -> i.firstUse));

        List<AllocationChange> changes = new ArrayList<>();
        List<ActiveInfo> active = new ArrayList<>();
        Queue<String> freeRegs = new ArrayDeque<>();
        for (String r : REGISTERS)
            freeRegs.offer(r);

        int nextStackSlot = 0;
        Map<String, ActiveInfo> tempToActive = new HashMap<>();
        Map<String, Integer> spilledSlots = new HashMap<>();

        for (TempInterval cur : intervals) {
            int curStart = cur.firstUse;

            List<ActiveInfo> expired = new ArrayList<>();
            for (ActiveInfo a : new ArrayList<>(active)) {
                if (a.interval.lastUse < curStart) {
                    expired.add(a);
                }
            }
            for (ActiveInfo e : expired) {
                active.remove(e);
                if (e.reg != null) {
                    freeRegs.offer(e.reg);
                    changes.add(new AllocationChange(curStart, e.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, e.reg));
                } else {
                    changes.add(new AllocationChange(curStart, e.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, "stack[" + e.stackSlot + "]"));
                }
                tempToActive.remove(e.interval.tempId);
            }

            if (!freeRegs.isEmpty()) {
                String reg = freeRegs.poll();
                ActiveInfo info = new ActiveInfo(cur, reg, null);
                active.add(info);
                tempToActive.put(cur.tempId, info);
                active.sort(Comparator.comparingInt(a -> a.interval.lastUse));
                changes.add(new AllocationChange(curStart, cur.tempId, AllocationChange.ChangeKind.ADD, reg));
            } else {
                ActiveInfo farthest = Collections.max(active, Comparator.comparingInt(a -> a.interval.lastUse));
                if (farthest.interval.lastUse > cur.lastUse) {
                    String stolenReg = farthest.reg;
                    int slot = nextStackSlot++;
                    farthest.reg = null;
                    farthest.stackSlot = slot;
                    spilledSlots.put(farthest.interval.tempId, slot);

                    changes.add(new AllocationChange(curStart, farthest.interval.tempId,
                            AllocationChange.ChangeKind.SPILL, "stack[" + slot + "]"));
                    changes.add(new AllocationChange(curStart, farthest.interval.tempId,
                            AllocationChange.ChangeKind.REMOVE, stolenReg));

                    active.remove(farthest);
                    tempToActive.remove(farthest.interval.tempId);

                    ActiveInfo curInfo = new ActiveInfo(cur, stolenReg, null);
                    active.add(curInfo);
                    tempToActive.put(cur.tempId, curInfo);
                    active.sort(Comparator.comparingInt(a -> a.interval.lastUse));

                    changes.add(new AllocationChange(curStart, cur.tempId, AllocationChange.ChangeKind.ADD, stolenReg));
                } else {
                    int slot = nextStackSlot++;
                    spilledSlots.put(cur.tempId, slot);
                    ActiveInfo curInfo = new ActiveInfo(cur, null, slot);
                    tempToActive.put(cur.tempId, curInfo);
                    changes.add(new AllocationChange(curStart, cur.tempId,
                            AllocationChange.ChangeKind.SPILL, "stack[" + slot + "]"));
                }
            }
        }

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

        for (TempInterval t : intervals) {
            if (!tempToActive.containsKey(t.tempId)) {
                int pos = t.lastUse + 1;

                boolean anyRemoveExists = false;
                for (AllocationChange c : changes) {
                    if (c.tempId.equals(t.tempId) && c.kind == AllocationChange.ChangeKind.REMOVE) {
                        anyRemoveExists = true;
                        break;
                    }
                }
                if (anyRemoveExists) {
                    continue;
                }
                Integer slot = spilledSlots.get(t.tempId);
                String where = (slot != null) ? "stack[" + slot + "]" : "stack(?)";
                changes.add(new AllocationChange(pos, t.tempId,
                        AllocationChange.ChangeKind.REMOVE, where));
            }
        }

        changes.sort(Comparator
                .comparingInt((AllocationChange c) -> c.position)
                .thenComparing(c -> c.tempId)
                .thenComparing(c -> c.kind.toString()));

        return changes;
    }
}
