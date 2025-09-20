import syntaxtree.*;
import visitor.GJDepthFirst;
import java.util.*;

public class TypeChecker extends GJDepthFirst<String, TypeChecker.Context> {

    // Use the data structures from SymbolTableBuilder
    private SymbolTableBuilder.SymbolTable symbolTable;

    // Context for type checking - this is where GJDepthFirst shines
    public static class Context {
        SymbolTableBuilder.ClassInfo currentClass;
        SymbolTableBuilder.MethodInfo currentMethod;
        boolean hasError;

        public Context() {
            this.hasError = false;
        }

        public void reportError() {
            this.hasError = true;
        }
    }

    private Context globalContext;

    public TypeChecker(SymbolTableBuilder.SymbolTable symbolTable) {
        this.symbolTable = symbolTable;
        this.globalContext = new Context();
    }

    public boolean hasError() {
        return globalContext.hasError;
    }

    private boolean isValidType(String type) {
        if (type == null)
            return false;

        // Basic types
        if (type.equals("int") || type.equals("boolean") || type.equals("int[]")) {
            return true;
        }

        // Lambda types - Function<T,U>
        if (type.startsWith("Function<") && type.endsWith(">")) {
            // Check if import is present
            if (!symbolTable.hasImport()) {
                return false;
            }

            // Extract types from Function<T,U>
            String inner = type.substring(9, type.length() - 1); // Remove "Function<" and ">"
            String[] parts = inner.split(",");
            if (parts.length != 2)
                return false;

            String inputType = parts[0].trim();
            String outputType = parts[1].trim();

            return isValidType(inputType) && isValidType(outputType);
        }

        // Class types
        return symbolTable.hasClass(type);
    }

    private boolean areTypesCompatible(String type1, String type2) {
        if (type1 == null || type2 == null)
            return false;
        if (type1.equals(type2))
            return true;

        // Check inheritance for class types
        if (symbolTable.hasClass(type1) && symbolTable.hasClass(type2)) {
            return symbolTable.isSubtype(type1, type2);
        }

        return false;
    }

    // Goal -> (ImportFunction)? MainClass ( TypeDeclaration )* <EOF>
    public String visit(Goal n, Context ctx) {
        // Skip import if present
        n.f1.accept(this, ctx); // MainClass
        if (!ctx.hasError) {
            n.f2.accept(this, ctx); // TypeDeclaration*
        }
        return null;
    }

    // MainClass -> "class" Identifier "{" "public" "static" "void" "main" "("
    // "String" "[" "]" Identifier ")" "{" PrintStatement "}" "}"
    public String visit(MainClass n, Context ctx) {
        String className = n.f1.accept(this, ctx);
        ctx.currentClass = symbolTable.getClass(className);
        ctx.currentMethod = ctx.currentClass.getMethod("main");

        // Process the print statement in main
        n.f14.accept(this, ctx);

        ctx.currentMethod = null;
        ctx.currentClass = null;

        return null;
    }

    // ClassDeclaration -> "class" Identifier "{" ( VarDeclaration )* (
    // MethodDeclaration )* "}"
    public String visit(ClassDeclaration n, Context ctx) {
        String className = n.f1.accept(this, ctx);
        ctx.currentClass = symbolTable.getClass(className);

        // Check field types
        for (String fieldName : ctx.currentClass.getFieldNames()) {
            String fieldType = ctx.currentClass.getField(fieldName);
            if (!isValidType(fieldType)) {
                ctx.reportError();
                return null;
            }
        }

        // Process methods
        n.f4.accept(this, ctx);

        ctx.currentClass = null;
        return null;
    }

    // ClassExtendsDeclaration -> "class" Identifier "extends" Identifier "{" (
    // VarDeclaration )* ( MethodDeclaration )* "}"
    public String visit(ClassExtendsDeclaration n, Context ctx) {
        String className = n.f1.accept(this, ctx);
        ctx.currentClass = symbolTable.getClass(className);

        // Check field types
        for (String fieldName : ctx.currentClass.getFieldNames()) {
            String fieldType = ctx.currentClass.getField(fieldName);
            if (!isValidType(fieldType)) {
                ctx.reportError();
                return null;
            }
        }

        // Process methods
        n.f6.accept(this, ctx);

        ctx.currentClass = null;
        return null;
    }

