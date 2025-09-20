import syntaxtree.*;
import visitor.*;

public class Main {
    public static void main(String[] args) {
        try {
            Goal root = new MiniJavaParser(System.in).Goal();
            // Invoke the parser, match the Goal production and return the
            // syntax tree.

            System.out.println("Program parsed successfully");

            DepthFirstVisitor v = new DepthFirstVisitor();
            // create a visitor.

            root.accept(v);
        } catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}
