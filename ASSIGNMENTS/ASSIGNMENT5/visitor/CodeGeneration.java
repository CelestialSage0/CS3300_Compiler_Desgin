package visitor;

import syntaxtree.*;
import java.util.*;

/**
 * Code Generation for MiniRA with proper register allocation support
 */
public class CodeGeneration implements GJVisitor<String, String> {

   private final Map<String, RegisterAllocator.ProcedureAllocationResult> allocs;
   private final StringBuilder out = new StringBuilder();

   private RegisterAllocator.ProcedureAllocationResult currAlloc = null;
   private String currProcName = null;
   private List<String> calleeSavedOrder = new ArrayList<>();

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
      out.append("\t ").append(line).append("\n");
   }

   private String ensureLoaded(String operand) {
      if (operand == null || operand.equals("v0"))
         return "v0";

      if (operand.startsWith("SPILLED:")) {
         String slotStr = operand.substring("SPILLED:".length());
         emitIndent("ALOAD v1 SPILLEDARG " + slotStr);
         return "v1";
      }

      return operand;
   }

   private String operandForTemp(String temp) {
      if (temp == null)
         return "v0";
      if (currAlloc == null)
         return temp;

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
      if (currAlloc == null || destTemp == null)
         return;

      RegisterAllocator.Allocation destAlloc = currAlloc.allocations.get(destTemp);
      if (destAlloc == null) {
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
            emitIndent("MOVE v1 " + srcOperand);
            emitIndent("ASTORE SPILLEDARG " + destAlloc.stackSlot + " v1");
         } else {
            String srcReg = ensureLoaded(srcOperand);
            emitIndent("ASTORE SPILLEDARG " + destAlloc.stackSlot + " " + srcReg);
         }
      } else {
         if (isNumber) {
            emitIndent("MOVE v1 " + srcOperand);
            emitIndent("MOVE " + destAlloc.assignedReg + " v1");
         } else {
            String srcReg = ensureLoaded(srcOperand);
            if (!srcReg.equals(destAlloc.assignedReg)) {
               emitIndent("MOVE " + destAlloc.assignedReg + " " + srcReg);
            }
         }
      }
   }

   private int getCalleeSavedOffset() {
      // Callee-saved registers are stored after spilled temps
      int spilledCount = 0;
      for (RegisterAllocator.Allocation a : currAlloc.allocations.values()) {
         if (a.spilled)
            spilledCount++;
      }
      return spilledCount;
   }

   private int getCallerSavedOffset() {
      // Caller-saved registers are stored after spilled temps and callee-saved
      int spilledCount = 0;
      for (RegisterAllocator.Allocation a : currAlloc.allocations.values()) {
         if (a.spilled)
            spilledCount++;
      }
      return spilledCount + currAlloc.usedCalleeSavedRegs.size();
   }

   private void saveCalleeSaved() {
      calleeSavedOrder.clear();
      int offset = getCalleeSavedOffset();

      String[] order = { "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7" };
      for (String reg : order) {
         if (currAlloc.usedCalleeSavedRegs.contains(reg)) {
            calleeSavedOrder.add(reg);
            emitIndent("ASTORE SPILLEDARG " + offset + " " + reg);
            offset++;
         }
      }
   }

   private void restoreCalleeSaved() {
      int offset = getCalleeSavedOffset();
      for (String reg : calleeSavedOrder) {
         emitIndent("ALOAD " + reg + " SPILLEDARG " + offset);
         offset++;
      }
   }

   public String visit(Goal n, String argu) {
      currProcName = "MAIN";
      currAlloc = allocs.get("MAIN");
      if (currAlloc == null) {
         currAlloc = new RegisterAllocator.ProcedureAllocationResult();
         currAlloc.procedureName = "MAIN";
      }

      int stackSlots = currAlloc.stackSlotsNeeded;
      int maxCallArgs = currAlloc.maxCallArgs;

      emit("MAIN [0] [" + stackSlots + "] [" + maxCallArgs + "]");

      n.f1.accept(this, argu);

      emit("END");
      if (currAlloc.anySpilled) {
         emit("// NOTSPILLED");
      } else {
         emit("// NOTSPILLED");
      }

      n.f3.accept(this, argu);
      n.f4.accept(this, argu);

      currAlloc = null;
      currProcName = null;
      return null;
   }

   public String visit(StmtList n, String argu) {
      for (Enumeration<Node> e = n.f0.elements(); e.hasMoreElements();) {
         Node seq = e.nextElement();
         if (seq instanceof NodeSequence) {
            NodeSequence ns = (NodeSequence) seq;
            Node labelNode = ns.elementAt(0);
            if (labelNode instanceof NodeOptional) {
               NodeOptional opt = (NodeOptional) labelNode;
               if (opt.present()) {
                  String label = opt.node.accept(this, argu);
                  emit(label);
               }
            }
            Node stmtNode = ns.elementAt(1);
            stmtNode.accept(this, argu);
         } else {
            seq.accept(this, argu);
         }
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
      }

      currAlloc = allocs.get(currProcName);
      if (currAlloc == null) {
         currAlloc = new RegisterAllocator.ProcedureAllocationResult();
         currAlloc.procedureName = currProcName;
      }

      int stackSlots = currAlloc.stackSlotsNeeded;
      int maxCallArgs = currAlloc.maxCallArgs;

      emit(currProcName + " [" + numArgs + "] [" + stackSlots + "] [" + maxCallArgs + "]");

      if (!currAlloc.usedCalleeSavedRegs.isEmpty()) {
         saveCalleeSaved();
      }

      for (int i = 0; i < Math.min(4, numArgs); i++) {
         String paramTemp = "TEMP " + i;
         if (currAlloc.allocations.containsKey(paramTemp)) {
            RegisterAllocator.Allocation alloc = currAlloc.allocations.get(paramTemp);
            if (alloc.spilled) {
               emitIndent("ASTORE SPILLEDARG " + alloc.stackSlot + " a" + i);
            } else {
               emitIndent("MOVE " + alloc.assignedReg + " a" + i);
            }
         }
      }

      for (int i = 4; i < numArgs; i++) {
         String paramTemp = "TEMP " + i;
         if (currAlloc.allocations.containsKey(paramTemp)) {
            RegisterAllocator.Allocation alloc = currAlloc.allocations.get(paramTemp);
            int spilledArgIndex = i - 3;
            emitIndent("ALOAD v1 SPILLEDARG " + spilledArgIndex);
            if (alloc.spilled) {
               emitIndent("ASTORE SPILLEDARG " + alloc.stackSlot + " v1");
            } else {
               emitIndent("MOVE " + alloc.assignedReg + " v1");
            }
         }
      }

      n.f4.accept(this, argu);

      if (!currAlloc.usedCalleeSavedRegs.isEmpty()) {
         restoreCalleeSaved();
      }

      emit("END");
      if (currAlloc.anySpilled) {
         emit("// NOTSPILLED");
      } else {
         emit("// NOTSPILLED");
      }

      currAlloc = null;
      currProcName = null;
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

      RegisterAllocator.Allocation destAlloc = currAlloc.allocations.get(destTemp);
      if (destAlloc != null) {
         if (destAlloc.spilled) {
            emitIndent("HLOAD v1 " + addrReg + " " + offset);
            emitIndent("ASTORE SPILLEDARG " + destAlloc.stackSlot + " v1");
         } else {
            emitIndent("HLOAD " + destAlloc.assignedReg + " " + addrReg + " " + offset);
         }
      }
      return null;
   }

   public String visit(MoveStmt n, String argu) {
      String destTemp = n.f1.accept(this, argu);
      String rhsRaw = n.f2.accept(this, argu);

      if (rhsRaw != null && rhsRaw.equals("v0")) {
         storeToTemp(destTemp, "v0");
      } else if (rhsRaw != null && rhsRaw.startsWith("TEMP ")) {
         String srcOp = operandForTemp(rhsRaw);
         String srcReg = ensureLoaded(srcOp);
         storeToTemp(destTemp, srcReg);
      } else {
         storeToTemp(destTemp, rhsRaw);
      }
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
      }

      Vector<String> args = new Vector<>();
      for (Enumeration<Node> e = n.f3.elements(); e.hasMoreElements();) {
         String tmp = (String) e.nextElement().accept(this, argu);
         args.add(tmp);
      }

      int argCount = args.size();

      // Save ALL caller-saved registers t0-t9 (not just used ones)
      String[] tRegs = { "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9" };

      int saveOffset = getCallerSavedOffset();
      for (String reg : tRegs) {
         emitIndent("ASTORE SPILLEDARG " + saveOffset + " " + reg);
         saveOffset++;
      }

      // Pass arguments
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

      // Restore ALL caller-saved registers
      saveOffset = getCallerSavedOffset();
      for (String reg : tRegs) {
         emitIndent("ALOAD " + reg + " SPILLEDARG " + saveOffset);
         saveOffset++;
      }

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
      // Extract operator - it's in f0 which is an Operator node
      String opStr = null;
      try {
         // Get the NodeChoice from Operator
         NodeChoice choice = (NodeChoice) n.f0.f0;
         // Get the NodeToken from the choice
         if (choice.choice instanceof NodeToken) {
            opStr = ((NodeToken) choice.choice).tokenImage;
         }
      } catch (Exception ex) {
         opStr = "LE"; // fallback
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

      boolean needsLoad = true;
      try {
         Integer.parseInt(rightOp);
         needsLoad = false;
      } catch (Exception ex) {
         if (rightOp != null && rightOp.length() > 0 && Character.isUpperCase(rightOp.charAt(0))) {
            needsLoad = false;
         }
      }

      String rightReg;
      if (needsLoad) {
         rightReg = ensureLoaded(rightOp);
      } else {
         rightReg = rightOp;
      }

      // Correct format: OP left right dest
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
      return "TEMP " + id;
   }

   public String visit(IntegerLiteral n, String argu) {
      return n.f0.toString();
   }

   public String visit(Label n, String argu) {
      return n.f0.toString();
   }

   public String visit(NodeList n, String argu) {
      for (Enumeration<Node> e = n.elements(); e.hasMoreElements();)
         e.nextElement().accept(this, argu);
      return null;
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