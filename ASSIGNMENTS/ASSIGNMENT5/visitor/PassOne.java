package visitor;

import syntaxtree.*;
import java.util.*;

/**
 * Performs liveness analysis to determine live ranges of temporaries.
 * This visitor analyzes the MicroIR program to collect:
 * - Definition and use points for each temporary
 * - Live intervals for register allocation
 * - Procedure metadata (arg counts, max call arguments)
 */
public class LivenessAnalysis implements GJVisitor<String, String> {

    // ========== Helper classes ==========

    /**
     * Represents a live interval for a temporary variable
     */
    public static class LiveInterval implements Comparable<LiveInterval> {
        public String temp;
        public int start;
        public int end;

        public LiveInterval(String temp, int start, int end) {
            this.temp = temp;
            this.start = start;
            this.end = end;
        }

        /**
         * Check if two intervals overlap
         */
        public boolean overlaps(LiveInterval other) {
            return !(this.end < other.start || other.end < this.start);
        }

        /**
         * Compare by start point (for linear scan)
         */
        @Override
        public int compareTo(LiveInterval other) {
            return Integer.compare(this.start, other.start);
        }

        @Override
        public String toString() {
            return temp + " [" + start + ", " + end + "]";
        }
    }

    /**
     * Stores liveness information for a single procedure
     */
    private static class ProcedureLivenessInfo {
        Map<String, LiveInterval> liveIntervals = new HashMap<>();
        int maxTempNumber = 0;
        int argCount = 0;
        int maxCallArgs = 0;
    }

    // Map from procedure name to its liveness info
    private Map<String, ProcedureLivenessInfo> procedureInfo = new HashMap<>();
    private String currentProcedure = "MAIN";
    private int currentInstructionIndex = 0;

    // Current procedure's temp tracking (cleared per procedure)
    private Map<String, Set<Integer>> tempDef = new HashMap<>(); // Where temps are defined
    private Map<String, Set<Integer>> tempUse = new HashMap<>(); // Where temps are used
    private Map<String, LiveInterval> liveIntervals = new HashMap<>();

    /**
     * Get all procedures analyzed
     */
    public Set<String> getAllProcedures() {
        return procedureInfo.keySet();
    }

    /**
     * Get live intervals for a procedure
     */
    public Map<String, LiveInterval> getLiveIntervals(String procedure) {
        ProcedureLivenessInfo info = procedureInfo.get(procedure);
        return info != null ? info.liveIntervals : new HashMap<>();
    }

    /**
     * Get the highest temp number used in a procedure
     */
    public int getMaxTempNumber(String procedure) {
        ProcedureLivenessInfo info = procedureInfo.get(procedure);
        return info != null ? info.maxTempNumber : 0;
    }

    /**
     * Get number of arguments for a procedure
     */
    public int getArgCount(String procedure) {
        ProcedureLivenessInfo info = procedureInfo.get(procedure);
        return info != null ? info.argCount : 0;
    }

    /**
     * Get max arguments in any call within this procedure
     */
    public int getMaxCallArgs(String procedure) {
        ProcedureLivenessInfo info = procedureInfo.get(procedure);
        return info != null ? info.maxCallArgs : 0;
    }

    /**
     * Record a definition (write) of a temporary
     */
    private void recordTempDef(String temp, int index) {
        if (temp == null || !temp.startsWith("TEMP"))
            return;
        tempDef.computeIfAbsent(temp, k -> new HashSet<>()).add(index);
    }

    /**
     * Record a use (read) of a temporary
     */
    private void recordTempUse(String temp, int index) {
        if (temp == null || !temp.startsWith("TEMP"))
            return;
        tempUse.computeIfAbsent(temp, k -> new HashSet<>()).add(index);
    }

    /**
     * Compute live intervals from def-use information
     */
    private void computeLiveIntervals() {
        liveIntervals.clear();

        // Get all temps (from both defs and uses)
        Set<String> allTemps = new HashSet<>();
        allTemps.addAll(tempDef.keySet());
        allTemps.addAll(tempUse.keySet());

        for (String temp : allTemps) {
            int start = Integer.MAX_VALUE;
            int end = -1;

            Set<Integer> defs = tempDef.getOrDefault(temp, new HashSet<>());
            Set<Integer> uses = tempUse.getOrDefault(temp, new HashSet<>());

            // Find the earliest and latest points
            for (int pos : defs) {
                start = Math.min(start, pos);
                end = Math.max(end, pos);
            }

            for (int pos : uses) {
                start = Math.min(start, pos);
                end = Math.max(end, pos);
            }

            // Create interval if valid
            if (start <= end) {
                liveIntervals.put(temp, new LiveInterval(temp, start, end));
            }
        }
    }

