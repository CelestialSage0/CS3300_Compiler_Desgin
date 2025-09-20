import syntaxtree.*;
import visitor.GJNoArguVisitor;
import java.util.*;

public class SymbolTableBuilder extends GJNoArguVisitor<String> {

    // Inner classes for data structures
    public static class ClassInfo {
        private String className;
        private String parentClass;
        private Map<String, String> fields;
        private Map<String, MethodInfo> methods;

        public ClassInfo(String className) {
            this.className = className;
            this.fields = new LinkedHashMap<>();
            this.methods = new HashMap<>();
            this.parentClass = null;
        }

        public ClassInfo(String className, String parentClass) {
            this(className);
            this.parentClass = parentClass;
        }

        // Getters and methods
        public String getClassName() {
            return className;
        }

        public String getParentClass() {
            return parentClass;
        }

        public void setParentClass(String parentClass) {
            this.parentClass = parentClass;
        }

        public void addField(String fieldName, String type) {
            fields.put(fieldName, type);
        }

        public String getField(String fieldName) {
            return fields.get(fieldName);
        }

        public boolean hasField(String fieldName) {
            return fields.containsKey(fieldName);
        }

        public Set<String> getFieldNames() {
            return fields.keySet();
        }

        public void addMethod(String methodName, MethodInfo method) {
            methods.put(methodName, method);
        }

        public MethodInfo getMethod(String methodName) {
            return methods.get(methodName);
        }

        public boolean hasMethod(String methodName) {
            return methods.containsKey(methodName);
        }

        public Set<String> getMethodNames() {
            return methods.keySet();
        }
    }

    public static class MethodInfo {
        private String methodName;
        private String returnType;
        private List<String> parameterTypes;
        private List<String> parameterNames;
        private Map<String, String> localVariables;

        public MethodInfo(String methodName, String returnType) {
            this.methodName = methodName;
            this.returnType = returnType;
            this.parameterTypes = new ArrayList<>();
            this.parameterNames = new ArrayList<>();
            this.localVariables = new HashMap<>();
        }

        // Getters and methods
        public String getMethodName() {
            return methodName;
        }

        public String getReturnType() {
            return returnType;
        }

        public void addParameter(String paramName, String paramType) {
            parameterNames.add(paramName);
            parameterTypes.add(paramType);
        }

        public List<String> getParameterTypes() {
            return new ArrayList<>(parameterTypes);
        }

        public List<String> getParameterNames() {
            return new ArrayList<>(parameterNames);
        }

        public int getParameterCount() {
            return parameterTypes.size();
        }

        public String getParameterType(int index) {
            if (index >= 0 && index < parameterTypes.size()) {
                return parameterTypes.get(index);
            }
            return null;
        }

        public void addLocalVariable(String varName, String varType) {
            localVariables.put(varName, varType);
        }

        public String getLocalVariable(String varName) {
            return localVariables.get(varName);
        }

        public boolean hasLocalVariable(String varName) {
            return localVariables.containsKey(varName);
        }

        public String getVariableType(String varName) {
            // Check parameters first
            for (int i = 0; i < parameterNames.size(); i++) {
                if (parameterNames.get(i).equals(varName)) {
                    return parameterTypes.get(i);
                }
            }
            // Check local variables
            return localVariables.get(varName);
        }

        public boolean hasVariable(String varName) {
            return parameterNames.contains(varName) || localVariables.containsKey(varName);
        }

        public boolean isCompatibleWith(MethodInfo other) {
            if (!this.returnType.equals(other.returnType))
                return false;
            if (this.parameterTypes.size() != other.parameterTypes.size())
                return false;

            for (int i = 0; i < parameterTypes.size(); i++) {
                if (!this.parameterTypes.get(i).equals(other.parameterTypes.get(i))) {
                    return false;
                }
            }
            return true;
        }
    }

    public static class SymbolTable {
        private Map<String, ClassInfo> classes;
        private String mainClassName;
        private boolean hasImport;

        public SymbolTable() {
            classes = new HashMap<>();
            hasImport = false;
        }

        public void addClass(String className, ClassInfo classInfo) {
            classes.put(className, classInfo);
        }

        public ClassInfo getClass(String className) {
            return classes.get(className);
        }

        public boolean hasClass(String className) {
            return classes.containsKey(className);
        }

        public void setMainClassName(String mainClassName) {
            this.mainClassName = mainClassName;
        }

        public String getMainClassName() {
            return mainClassName;
        }

        public Set<String> getClassNames() {
            return classes.keySet();
        }

        public void setHasImport(boolean hasImport) {
            this.hasImport = hasImport;
        }

