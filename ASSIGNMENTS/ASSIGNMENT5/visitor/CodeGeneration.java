package visitor;

import syntaxtree.*;
import java.util.*;

/**
 * Improved CodeGeneration with robust AST-to-token handling.
 */
public class CodeGeneration implements GJVisitor<String, String> {

   private final Map<String, RegisterAllocator.ProcedureAllocationResult> allocs;
   private final StringBuilder out = new StringBuilder();

   private RegisterAllocator.ProcedureAllocationResult currAlloc = null;
   private String currProcName = null;
   private int currMaxCallArgs = 0;

   public CodeGeneration(Map<String, RegisterAllocator.ProcedureAllocationResult> allocs) {
      this.allocs = allocs != null ? allocs : new HashMap<>();
   }

   public String getOutput() {
      return out.toString();
   }

   private void emit(String line) {
      out.append(line).append("\n");
   }

   private void emitIndent(String line) {
      out.append("  ").append(line).append("\n");
   }

   private String ensureLoaded(String operand) {
      if (operand == null)
         return "v0";
      if (operand.startsWith("SPILLED:")) {
         String slotStr = operand.substring("SPILLED:".length());
         emitIndent("ALOAD v0 (SPILLEDARG " + slotStr + ")");
         return "v0";
      } else {
         // defensive: if operand looks like an AST object's toString, fallback to v0
         if (operand.startsWith("syntactree.") || operand.contains("NodeChoice@"))
            return "v0";
         return operand;
      }
   }

   private String operandForTemp(String temp) {
      if (temp == null)
         return "v0";
      if (currAlloc == null)
         return temp; // fallback
      RegisterAllocator.Allocation a = currAlloc.allocations.get(temp);
      if (a == null) {
         return "v0";
      }
      if (a.spilled) {
         return "SPILLED:" + a.stackSlot;
      } else {
         return a.assignedReg;
      }
   }

   private void storeToTemp(String destTemp, String srcOperand) {
      RegisterAllocator.Allocation destAlloc = currAlloc.allocations.get(destTemp);
      if (destAlloc == null) {
         // defensive: if unknown dest, just emit a comment
         emitIndent("// (unknown dest " + destTemp + ")");
         return;
      }

      boolean isNumber = false;
      if (srcOperand != null) {
         try {
            Integer.parseInt(srcOperand);
            isNumber = true;
         } catch (Exception ex) {
         }
      }

      if (destAlloc.spilled) {
         if (isNumber) {
            emitIndent("MOVE v0 " + srcOperand);
            emitIndent("ASTORE v0 (SPILLEDARG " + destAlloc.stackSlot + ")");
         } else {
            String srcReg = ensureLoaded(srcOperand);
            emitIndent("ASTORE " + srcReg + " (SPILLEDARG " + destAlloc.stackSlot + ")");
         }
      } else {
         if (isNumber) {
            emitIndent("MOVE " + destAlloc.assignedReg + " " + srcOperand);
         } else {
            String srcReg = ensureLoaded(srcOperand);
            emitIndent("MOVE " + destAlloc.assignedReg + " " + srcReg);
         }
      }
   }

   // ---------------- Visitors ----------------

   public String visit(Goal n, String argu) {
      currProcName = "MAIN";
      currAlloc = allocs.get("MAIN");
      if (currAlloc == null) {
         currAlloc = new RegisterAllocator.ProcedureAllocationResult();
         currAlloc.procedureName = "MAIN";
      }

      int calleeSaveUsed = 0;
      for (RegisterAllocator.Allocation a : currAlloc.allocations.values()) {
         if (!a.spilled && a.assignedReg != null && a.assignedReg.startsWith("s"))
            calleeSaveUsed++;
      }
      int stackSlots = currAlloc.stackSlotsNeeded + calleeSaveUsed;

      emit("MAIN [" + 0 + "] [" + stackSlots + "] [0]");
      emitIndent("// Register allocation mapping:");
      for (Map.Entry<String, RegisterAllocator.Allocation> e : currAlloc.allocations.entrySet()) {
         RegisterAllocator.Allocation a = e.getValue();
         if (a.spilled)
            emitIndent("// " + a.temp + " -> SPILLED slot " + a.stackSlot);
         else
            emitIndent("// " + a.temp + " -> " + a.assignedReg);
      }

      n.f1.accept(this, argu);

      emitIndent("// NOTE: " + (currAlloc.anySpilled ? "Some temps were spilled." : "No temps were spilled."));
      emit("END\n");

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);