    /**
     * Start analyzing a new procedure
     */
    private void startNewProcedure(String name) {
        currentProcedure = name;
        currentInstructionIndex = 0;
        tempDef.clear();
        tempUse.clear();
        liveIntervals.clear();

        procedureInfo.putIfAbsent(name, new ProcedureLivenessInfo());
    }

    /**
     * Finish analyzing current procedure
     */
    private void endProcedure() {
        computeLiveIntervals();
        ProcedureLivenessInfo info = procedureInfo.get(currentProcedure);
        info.liveIntervals = new HashMap<>(liveIntervals);
    }

    // ========== Auto-generated visitor methods ==========

    public String visit(NodeList n, String argu) {
        for (Enumeration<Node> e = n.elements(); e.hasMoreElements();) {
            e.nextElement().accept(this, argu);
        }
        return null;
    }

    public String visit(NodeListOptional n, String argu) {
        if (n.present()) {
            for (Enumeration<Node> e = n.elements(); e.hasMoreElements();) {
                e.nextElement().accept(this, argu);
            }
        }
        return null;
    }

    public String visit(NodeOptional n, String argu) {
        if (n.present())
            return n.node.accept(this, argu);
        return null;
    }

    public String visit(NodeSequence n, String argu) {
        for (Enumeration<Node> e = n.elements(); e.hasMoreElements();) {
            e.nextElement().accept(this, argu);
        }
        return null;
    }

    public String visit(NodeToken n, String argu) {
        return n.tokenImage;
    }

    // ========== Grammar-specific visitors ==========

    /**
     * f0 -> "MAIN"
     * f1 -> StmtList()
     * f2 -> "END"
     * f3 -> ( Procedure() )*
     * f4 -> <EOF>
     */
    public String visit(Goal n, String argu) {
        startNewProcedure("MAIN");
        n.f1.accept(this, argu);
        endProcedure();

        n.f3.accept(this, argu);
        return null;
    }

    /**
     * f0 -> ( ( Label() )? Stmt() )*
     */
    public String visit(StmtList n, String argu) {
        n.f0.accept(this, argu);
        return null;
    }

    /**
     * f0 -> Label()
     * f1 -> "["
     * f2 -> IntegerLiteral()
     * f3 -> "]"
     * f4 -> StmtExp()
     */
    public String visit(Procedure n, String argu) {
        String label = n.f0.accept(this, argu);
        String argCountStr = n.f2.accept(this, argu);

        startNewProcedure(label);
        ProcedureLivenessInfo info = procedureInfo.get(label);
        info.argCount = Integer.parseInt(argCountStr);

        // Procedure arguments are temps 0 to argCount-1
        // They are "live" from the start
        int argCount = info.argCount;
        for (int i = 0; i < argCount; i++) {
            String temp = "TEMP " + i;
            recordTempDef(temp, 0); // Args are defined at entry
        }

        n.f4.accept(this, argu);
        endProcedure();

        return null;
    }

