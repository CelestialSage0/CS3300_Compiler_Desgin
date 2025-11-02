import syntaxtree.*;
import visitor.*;
import visitor.RegisterAllocator.AllocationChange;
import visitor.RegisterAllocator.AllocationChange.ChangeKind;

import java.util.*;

public class P5 {
    public static void main(String[] args) {
        try {
            Node root = new microIRParser(System.in).Goal();

            LivenessAnalysis LA = new LivenessAnalysis();
            root.accept(LA, null);

            RegisterAllocator RA = new RegisterAllocator();

            Map<String, List<AllocationChange>> procChanges = new HashMap<>();
            Map<String, Map<Integer, Map<String, String>>> timestamps = new HashMap<>();
            Map<String, Integer> stack = new HashMap<>();

            for (String procName : LA.procedureIntervals.keySet()) {
                var procIntervals = LA.procedureIntervals.get(procName);

                List<AllocationChange> changes = RA.allocate(procIntervals);
                procChanges.put(procName, changes);

                Map<Integer, Map<String, String>> allocationTimeline = new HashMap<>();
                Map<String, String> currentAlloc = new HashMap<>();

                int maxPos = 0;

                for (AllocationChange change : changes) {
                    if (change.position > maxPos) {
                        maxPos = change.position;
                    }

                    if (change.kind == ChangeKind.ADD || change.kind == ChangeKind.SPILL) {
                        currentAlloc.put(change.tempId, change.where);
                    } else if (change.kind == ChangeKind.REMOVE) {
                        currentAlloc.remove(change.tempId);
                    }

                    allocationTimeline.put(change.position, new HashMap<>(currentAlloc));
                }

                Map<String, String> lastAlloc = new HashMap<>();
                for (int pos = 1; pos <= maxPos; pos++) {
                    Map<String, String> atPos = allocationTimeline.get(pos);

                    if (atPos != null) {
                        lastAlloc = new HashMap<>(atPos);
                    } else {
                        allocationTimeline.put(pos, new HashMap<>(lastAlloc));
                    }
                }

                timestamps.put(procName, allocationTimeline);

                Set<String> spill = new HashSet<>();
                for (AllocationChange c : changes) {
                    if (c.kind == ChangeKind.SPILL) {
                        spill.add(c.where);
                    }
                }
                stack.put(procName, spill.size());
            }

            CodeGeneration CG = new CodeGeneration(
                    LA.procedureIntervals,
                    timestamps,
                    stack);

            root.accept(CG, null);

        } catch (ParseException e) {
            System.err.println("Parse error: " + e.getMessage());
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}
