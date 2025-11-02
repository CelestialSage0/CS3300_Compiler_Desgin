import syntaxtree.*;
import visitor.*;
import java.io.*;
import java.util.*;

public class P5 {
    public static void main(String[] args) {
        try {
            // Parse input MicroIR program
            Node root = new microIRParser(System.in).Goal();

            // ===== Phase 1: Liveness Analysis =====
            LivenessAnalysis livenessAnalyzer = new LivenessAnalysis();
            root.accept(livenessAnalyzer, null);

            System.out.println("\n===============================");
            System.out.println("   LIVENESS ANALYSIS RESULTS   ");
            System.out.println("===============================\n");

            // Print live intervals for each procedure
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

            for (var entry : livenessAnalyzer.procedureIntervals.entrySet()) {
                String procName = entry.getKey();
                var procIntervals = entry.getValue();

                System.out.println("Procedure: " + procName);
                System.out.println("------------------------------------");

                List<RegisterAllocator.AllocationChange> changes = allocator.allocate(procIntervals);
                Map<String, String> currentAlloc = new TreeMap<>();

                for (RegisterAllocator.AllocationChange change : changes) {
                    System.out.printf(
                            "pos=%-4d %-7s %-10s -> %-10s\n",
                            change.position,
                            change.kind,
                            change.tempId,
                            change.where);

                    switch (change.kind) {
                        case ADD -> currentAlloc.put(change.tempId, change.where);
                        case SPILL -> currentAlloc.put(change.tempId, change.where);
                        case REMOVE -> currentAlloc.remove(change.tempId);
                    }

                    // Print current allocation after each change
                    System.out.print("  Current allocation: { ");
                    for (var e : currentAlloc.entrySet()) {
                        System.out.print(e.getKey() + "=" + e.getValue() + " ");
                    }
                    System.out.println("}");
                }

                System.out.println("------------------------------------\n");
            }

            // ===== Phase 3: (Optional) Code Generation =====
            // CodeGeneration codeGen = new CodeGeneration(allocationResults);
            // root.accept(codeGen, null);
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
