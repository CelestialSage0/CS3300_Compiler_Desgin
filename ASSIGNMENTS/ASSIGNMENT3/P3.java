import syntaxtree.*;
import visitor.*;

public class P3 {
    public static void main(String[] args) {
        try {
            Goal root = new MiniJavaParser(System.in).Goal();
            // Invoke the parser, match the Goal production and return the
            // syntax tree.

            // System.out.println("Program parsed successfully");

        } catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}
