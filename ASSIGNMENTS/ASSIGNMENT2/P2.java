import syntaxtree.*;
import visitor.*;

public class P2 {
    public static void main(String[] args) {
        try {
            Goal root = new MiniJavaParser(System.in).Goal();
            // Invoke the parser, match the Goal production and return the
            // syntax tree.

            // System.out.println("Program parsed successfully");

            SymbolTableBuilder v = new SymbolTableBuilder();
            // create a visitor.

            try {
                root.accept(v);
            } catch (SymbolTableBuilder.TypeError e) {
                System.out.println(e.getMessage());
                return;
            }
            // for (Map.Entry<String, ClassInfo> i : v.ST.classes.entrySet()) {
            // System.out.println(i.getKey());
            // ClassInfo c1 = i.getValue();
            // for (Map.Entry<String, MethodInfo> j : c1.methods.entrySet()) {
            // System.out.println(j.getValue().name);
            // }
            // }
            TypeChecker typeChecker = new TypeChecker(v.ST);

            try {
                root.accept(typeChecker, typeChecker.currScope);
                System.out.println("Program type checked successfully");
            } catch (TypeChecker.SymbolError e) {
                System.out.println(e.getMessage());
                return;
            } catch (TypeChecker.TypeError e) {
                System.out.println(e.getMessage());
                // System.out.println(e.getClass());
                return;
            }
        } catch (ParseException e) {
            System.out.println(e.toString());
        }
    }
}
