import syntaxtree.*;
import visitor.*;

public class P6 {
    public static void main(String[] args) {
        try {
            Node root = new MiniRAParser(System.in).Goal();

            CodeGeneration CG = new CodeGeneration();
            root.accept(CG, null);
        } catch (ParseException e) {
            System.err.println("Parse error: " + e.getMessage());
            System.exit(1);
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}