    // MethodDeclaration -> "public" Type Identifier "(" ( FormalParameterList )?
    // ")" "{" ( VarDeclaration )* ( Statement )* "return" Expression ";" "}"
    public String visit(MethodDeclaration n, Context ctx) {
        String returnType = n.f1.accept(this, ctx);
        String methodName = n.f2.accept(this, ctx);

        ctx.currentMethod = ctx.currentClass.getMethod(methodName);

        // Check return type is valid
        if (!isValidType(returnType)) {
            ctx.reportError();
            return null;
        }

        // Check parameter types
        for (String paramType : ctx.currentMethod.getParameterTypes()) {
            if (!isValidType(paramType)) {
                ctx.reportError();
                return null;
            }
        }

        // Process statements
        n.f8.accept(this, ctx);

        // Check return expression
        if (!ctx.hasError) {
            String returnExprType = n.f10.accept(this, ctx);
            if (returnExprType == null || !areTypesCompatible(returnExprType, returnType)) {
                ctx.reportError();
            }
        }

        ctx.currentMethod = null;
        return null;
    }

    // Statement -> Block | AssignmentStatement | ArrayAssignmentStatement |
    // IfStatement | WhileStatement | PrintStatement
    public String visit(Statement n, Context ctx) {
        return n.f0.accept(this, ctx);
    }

    // Block -> "{" ( Statement )* "}"
    public String visit(Block n, Context ctx) {
        n.f1.accept(this, ctx);
        return null;
    }

    // AssignmentStatement -> Identifier "=" Expression ";"
    public String visit(AssignmentStatement n, Context ctx) {
        String varName = n.f0.accept(this, ctx);
        String varType = getVariableType(varName, ctx);

        if (varType == null) {
            ctx.reportError();
            return null;
        }

        String exprType = n.f2.accept(this, ctx);
        if (exprType == null || !areTypesCompatible(exprType, varType)) {
            ctx.reportError();
        }

        return null;
    }

    // ArrayAssignmentStatement -> Identifier "[" Expression "]" "=" Expression ";"
    public String visit(ArrayAssignmentStatement n, Context ctx) {
        String varName = n.f0.accept(this, ctx);
        String varType = getVariableType(varName, ctx);

        if (varType == null) {
            ctx.reportError();
            return null;
        }

        if (!varType.equals("int[]")) {
            ctx.reportError();
            return null;
        }

        String indexType = n.f2.accept(this, ctx);
        if (indexType == null || !indexType.equals("int")) {
            ctx.reportError();
            return null;
        }

        String valueType = n.f5.accept(this, ctx);
        if (valueType == null || !valueType.equals("int")) {
            ctx.reportError();
        }

        return null;
    }

    // IfStatement -> IfthenElseStatement | IfthenStatement
    public String visit(IfStatement n, Context ctx) {
        return n.f0.accept(this, ctx);
    }

