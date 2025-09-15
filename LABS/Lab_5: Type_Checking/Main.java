import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         Goal root = new MiniExpr(System.in).Goal();
	 // Invoke the parser, match the Goal production and return the
	 // syntax tree.

         System.out.println("Program parsed successfully");


	TypeChecker v = new TypeChecker();
	 //create a visitor.

         // root.accept((GJVisitor<visitor.Type,Object>) v);
         v.visit(root,null);
	 // pass the visitor to each syntax tree node.
	 System.out.println("Error = "+v.error);
    System.out.println(v.vartable);

      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}
