package visitor;

import syntaxtree.*;
import java.util.*;

/**
 * Generates MiniRA code from MicroIR with register allocation.
 * This visitor traverses the syntax tree and outputs MiniRA code
 * with temporaries replaced by allocated registers or spill locations.
 */
public class CodeGeneration implements GJVisitor<String, String> {

    private RegisterAllocation regAlloc;
    private LivenessAnalysis liveness;
    private StringBuilder output = new StringBuilder();
    private String currentProcedure = "MAIN";
    private int indentLevel = 0;

    public CodeGeneration(RegisterAllocation regAlloc, LivenessAnalysis liveness) {
        this.regAlloc = regAlloc;
        this.liveness = liveness;
    }

    /**
     * Emit a line with proper indentation
     */
    private void emit(String code) {
        for (int i = 0; i < indentLevel; i++) {
            output.append("  ");
        }
        output.append(code).append("\n");
    }

    /**
     * Emit a line without indentation
     */
    private void emitNoIndent(String code) {
        output.append(code).append("\n");
    }

    /**
     * Get the allocated register or spill location for a temp
     */
    private String getReg(String temp) {
        if (temp == null || !temp.startsWith("TEMP"))
            return temp;
        String allocated = regAlloc.getRegisterOrSpill(currentProcedure, temp);
        return allocated != null ? allocated : temp;
    }

    /**
     * Check if a register allocation is a spill location
     */
    private boolean isSpilled(String reg) {
        return reg != null && reg.startsWith("SPILLEDARG");
    }

    // ========== Auto class visitors ==========

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
        currentProcedure = "MAIN";

        emitNoIndent("MAIN");
        indentLevel++;

        n.f1.accept(this, argu);

        indentLevel--;
        emitNoIndent("END");
        emitNoIndent("");

        n.f3.accept(this, argu);