        public boolean hasImport() {
            return hasImport;
        }

        public boolean isSubtype(String class1, String class2) {
            if (class1.equals(class2))
                return true;

            ClassInfo c1 = getClass(class1);
            if (c1 == null)
                return false;

            String parent = c1.getParentClass();
            while (parent != null) {
                if (parent.equals(class2))
                    return true;
                ClassInfo parentInfo = getClass(parent);
                if (parentInfo == null)
                    break;
                parent = parentInfo.getParentClass();
            }
            return false;
        }

        public MethodInfo lookupMethod(String className, String methodName) {
            ClassInfo classInfo = getClass(className);
            if (classInfo == null)
                return null;

            MethodInfo method = classInfo.getMethod(methodName);
            if (method != null)
                return method;

            String parent = classInfo.getParentClass();
            while (parent != null) {
                ClassInfo parentInfo = getClass(parent);
                if (parentInfo == null)
                    break;

                method = parentInfo.getMethod(methodName);
                if (method != null)
                    return method;

                parent = parentInfo.getParentClass();
            }
            return null;
        }

        public String lookupField(String className, String fieldName) {
            ClassInfo classInfo = getClass(className);
            if (classInfo == null)
                return null;

            String fieldType = classInfo.getField(fieldName);
            if (fieldType != null)
                return fieldType;

            String parent = classInfo.getParentClass();
            while (parent != null) {
                ClassInfo parentInfo = getClass(parent);
                if (parentInfo == null)
                    break;

                fieldType = parentInfo.getField(fieldName);
                if (fieldType != null)
                    return fieldType;

                parent = parentInfo.getParentClass();
            }
            return null;
        }
    }

    // Visitor state
    private SymbolTable symbolTable;
    private boolean hasError;
    private ClassInfo currentClass;
    private MethodInfo currentMethod;

    public SymbolTableBuilder() {
        symbolTable = new SymbolTable();
        hasError = false;
        currentClass = null;
        currentMethod = null;
    }

    public SymbolTable getSymbolTable() {
        return symbolTable;
    }

    public boolean hasError() {
        return hasError;
    }

    private void reportError() {
        hasError = true;
    }

    // Goal -> (ImportFunction)? MainClass ( TypeDeclaration )* <EOF>
    public String visit(Goal n) {
        // Handle optional import
        if (n.f0.present()) {
            n.f0.accept(this);
        }

        n.f1.accept(this); // MainClass
        n.f2.accept(this); // TypeDeclaration*

        if (!hasError) {
            checkInheritance();
        }

        return null;
    }

    // ImportFunction -> import java.util.function.Function;
    public String visit(ImportFunction n) {
        symbolTable.setHasImport(true);
        return null;
    }

    // MainClass -> "class" Identifier "{" "public" "static" "void" "main" "("
    // "String" "[" "]" Identifier ")" "{" PrintStatement "}" "}"
    public String visit(MainClass n) {
        String className = n.f1.accept(this);

        if (symbolTable.hasClass(className)) {
            reportError();
            return null;
        }

        symbolTable.setMainClassName(className);
        currentClass = new ClassInfo(className);
        symbolTable.addClass(className, currentClass);

        // Create main method
        MethodInfo mainMethod = new MethodInfo("main", "void");
        String paramName = n.f11.accept(this);
        mainMethod.addParameter(paramName, "String[]");
        currentClass.addMethod("main", mainMethod);

        // Main class only has a PrintStatement, no local variables

        currentClass = null;

        return className;
    }

    // TypeDeclaration -> ClassDeclaration | ClassExtendsDeclaration
    public String visit(TypeDeclaration n) {
        return n.f0.accept(this);
    }

    // ClassDeclaration -> "class" Identifier "{" ( VarDeclaration )* (
    // MethodDeclaration )* "}"
    public String visit(ClassDeclaration n) {
        String className = n.f1.accept(this);

        if (symbolTable.hasClass(className)) {
            reportError();
            return null;
        }

        currentClass = new ClassInfo(className);
        symbolTable.addClass(className, currentClass);

        // Process field declarations
        n.f3.accept(this);

        // Process method declarations
        n.f4.accept(this);

        currentClass = null;
        return className;
    }

    // ClassExtendsDeclaration -> "class" Identifier "extends" Identifier "{" (
    // VarDeclaration )* ( MethodDeclaration )* "}"
    public String visit(ClassExtendsDeclaration n) {
        String className = n.f1.accept(this);
        String parentName = n.f3.accept(this);

        if (symbolTable.hasClass(className)) {
            reportError();
            return null;
        }

        currentClass = new ClassInfo(className, parentName);
        symbolTable.addClass(className, currentClass);

        // Process field declarations
        n.f5.accept(this);

        // Process method declarations
        n.f6.accept(this);

        currentClass = null;
        return className;
    }

