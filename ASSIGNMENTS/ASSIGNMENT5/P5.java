import java.util.Map;
import syntaxtree.*;
import visitor.*;

public class P5 {
    public static void main(String[] args) {
        try {
            // Step 1: Parse MicroIR input from stdin
            Node root = new microIRParser(System.in).Goal();

            // Step 2: Run liveness analysis
            LivenessAnalysis liveness = new LivenessAnalysis();
            root.accept(liveness, null);

            // Step 3: Run linear scan register allocation
            RegisterAllocator allocator = new RegisterAllocator(liveness.procedureIntervals);
            Map<String, RegisterAllocator.ProcedureAllocationResult> allocResults = allocator.allocateAll();

            // Step 4: Emit MiniRA code
            CodeGeneration emitter = new CodeGeneration(allocResults);
            root.accept(emitter, null);

            // Step 5: Print final MiniRA output
            System.out.println(emitter.getOutput());

        } catch (ParseException e) {
            System.err.println("Parse error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}