        return output.toString();
    }

    /**
     * f0 -> ( ( Label() )? Stmt() )*
     */
    public String visit(StmtList n, String argu) {
        if (n.f0.present()) {
            for (Enumeration<Node> e = n.f0.elements(); e.hasMoreElements();) {
                Node node = e.nextElement();
                node.accept(this, argu);
            }
        }
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
        String argCount = n.f2.accept(this, argu);

        currentProcedure = label;

        int stackSlots = regAlloc.getStackSlots(label);
        int maxCallArgs = liveness.getMaxCallArgs(label);

        emitNoIndent(label + " [" + argCount + "] [" + stackSlots + "] [" + maxCallArgs + "]");
        indentLevel++;

        n.f4.accept(this, argu);

        indentLevel--;
        emitNoIndent("END");
        emitNoIndent("");

        // Emit spill comment
        if (regAlloc.wasSpilled(label)) {
            emitNoIndent("// SPILLED");
        } else {
            emitNoIndent("// NOTSPILLED");
        }
        emitNoIndent("");

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
        // Check if there's a label before this statement
        if ("label".equals(argu)) {
            // Label was already emitted, just process the statement
            n.f0.accept(this, null);
        } else {
            n.f0.accept(this, argu);
        }
        return null;
    }

    /**
     * f0 -> "NOOP"
     */
    public String visit(NoOpStmt n, String argu) {
        emit("NOOP");
        return null;
    }

    /**
     * f0 -> "ERROR"
     */
    public String visit(ErrorStmt n, String argu) {
        emit("ERROR");
        return null;
    }

    /**
     * f0 -> "CJUMP"
     * f1 -> Temp()
     * f2 -> Label()
     */
    public String visit(CJumpStmt n, String argu) {
        String temp = n.f1.accept(this, argu);
        String label = n.f2.accept(this, argu);

        String reg = getReg(temp);
        if (isSpilled(reg)) {
            emit("ALOAD v1 " + reg);
            emit("CJUMP v1 " + label);
        } else {
            emit("CJUMP " + reg + " " + label);
        }
        return null;
    }

    /**
     * f0 -> "JUMP"
     * f1 -> Label()
     */
    public String visit(JumpStmt n, String argu) {
        String label = n.f1.accept(this, argu);
        emit("JUMP " + label);
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
        String offset = n.f2.accept(this, argu);
        String temp2 = n.f3.accept(this, argu);

        String reg1 = getReg(temp1);
        String reg2 = getReg(temp2);

        // Load spilled temps if necessary
        if (isSpilled(reg1) && isSpilled(reg2)) {
            emit("ALOAD v0 " + reg1);
            emit("ALOAD v1 " + reg2);
            emit("HSTORE v0 " + offset + " v1");
        } else if (isSpilled(reg1)) {
            emit("ALOAD v0 " + reg1);
            emit("HSTORE v0 " + offset + " " + reg2);
        } else if (isSpilled(reg2)) {
            emit("ALOAD v1 " + reg2);
            emit("HSTORE " + reg1 + " " + offset + " v1");
        } else {
            emit("HSTORE " + reg1 + " " + offset + " " + reg2);
        }
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
        String offset = n.f3.accept(this, argu);

        String destReg = getReg(dest);
        String srcReg = getReg(src);

        if (isSpilled(srcReg) && isSpilled(destReg)) {
            emit("ALOAD v0 " + srcReg);
            emit("HLOAD v1 v0 " + offset);
            emit("ASTORE " + destReg + " v1");
        } else if (isSpilled(srcReg)) {
            emit("ALOAD v0 " + srcReg);
            emit("HLOAD " + destReg + " v0 " + offset);
        } else if (isSpilled(destReg)) {
            emit("HLOAD v1 " + srcReg + " " + offset);
            emit("ASTORE " + destReg + " v1");
        } else {
            emit("HLOAD " + destReg + " " + srcReg + " " + offset);
        }
        return null;
    }

    /**
     * f0 -> "MOVE"
     * f1 -> Temp()
     * f2 -> Exp()
     */
    public String visit(MoveStmt n, String argu) {
        String dest = n.f1.accept(this, argu);
        String destReg = getReg(dest);

        // Evaluate expression - returns the result operand
        String expResult = n.f2.accept(this, "exp");

        if (expResult != null) {
            if (isSpilled(destReg)) {
                // Destination is spilled - use v0 as intermediate
                emit("MOVE v0 " + expResult);
                emit("ASTORE " + destReg + " v0");
            } else {
                emit("MOVE " + destReg + " " + expResult);
            }
        }

        return null;
    }

    /**
     * f0 -> "PRINT"
     * f1 -> SimpleExp()
     */
    public String visit(PrintStmt n, String argu) {
        String exp = n.f1.accept(this, argu);

        if (exp != null && exp.startsWith("TEMP")) {
            String reg = getReg(exp);
            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
                emit("PRINT v0");
            } else {
                emit("PRINT " + reg);
            }
        } else {
            emit("PRINT " + exp);
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

        String retVal = n.f3.accept(this, argu);
        if (retVal != null && retVal.startsWith("TEMP")) {
            String reg = getReg(retVal);
            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
            } else if (!reg.equals("v0")) {
                emit("MOVE v0 " + reg);
            }
        } else if (retVal != null) {
            emit("MOVE v0 " + retVal);
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

        // Collect arguments
        List<String> args = new ArrayList<>();
        if (n.f3.present()) {
            for (Enumeration<Node> e = n.f3.elements(); e.hasMoreElements();) {
                String temp = e.nextElement().accept(this, argu);
                args.add(temp);
            }
        }

        // Move first 4 args to a0-a3
        for (int i = 0; i < Math.min(4, args.size()); i++) {
            String temp = args.get(i);
            String reg = getReg(temp);

            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
                emit("MOVE a" + i + " v0");
            } else {
                emit("MOVE a" + i + " " + reg);
            }
        }

        // Pass extra args on stack (PASSARG is 1-based)
        for (int i = 4; i < args.size(); i++) {
            String temp = args.get(i);
            String reg = getReg(temp);

            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
                emit("PASSARG " + (i - 3) + " v0");
            } else {
                emit("PASSARG " + (i - 3) + " " + reg);
            }
        }

        // Make the call
        if (proc.startsWith("TEMP")) {
            String reg = getReg(proc);
            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
                emit("CALL v0");
            } else {
                emit("CALL " + reg);
            }
        } else {
            emit("CALL " + proc);
        }

        // Result is in v0
        return "v0";
    }

    /**
     * f0 -> "HALLOCATE"
     * f1 -> SimpleExp()
     */
    public String visit(HAllocate n, String argu) {
        String size = n.f1.accept(this, argu);

        if (size.startsWith("TEMP")) {
            String reg = getReg(size);
            if (isSpilled(reg)) {
                emit("ALOAD v0 " + reg);
                return "HALLOCATE v0";
            } else {
                return "HALLOCATE " + reg;
            }
        } else {
            return "HALLOCATE " + size;
        }
    }

    /**
     * f0 -> Operator()
     * f1 -> Temp()
     * f2 -> SimpleExp()
     */
    public String visit(BinOp n, String argu) {
        String op = n.f0.accept(this, argu);
        String temp = n.f1.accept(this, argu);
        String simpleExp = n.f2.accept(this, argu);

        String reg1 = getReg(temp);
        String reg2 = simpleExp;

        // Handle first operand
        if (isSpilled(reg1)) {
            emit("ALOAD v0 " + reg1);
            reg1 = "v0";
        }

        // Handle second operand if it's a temp
        if (simpleExp.startsWith("TEMP")) {
            reg2 = getReg(simpleExp);
            if (isSpilled(reg2)) {
                emit("ALOAD v1 " + reg2);
                reg2 = "v1";
            }
        }

        return op + " " + reg1 + " " + reg2;
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
        NodeChoice choice = (NodeChoice) n.f0;
        return choice.choice.accept(this, argu);
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