    // VarDeclaration -> Type Identifier ";"
    public String visit(VarDeclaration n) {
        String type = n.f0.accept(this);
        String varName = n.f1.accept(this);

        if (currentMethod != null) {
            // Local variable
            if (currentMethod.hasVariable(varName)) {
                reportError();
                return null;
            }
            currentMethod.addLocalVariable(varName, type);
        } else if (currentClass != null) {
            // Field
            if (currentClass.hasField(varName)) {
                reportError();
                return null;
            }
            currentClass.addField(varName, type);
        }

        return null;
    }

    // MethodDeclaration -> "public" Type Identifier "(" ( FormalParameterList )?
    // ")" "{" ( VarDeclaration )* ( Statement )* "return" Expression ";" "}"
    public String visit(MethodDeclaration n) {
        String returnType = n.f1.accept(this);
        String methodName = n.f2.accept(this);

        if (currentClass == null) {
            reportError();
            return null;
        }

        if (currentClass.hasMethod(methodName)) {
            reportError();
            return null;
        }

        currentMethod = new MethodInfo(methodName, returnType);
        currentClass.addMethod(methodName, currentMethod);

        // Process parameters
        if (n.f4.present()) {
            n.f4.accept(this);
        }

        // Process local variables
        n.f7.accept(this);

        currentMethod = null;
        return null;
    }

    // FormalParameterList -> FormalParameter ( FormalParameterRest )*
    public String visit(FormalParameterList n) {
        n.f0.accept(this);
        n.f1.accept(this);
        return null;
    }

    // FormalParameter -> Type Identifier
    public String visit(FormalParameter n) {
        String type = n.f0.accept(this);
        String paramName = n.f1.accept(this);

        if (currentMethod != null) {
            if (currentMethod.hasVariable(paramName)) {
                reportError();
                return null;
            }
            currentMethod.addParameter(paramName, type);
        }

        return null;
    }

    // FormalParameterRest -> "," FormalParameter
    public String visit(FormalParameterRest n) {
        return n.f1.accept(this);
    }

    // Type -> ArrayType | BooleanType | IntegerType | Identifier | LambdaType
    public String visit(Type n) {
        return n.f0.accept(this);
    }

    // ArrayType -> "int" "[" "]"
    public String visit(ArrayType n) {
        return "int[]";
    }

    // BooleanType -> "boolean"
    public String visit(BooleanType n) {
        return "boolean";
    }

    // IntegerType -> "int"
    public String visit(IntegerType n) {
        return "int";
    }

    // LambdaType -> "Function" "<" Identifier "," Identifier ">"
    public String visit(LambdaType n) {
        String inputType = n.f2.accept(this);
        String outputType = n.f4.accept(this);
        return "Function<" + inputType + "," + outputType + ">";
    }

    // Identifier -> <IDENTIFIER>
    public String visit(Identifier n) {
        return n.f0.toString();
    }

    private void checkInheritance() {
        // Check that all parent classes exist and no cycles
        for (String className : symbolTable.getClassNames()) {
            ClassInfo classInfo = symbolTable.getClass(className);
            String parent = classInfo.getParentClass();

            if (parent != null) {
                // Check parent exists
                if (!symbolTable.hasClass(parent)) {
                    reportError();
                    return;
                }

                // Check for cycles
                Set<String> visited = new HashSet<>();
                String current = className;
                while (current != null) {
                    if (visited.contains(current)) {
                        reportError();
                        return;
                    }
                    visited.add(current);
                    ClassInfo currentInfo = symbolTable.getClass(current);
                    current = currentInfo != null ? currentInfo.getParentClass() : null;
                }
            }
        }

        // Check method overriding compatibility
        for (String className : symbolTable.getClassNames()) {
            ClassInfo classInfo = symbolTable.getClass(className);
            String parent = classInfo.getParentClass();

            if (parent != null) {
                ClassInfo parentInfo = symbolTable.getClass(parent);
                if (parentInfo != null) {
                    for (String methodName : classInfo.getMethodNames()) {
                        MethodInfo childMethod = classInfo.getMethod(methodName);
                        MethodInfo parentMethod = symbolTable.lookupMethod(parent, methodName);

                        if (parentMethod != null && !childMethod.isCompatibleWith(parentMethod)) {
                            reportError();
                            return;
                        }
                    }
                }
            }
        }
    }
}