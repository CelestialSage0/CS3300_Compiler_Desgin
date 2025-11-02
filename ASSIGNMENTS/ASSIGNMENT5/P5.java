import syntaxtree.*;
import visitor.*;
import visitor.RegisterAllocator.AllocationChange;
import visitor.RegisterAllocator.AllocationChange.ChangeKind;

import java.util.*;

public class P5 {
    public static void main(String[] args) {
        try {
            // ===== Phase 0: Parse MicroIR program =====
            Node root = new microIRParser(System.in).Goal();

            // ===== Phase 1: Liveness Analysis =====
            LivenessAnalysis livenessAnalyzer = new LivenessAnalysis();
            root.accept(livenessAnalyzer, null);

            System.out.println("\n===============================");
            System.out.println("   LIVENESS ANALYSIS RESULTS   ");
            System.out.println("===============================\n");

            for (var entry : livenessAnalyzer.procedureIntervals.entrySet()) {
                String procName = entry.getKey();
                var procIntervals = entry.getValue();

                System.out.println("Procedure: " + procName);
                System.out.println("------------------------------------");
                System.out.printf("%-10s %-10s %-10s\n", "TEMP", "Start", "End");
                System.out.println("------------------------------------");

                for (var intervalEntry : procIntervals.tempIntervals.entrySet()) {
                    var interval = intervalEntry.getValue();
                    System.out.printf("%-10s %-10d %-10d\n",
                            interval.tempId, interval.firstUse, interval.lastUse);
                }
                System.out.println("------------------------------------\n");
            }

            // ===== Phase 2: Register Allocation =====
            System.out.println("\n===============================");
            System.out.println("   LINEAR SCAN ALLOCATION TRACE");
            System.out.println("===============================\n");

            RegisterAllocator allocator = new RegisterAllocator();

            // Store per-procedure data
            Map<String, List<AllocationChange>> procChanges = new HashMap<>();
            Map<String, Map<Integer, Map<String, String>>> procAllocationTimeline = new HashMap<>();
            Map<String, Integer> procStackSlots = new HashMap<>();

            for (var entry : livenessAnalyzer.procedureIntervals.entrySet()) {
                String procName = entry.getKey();
                var procIntervals = entry.getValue();

                System.out.println("Procedure: " + procName);
                System.out.println("------------------------------------");

                List<AllocationChange> changes = allocator.allocate(procIntervals);
                procChanges.put(procName, changes);

                // ---- Build allocation timeline (HashMap) ----
                Map<Integer, Map<String, String>> allocationTimeline = new HashMap<>();
                Map<String, String> currentAlloc = new HashMap<>();

                int maxPos = 0;
                for (AllocationChange change : changes) {
                    maxPos = Math.max(maxPos, change.position);

                    switch (change.kind) {
                        case ADD, SPILL -> currentAlloc.put(change.tempId, change.where);
                        case REMOVE -> currentAlloc.remove(change.tempId);
                    }

                    // Save a copy at this position
                    allocationTimeline.put(change.position, new HashMap<>(currentAlloc));

                    System.out.printf("pos=%-4d %-7s %-10s -> %-10s  |  Current: %s\n",
                            change.position, change.kind, change.tempId, change.where, currentAlloc);
                }

                // ---- Fill missing positions ----
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

                // ---- Compute total stack slots used ----
                int stackSlots = (int) changes.stream()
                        .filter(c -> c.kind == ChangeKind.SPILL)
                        .map(c -> c.where)
                        .distinct()
                        .count();
                procStackSlots.put(procName, stackSlots);

                System.out.println("------------------------------------\n");
            }

            // ===== Phase 3: (Optional) Code Generation =====
            CodeGeneration codeGen = new CodeGeneration(
                    livenessAnalyzer.procedureIntervals,
                    procAllocationTimeline,
                    procStackSlots);

            root.accept(codeGen, null);
            // System.out.print(codeGen.getOutput());

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
