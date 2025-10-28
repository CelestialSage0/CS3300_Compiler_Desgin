import syntaxtree.*;
import visitor.*;

public class P4 {
    public static void main(String[] args) {
        try {
            Goal root = new MiniIRParser(System.in).Goal();
            // Invoke the parser, match the Goal production and return the
            // syntax tree.

            // System.out.println("Program parsed successfully");
            GJDepthFirst v = new GJDepthFirst();

            root.accept(v, null);

        } catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}