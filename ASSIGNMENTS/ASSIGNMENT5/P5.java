import syntaxtree.*;
import visitor.*;
import visitor.RegisterAllocator.AllocationChange;
import visitor.RegisterAllocator.AllocationChange.ChangeKind;

import java.util.*;

public class P5 {
    public static void main(String[] args) {
        try {
            Node root = new microIRParser(System.in).Goal();

            LivenessAnalysis livenessAnalyzer = new LivenessAnalysis();
            root.accept(livenessAnalyzer, null);

            for (var entry : livenessAnalyzer.procedureIntervals.entrySet()) {
                String procName = entry.getKey();
                var procIntervals = entry.getValue();

                for (var intervalEntry : procIntervals.tempIntervals.entrySet()) {
                    var interval = intervalEntry.getValue();
                }
            }

            RegisterAllocator allocator = new RegisterAllocator();

            Map<String, List<AllocationChange>> procChanges = new HashMap<>();
            Map<String, Map<Integer, Map<String, String>>> procAllocationTimeline = new HashMap<>();
            Map<String, Integer> procStackSlots = new HashMap<>();

            for (var entry : livenessAnalyzer.procedureIntervals.entrySet()) {
                String procName = entry.getKey();
                var procIntervals = entry.getValue();

                List<AllocationChange> changes = allocator.allocate(procIntervals);
                procChanges.put(procName, changes);

                Map<Integer, Map<String, String>> allocationTimeline = new HashMap<>();
                Map<String, String> currentAlloc = new HashMap<>();

                int maxPos = 0;
                for (AllocationChange change : changes) {
                    maxPos = Math.max(maxPos, change.position);

                    switch (change.kind) {
                        case ADD, SPILL -> currentAlloc.put(change.tempId, change.where);
                        case REMOVE -> currentAlloc.remove(change.tempId);
                    }

                    allocationTimeline.put(change.position, new HashMap<>(currentAlloc));
                }

                Map<String, String> lastState = new HashMap<>();
                for (int i = 1; i <= maxPos; i++) {
                    Map<String, String> stateAtPos = allocationTimeline.get(i);
                    if (stateAtPos != null) {
                        lastState = new HashMap<>(stateAtPos);
                    } else {
                        allocationTimeline.put(i, new HashMap<>(lastState));
                    }
                }

                procAllocationTimeline.put(procName, allocationTimeline);

                int stackSlots = (int) changes.stream()
                        .filter(c -> c.kind == ChangeKind.SPILL)
                        .map(c -> c.where)
                        .distinct()
                        .count();
                procStackSlots.put(procName, stackSlots);
            }

            CodeGeneration codeGen = new CodeGeneration(
                    livenessAnalyzer.procedureIntervals,
                    procAllocationTimeline,
                    procStackSlots);

            root.accept(codeGen, null);
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