    /**
     * f0 -> NoOpStmt()
     * | ErrorStmt()
     * | CJumpStmt()
     * | JumpStmt()
     * | HStoreStmt()
     * | HLoadStmt()
     * | MoveStmt()
     * | PrintStmt()
     */
    public String visit(Stmt n, String argu) {
        currentInstructionIndex++;
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> "NOOP"
     */
    public String visit(NoOpStmt n, String argu) {
        return null;
    }

    /**
     * f0 -> "ERROR"
     */
    public String visit(ErrorStmt n, String argu) {
        return null;
    }

    /**
     * f0 -> "CJUMP"
     * f1 -> Temp()
     * f2 -> Label()
     */
    public String visit(CJumpStmt n, String argu) {
        String temp = n.f1.accept(this, argu);
        recordTempUse(temp, currentInstructionIndex);
        n.f2.accept(this, argu);
        return null;
    }

    /**
     * f0 -> "JUMP"
     * f1 -> Label()
     */
    public String visit(JumpStmt n, String argu) {
        n.f1.accept(this, argu);
        return null;
    }

    /**
     * f0 -> "HSTORE"
     * f1 -> Temp()
     * f2 -> IntegerLiteral()
     * f3 -> Temp()
     */
    public String visit(HStoreStmt n, String argu) {
        String temp1 = n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        String temp2 = n.f3.accept(this, argu);

        recordTempUse(temp1, currentInstructionIndex);
        recordTempUse(temp2, currentInstructionIndex);
        return null;
    }

    /**
     * f0 -> "HLOAD"
     * f1 -> Temp()
     * f2 -> Temp()
     * f3 -> IntegerLiteral()
     */
    public String visit(HLoadStmt n, String argu) {
        String dest = n.f1.accept(this, argu);
        String src = n.f2.accept(this, argu);
        n.f3.accept(this, argu);

        recordTempDef(dest, currentInstructionIndex);
        recordTempUse(src, currentInstructionIndex);
        return null;
    }

    /**
     * f0 -> "MOVE"
     * f1 -> Temp()
     * f2 -> Exp()
     */
    public String visit(MoveStmt n, String argu) {
        String dest = n.f1.accept(this, argu);
        recordTempDef(dest, currentInstructionIndex);

        // Visit expression to record any temp uses
        n.f2.accept(this, argu);
        return null;
    }

    /**
     * f0 -> "PRINT"
     * f1 -> SimpleExp()
     */
    public String visit(PrintStmt n, String argu) {
        String exp = n.f1.accept(this, argu);
        if (exp != null && exp.startsWith("TEMP")) {
            recordTempUse(exp, currentInstructionIndex);
        }
        return null;
    }

    /**
     * f0 -> Call()
     * | HAllocate()
     * | BinOp()
     * | SimpleExp()
     */
    public String visit(Exp n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> "BEGIN"
     * f1 -> StmtList()
     * f2 -> "RETURN"
     * f3 -> SimpleExp()
     * f4 -> "END"
     */
    public String visit(StmtExp n, String argu) {
        n.f1.accept(this, argu);

        // Return value is used
        currentInstructionIndex++;
        String retVal = n.f3.accept(this, argu);
        if (retVal != null && retVal.startsWith("TEMP")) {
            recordTempUse(retVal, currentInstructionIndex);
        }

        return null;
    }

    /**
     * f0 -> "CALL"
     * f1 -> SimpleExp()
     * f2 -> "("
     * f3 -> ( Temp() )*
     * f4 -> ")"
     */
    public String visit(Call n, String argu) {
        String proc = n.f1.accept(this, argu);
        if (proc != null && proc.startsWith("TEMP")) {
            recordTempUse(proc, currentInstructionIndex);
        }

        // Count and record argument uses
        int argCount = 0;
        if (n.f3.present()) {
            for (Enumeration<Node> e = n.f3.elements(); e.hasMoreElements();) {
                String temp = e.nextElement().accept(this, argu);
                recordTempUse(temp, currentInstructionIndex);
                argCount++;
            }
        }

        // Update max call args for this procedure
        ProcedureLivenessInfo info = procedureInfo.get(currentProcedure);
        info.maxCallArgs = Math.max(info.maxCallArgs, argCount);

        return null;
    }

    /**
     * f0 -> "HALLOCATE"
     * f1 -> SimpleExp()
     */
    public String visit(HAllocate n, String argu) {
        String exp = n.f1.accept(this, argu);
        if (exp != null && exp.startsWith("TEMP")) {
            recordTempUse(exp, currentInstructionIndex);
        }
        return null;
    }

    /**
     * f0 -> Operator()
     * f1 -> Temp()
     * f2 -> SimpleExp()
     */
    public String visit(BinOp n, String argu) {
        n.f0.accept(this, argu);

        String temp = n.f1.accept(this, argu);
        recordTempUse(temp, currentInstructionIndex);

        String exp = n.f2.accept(this, argu);
        if (exp != null && exp.startsWith("TEMP")) {
            recordTempUse(exp, currentInstructionIndex);
        }

        return null;
    }

    /**
     * f0 -> "LE"
     * | "NE"
     * | "PLUS"
     * | "MINUS"
     * | "TIMES"
     * | "DIV"
     */
    public String visit(Operator n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> Temp()
     * | IntegerLiteral()
     * | Label()
     */
    public String visit(SimpleExp n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> "TEMP"
     * f1 -> IntegerLiteral()
     */
    public String visit(Temp n, String argu) {
        String num = n.f1.accept(this, argu);

        // Track max temp number
        ProcedureLivenessInfo info = procedureInfo.get(currentProcedure);
        int tempNum = Integer.parseInt(num);
        info.maxTempNumber = Math.max(info.maxTempNumber, tempNum);

        return "TEMP " + num;
    }

    /**
     * f0 -> <INTEGER_LITERAL>
     */
    public String visit(IntegerLiteral n, String argu) {
        return n.f0.tokenImage;
    }

    /**
     * f0 -> <IDENTIFIER>
     */
    public String visit(Label n, String argu) {
        return n.f0.tokenImage;
    }
}