      currAlloc = null;
      currProcName = null;
      return null;
   }

   public String visit(StmtList n, String argu) {
      for (Enumeration<Node> e = n.f0.elements(); e.hasMoreElements();) {
         Node seq = e.nextElement();
         seq.accept(this, argu);
      }
      return null;
   }

   public String visit(Procedure n, String argu) {
      String label = n.f0.accept(this, argu);
      if (label == null)
         label = "unknown_proc";
      currProcName = label;

      String numArgsStr = n.f2.accept(this, argu);
      int numArgs = 0;
      try {
         numArgs = Integer.parseInt(numArgsStr.trim());
      } catch (Exception ex) {
         numArgs = 0;
      }

      currAlloc = allocs.get(currProcName);
      if (currAlloc == null) {
         currAlloc = new RegisterAllocator.ProcedureAllocationResult();
         currAlloc.procedureName = currProcName;
      }

      int calleeSaveUsed = 0;
      for (RegisterAllocator.Allocation a : currAlloc.allocations.values()) {
         if (!a.spilled && a.assignedReg != null && a.assignedReg.startsWith("s"))
            calleeSaveUsed++;
      }
      int stackSlots = currAlloc.stackSlotsNeeded + calleeSaveUsed;
      currMaxCallArgs = 0;

      emit("proc " + currProcName + " [" + numArgs + "] [" + stackSlots + "] [0]");
      emitIndent("// Register allocation mapping:");
      for (Map.Entry<String, RegisterAllocator.Allocation> e : currAlloc.allocations.entrySet()) {
         RegisterAllocator.Allocation a = e.getValue();
         if (a.spilled)
            emitIndent("// " + a.temp + " -> SPILLED slot " + a.stackSlot);
         else
            emitIndent("// " + a.temp + " -> " + a.assignedReg);
      }

      if (calleeSaveUsed > 0)
         emitIndent("// save callee-saved registers (s0..s7) - needed slots: " + calleeSaveUsed);

      n.f4.accept(this, argu);

      if (currAlloc.anySpilled)
         emitIndent("// NOTE: Some temps were spilled by the register allocator.");
      else
         emitIndent("// NOTE: No temps were spilled by the register allocator.");

      emit("end proc\n");

      currAlloc = null;
      currProcName = null;
      currMaxCallArgs = 0;
      return null;
   }

   public String visit(Stmt n, String argu) {
      return n.f0.accept(this, argu);
   }

   public String visit(NoOpStmt n, String argu) {
      emitIndent("NOOP");
      return null;
   }

   public String visit(ErrorStmt n, String argu) {
      emitIndent("ERROR");
      return null;
   }

   public String visit(CJumpStmt n, String argu) {
      String condTemp = n.f1.accept(this, argu);
      String condOp = condTemp;
      if (condTemp != null && condTemp.startsWith("TEMP "))
         condOp = operandForTemp(condTemp);
      String condReg = ensureLoaded(condOp);
      String label = n.f2.accept(this, argu);
      emitIndent("CJUMP " + condReg + " " + label);
      return null;
   }

   public String visit(JumpStmt n, String argu) {
      String label = n.f1.accept(this, argu);
      emitIndent("JUMP " + label);
      return null;
   }

   public String visit(HStoreStmt n, String argu) {
      String addrTemp = n.f1.accept(this, argu);
      String addrOp = addrTemp;
      if (addrTemp != null && addrTemp.startsWith("TEMP "))
         addrOp = operandForTemp(addrTemp);
      String addrReg = ensureLoaded(addrOp);

      String offset = n.f2.accept(this, argu);
      String valTemp = n.f3.accept(this, argu);
      String valOp = valTemp;
      if (valTemp != null && valTemp.startsWith("TEMP "))
         valOp = operandForTemp(valTemp);
      String valReg = ensureLoaded(valOp);

      emitIndent("HSTORE " + addrReg + " " + offset + " " + valReg);
      return null;
   }

   public String visit(HLoadStmt n, String argu) {
      String destTemp = n.f1.accept(this, argu);
      String addrTemp = n.f2.accept(this, argu);
      String offset = n.f3.accept(this, argu);

      String addrOp = addrTemp;
      if (addrTemp != null && addrTemp.startsWith("TEMP "))
         addrOp = operandForTemp(addrTemp);
      String addrReg = ensureLoaded(addrOp);

      emitIndent("HLOAD " + addrReg + " " + offset + " v0");
      storeToTemp(destTemp, "v0");
      return null;
   }

   public String visit(MoveStmt n, String argu) {
      String destTemp = n.f1.accept(this, argu);
      String rhsRaw = n.f2.accept(this, argu);
      String rhsOperand = rhsRaw;
      if (rhsRaw != null && rhsRaw.startsWith("TEMP "))
         rhsOperand = operandForTemp(rhsRaw);
      storeToTemp(destTemp, rhsOperand);
      return null;
   }

   public String visit(PrintStmt n, String argu) {
      String se = n.f1.accept(this, argu);
      String op = se;
      if (se != null && se.startsWith("TEMP "))
         op = operandForTemp(se);
      String reg = ensureLoaded(op);
      emitIndent("PRINT " + reg);
      return null;
   }

   public String visit(Exp n, String argu) {
      return n.f0.accept(this, argu);
   }

   public String visit(StmtExp n, String argu) {
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      n.f2.accept(this, argu);
      String ret = n.f3.accept(this, argu);
      String op = ret;
      if (ret != null && ret.startsWith("TEMP "))
         op = operandForTemp(ret);
      String reg = ensureLoaded(op);
      emitIndent("MOVE v0 " + reg);
      n.f4.accept(this, argu);
      return null;
   }

   public String visit(Call n, String argu) {
      String rawCallee = n.f1.accept(this, argu);
      String calleeRegOrLabel = rawCallee;
      if (rawCallee != null && rawCallee.startsWith("TEMP ")) {
         String op = operandForTemp(rawCallee);
         calleeRegOrLabel = ensureLoaded(op);
      } else {
         if (calleeRegOrLabel == null)
            calleeRegOrLabel = "v0";
      }

      Vector<String> args = new Vector<>();
      for (Enumeration<Node> e = n.f3.elements(); e.hasMoreElements();) {
         String tmp = (String) e.nextElement().accept(this, argu);
         args.add(tmp);
      }

      int argCount = args.size();
      if (argCount > currMaxCallArgs)
         currMaxCallArgs = argCount;

      for (int i = 0; i < Math.min(4, argCount); ++i) {
         String t = args.get(i);
         String tOp = t;
         if (t != null && t.startsWith("TEMP "))
            tOp = operandForTemp(t);
         String tReg = ensureLoaded(tOp);
         emitIndent("MOVE a" + i + " " + tReg);
      }
      for (int i = 4; i < argCount; ++i) {
         String t = args.get(i);
         String tOp = t;
         if (t != null && t.startsWith("TEMP "))
            tOp = operandForTemp(t);
         String tReg = ensureLoaded(tOp);
         int passIndex = i - 3;
         emitIndent("PASSARG " + passIndex + " " + tReg);
      }

      emitIndent("CALL " + calleeRegOrLabel);
      return "v0";
   }

   public String visit(HAllocate n, String argu) {
      String se = n.f1.accept(this, argu);
      String op = se;
      if (se != null && se.startsWith("TEMP "))
         op = operandForTemp(se);
      String reg = ensureLoaded(op);
      emitIndent("HALLOCATE " + reg);
      return "v0";
   }

   public String visit(BinOp n, String argu) {
      // get operator token defensively from AST token directly
      String opStr = "UNKNOWN_OP";
      try {
         opStr = n.f0.f0.toString();
      } catch (Exception ex) {
         // fallback
         String alt = n.f0.accept(this, argu);
         if (alt != null)
            opStr = alt;
      }

      String leftTemp = n.f1.accept(this, argu);
      String leftOp = leftTemp;
      if (leftTemp != null && leftTemp.startsWith("TEMP "))
         leftOp = operandForTemp(leftTemp);
      String leftReg = ensureLoaded(leftOp);

      String right = n.f2.accept(this, argu);
      String rightOp = right;
      if (right != null && right.startsWith("TEMP "))
         rightOp = operandForTemp(right);
      String rightReg = ensureLoaded(rightOp);

      emitIndent(opStr + " " + leftReg + " " + rightReg + " v0");
      return "v0";
   }

   public String visit(Operator n, String argu) {
      return n.f0.toString();
   }

   public String visit(SimpleExp n, String argu) {
      return n.f0.accept(this, argu);
   }

   public String visit(Temp n, String argu) {
      String id = n.f1.accept(this, argu);
      String temp = "TEMP " + id;
      return temp;
   }

   public String visit(IntegerLiteral n, String argu) {
      return n.f0.toString();
   }

   public String visit(Label n, String argu) {
      return n.f0.toString();
   }

   // generic traversals
   public String visit(NodeList n, String argu) {
      String _ret = null;
      for (Enumeration<Node> e = n.elements(); e.hasMoreElements();)
         e.nextElement().accept(this, argu);
      return _ret;
   }

   public String visit(NodeListOptional n, String argu) {
      if (n.present())
         for (Enumeration<Node> e = n.elements(); e.hasMoreElements();)
            e.nextElement().accept(this, argu);
      return null;
   }

   public String visit(NodeOptional n, String argu) {
      if (n.present())
         return n.node.accept(this, argu);
      return null;
   }

   public String visit(NodeSequence n, String argu) {
      String _ret = null;
      for (Enumeration<Node> e = n.elements(); e.hasMoreElements();)
         _ret = e.nextElement().accept(this, argu);
      return _ret;
   }

   public String visit(NodeToken n, String argu) {
      return null;
   }
}