    // IfthenStatement -> "if" "(" Expression ")" Statement
    public String visit(IfthenStatement n, Context ctx) {
        String conditionType = n.f2.accept(this, ctx);
        if (conditionType == null || !conditionType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        n.f4.accept(this, ctx); // then statement

        return null;
    }

    // IfthenElseStatement -> "if" "(" Expression ")" Statement "else" Statement
    public String visit(IfthenElseStatement n, Context ctx) {
        String conditionType = n.f2.accept(this, ctx);
        if (conditionType == null || !conditionType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        n.f4.accept(this, ctx); // then statement
        n.f6.accept(this, ctx); // else statement

        return null;
    }

    // WhileStatement -> "while" "(" Expression ")" Statement
    public String visit(WhileStatement n, Context ctx) {
        String conditionType = n.f2.accept(this, ctx);
        if (conditionType == null || !conditionType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        n.f4.accept(this, ctx); // body statement

        return null;
    }

    // PrintStatement -> "System.out.println" "(" Expression ")" ";"
    public String visit(PrintStatement n, Context ctx) {
        String exprType = n.f2.accept(this, ctx);
        if (exprType == null || !exprType.equals("int")) {
            ctx.reportError();
        }

        return null;
    }

    // Expression -> OrExpression | AndExpression | CompareExpression |
    // neqExpression | AddExpression | MinusExpression | TimesExpression |
    // DivExpression | ArrayLookup | ArrayLength | MessageSend | LambdaExpression |
    // PrimaryExpression
    public String visit(Expression n, Context ctx) {
        return n.f0.accept(this, ctx);
    }

    // LambdaExpression -> "(" Identifier ")" "->" Expression
    public String visit(LambdaExpression n, Context ctx) {
        // Check if Function import is present
        if (!symbolTable.hasImport()) {
            ctx.reportError();
            return null;
        }

        String paramName = n.f1.accept(this, ctx);
        String bodyType = n.f4.accept(this, ctx);

        if (bodyType == null) {
            ctx.reportError();
            return null;
        }

        // For now, we'll assume the parameter type is inferred from context
        // This is simplified - a full implementation would need type inference
        return "Function<int," + bodyType + ">";
    }

    // OrExpression -> PrimaryExpression "||" PrimaryExpression
    public String visit(OrExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("boolean") || !rightType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        return "boolean";
    }

    // AndExpression -> PrimaryExpression "&&" PrimaryExpression
    public String visit(AndExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("boolean") || !rightType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        return "boolean";
    }

    // CompareExpression -> PrimaryExpression "<=" PrimaryExpression
    public String visit(CompareExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("int") || !rightType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "boolean";
    }

    // neqExpression -> PrimaryExpression "!=" PrimaryExpression
    public String visit(neqExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        // != can work on int, boolean, or object types
        if (leftType == null || rightType == null) {
            ctx.reportError();
            return null;
        }

        // Both operands must be of compatible types
        if (!areTypesCompatible(leftType, rightType) && !areTypesCompatible(rightType, leftType)) {
            ctx.reportError();
            return null;
        }

        return "boolean";
    }

    // AddExpression -> PrimaryExpression "+" PrimaryExpression
    public String visit(AddExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("int") || !rightType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // MinusExpression -> PrimaryExpression "-" PrimaryExpression
    public String visit(MinusExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("int") || !rightType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // TimesExpression -> PrimaryExpression "*" PrimaryExpression
    public String visit(TimesExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("int") || !rightType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // DivExpression -> PrimaryExpression "/" PrimaryExpression
    public String visit(DivExpression n, Context ctx) {
        String leftType = n.f0.accept(this, ctx);
        String rightType = n.f2.accept(this, ctx);

        if (leftType == null || rightType == null ||
                !leftType.equals("int") || !rightType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // ArrayLookup -> PrimaryExpression "[" PrimaryExpression "]"
    public String visit(ArrayLookup n, Context ctx) {
        String arrayType = n.f0.accept(this, ctx);
        String indexType = n.f2.accept(this, ctx);

        if (arrayType == null || !arrayType.equals("int[]")) {
            ctx.reportError();
            return null;
        }

        if (indexType == null || !indexType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // ArrayLength -> PrimaryExpression "." "length"
    public String visit(ArrayLength n, Context ctx) {
        String arrayType = n.f0.accept(this, ctx);

        if (arrayType == null || !arrayType.equals("int[]")) {
            ctx.reportError();
            return null;
        }

        return "int";
    }

    // MessageSend -> PrimaryExpression "." Identifier "(" ( ExpressionList )? ")"
    public String visit(MessageSend n, Context ctx) {
        String objectType = n.f0.accept(this, ctx);
        String methodName = n.f2.accept(this, ctx);

        if (objectType == null || !symbolTable.hasClass(objectType)) {
            ctx.reportError();
            return null;
        }

        SymbolTableBuilder.MethodInfo method = symbolTable.lookupMethod(objectType, methodName);
        if (method == null) {
            ctx.reportError();
            return null;
        }

        // Check arguments
        List<String> argTypes = new ArrayList<>();
        if (n.f4.present()) {
            ExpressionList exprList = (ExpressionList) n.f4.node;
            argTypes = getExpressionListTypes(exprList, ctx);
            if (ctx.hasError)
                return null;
        }

        List<String> paramTypes = method.getParameterTypes();
        if (argTypes.size() != paramTypes.size()) {
            ctx.reportError();
            return null;
        }

        for (int i = 0; i < argTypes.size(); i++) {
            if (!areTypesCompatible(argTypes.get(i), paramTypes.get(i))) {
                ctx.reportError();
                return null;
            }
        }

        return method.getReturnType();
    }

    // PrimaryExpression -> IntegerLiteral | TrueLiteral | FalseLiteral | Identifier
    // | ThisExpression | ArrayAllocationExpression | AllocationExpression |
    // NotExpression | BracketExpression
    public String visit(PrimaryExpression n, Context ctx) {
        return n.f0.accept(this, ctx);
    }

    // IntegerLiteral -> <INTEGER_LITERAL>
    public String visit(IntegerLiteral n, Context ctx) {
        return "int";
    }

    // TrueLiteral -> "true"
    public String visit(TrueLiteral n, Context ctx) {
        return "boolean";
    }

    // FalseLiteral -> "false"
    public String visit(FalseLiteral n, Context ctx) {
        return "boolean";
    }

    // Identifier -> <IDENTIFIER>
    public String visit(Identifier n, Context ctx) {
        String varName = n.f0.toString();
        String type = getVariableType(varName, ctx);

        if (type == null) {
            ctx.reportError();
            return null;
        }

        return type;
    }

    // ThisExpression -> "this"
    public String visit(ThisExpression n, Context ctx) {
        if (ctx.currentClass == null) {
            ctx.reportError();
            return null;
        }

        return ctx.currentClass.getClassName();
    }

    // ArrayAllocationExpression -> "new" "int" "[" Expression "]"
    public String visit(ArrayAllocationExpression n, Context ctx) {
        String sizeType = n.f3.accept(this, ctx);

        if (sizeType == null || !sizeType.equals("int")) {
            ctx.reportError();
            return null;
        }

        return "int[]";
    }

    // AllocationExpression -> "new" Identifier "(" ")"
    public String visit(AllocationExpression n, Context ctx) {
        String className = n.f1.accept(this, ctx);

        if (!symbolTable.hasClass(className)) {
            ctx.reportError();
            return null;
        }

        return className;
    }

    // NotExpression -> "!" Expression
    public String visit(NotExpression n, Context ctx) {
        String exprType = n.f1.accept(this, ctx);

        if (exprType == null || !exprType.equals("boolean")) {
            ctx.reportError();
            return null;
        }

        return "boolean";
    }

    // BracketExpression -> "(" Expression ")"
    public String visit(BracketExpression n, Context ctx) {
        return n.f1.accept(this, ctx);
    }

    // ExpressionList -> Expression ( ExpressionRest )*
    public String visit(ExpressionList n, Context ctx) {
        // This method is not called directly but through getExpressionListTypes
        return null;
    }

    // Helper method to get types of expression list
    private List<String> getExpressionListTypes(ExpressionList exprList, Context ctx) {
        List<String> types = new ArrayList<>();

        // First expression
        String firstType = exprList.f0.accept(this, ctx);
        if (firstType == null) {
            ctx.reportError();
            return types;
        }
        types.add(firstType);

        // Rest of expressions
        for (int i = 0; i < exprList.f1.size(); i++) {
            ExpressionRest exprRest = (ExpressionRest) exprList.f1.elementAt(i);
            String type = exprRest.f1.accept(this, ctx);
            if (type == null) {
                ctx.reportError();
                return types;
            }
            types.add(type);
        }

        return types;
    }

    // Helper method to get variable type from current scope
    private String getVariableType(String varName, Context ctx) {
        // Check method variables (parameters and locals)
        if (ctx.currentMethod != null) {
            String type = ctx.currentMethod.getVariableType(varName);
            if (type != null)
                return type;
        }

        // Check class fields (including inherited)
        if (ctx.currentClass != null) {
            String type = symbolTable.lookupField(ctx.currentClass.getClassName(), varName);
            if (type != null)
                return type;
        }

        return null;
    }

    // Type visitors that return type strings
    public String visit(Type n, Context ctx) {
        return n.f0.accept(this, ctx);
    }

    public String visit(ArrayType n, Context ctx) {
        return "int[]";
    }

    public String visit(BooleanType n, Context ctx) {
        return "boolean";
    }

    public String visit(IntegerType n, Context ctx) {
        return "int";
    }

    public String visit(LambdaType n, Context ctx) {
        String inputType = n.f2.accept(this, ctx);
        String outputType = n.f4.accept(this, ctx);
        return "Function<" + inputType + "," + outputType + ">";
    }

    // Override the default visit to pass global context
    public String visit(Goal n) {
        return visit(n, globalContext);
    }
}