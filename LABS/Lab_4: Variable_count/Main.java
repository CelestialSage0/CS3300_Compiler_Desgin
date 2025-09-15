import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
	 // Invoke the parser, match the Goal production and return the
	 // syntax tree.

         System.out.println("Program parsed successfully");


	DepthFirstVisitor v = new DepthFirstVisitor();
	 //create a visitor.

         root.accept(v);
	 // pass the visitor to each syntax tree node.
	 System.out.println("CLASS VARIABLES = "+v.class_vars);
	 System.out.println("CLASS METHODS = "+v.class_methods);
	 System.out.println("METHOD VARIABLES = "+v.methods_vars);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}

