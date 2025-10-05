package visitor;

import syntaxtree.*;
import java.util.*;

public class VTableBuilder {

    public SymbolTableBuilder.SymbolTable ST;

    public class ClassObject {
        public String name;
        public HashMap<String, Integer> fields; // fieldName -> offset
        public HashMap<String, Integer> methods; // methodName -> vtable offset
        public int size; // Total size in bytes (excluding vtable pointer)
        public SymbolTableBuilder.ClassInfo classInfo;

        public ClassObject(String name) {
            this.name = name;
            fields = new HashMap<>();
            methods = new HashMap<>();
            size = 0;
        }
    }

    public HashMap<String, ClassObject> ClassObjects;

    public VTableBuilder(SymbolTableBuilder.SymbolTable st) {
        this.ST = st;
        this.ClassObjects = new HashMap<>();
    }

    /**
     * Build all class objects with VTable and field information
     */
    public void build() {
        // Process each class
        for (String className : ST.classes.keySet()) {
            buildClassInfo(className);
        }
    }

    /**
     * Build VTable and field offsets for a specific class
     */
    private void buildClassInfo(String className) {
        // Skip if already processed
        if (ClassObjects.containsKey(className)) {
            return;
        }

        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);

        // If this class extends another, process parent first
        if (classInfo.parent != null) {
            buildClassInfo(classInfo.parent);
        }

        ClassObject classObject = new ClassObject(className);
        classObject.classInfo = classInfo;

        // Build VTable
        buildVTable(className, classObject);

        // Build field offsets
        buildFields(className, classObject);

        // Store the class object
        ClassObjects.put(className, classObject);
    }

    /**
     * Build VTable for a class
     * Inherits parent's VTable and adds/overrides methods
     */
    private void buildVTable(String className, ClassObject classObject) {
        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);
        HashMap<String, Integer> methods = new HashMap<>();

        // Start with parent's methods if exists
        if (classInfo.parent != null) {
            ClassObject parentObject = ClassObjects.get(classInfo.parent);
            // Copy all parent methods
            methods.putAll(parentObject.methods);
        }

        // Add new methods (don't override existing ones - they keep same offset)
        int nextOffset = methods.size() * 4;
        for (String methodName : classInfo.methods.keySet()) {
            if (!methods.containsKey(methodName)) {
                methods.put(methodName, nextOffset);
                nextOffset += 4;
            }
        }

        classObject.methods = methods;
    }

    /**
     * Build field offsets for a class
     * Layout in memory: [vtable_ptr at offset 0 | field0 at offset 4 | field1 at
     * offset 8 | ...]
     * But we store field offsets starting from 0 (they'll be +4 from vtable ptr)
     */
    private void buildFields(String className, ClassObject classObject) {
        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);
        HashMap<String, Integer> fields = new HashMap<>();

        int currentOffset = 4;

        // First, add parent's fields if exists
        if (classInfo.parent != null) {
            ClassObject parentObject = ClassObjects.get(classInfo.parent);
            // Copy all parent fields
            fields.putAll(parentObject.fields);
            currentOffset = parentObject.size * 4;
        }

        // Then add this class's own fields
        for (String fieldName : classInfo.fields.keySet()) {
            fields.put(fieldName, currentOffset);
            currentOffset += 4; // Each field is 4 bytes (pointer or int)
        }

        classObject.fields = fields;
        classObject.size = currentOffset;
    }

    /**
     * Get field offset for a class
     */
    public int getFieldOffset(String className, String fieldName) {
        ClassObject classObject = ClassObjects.get(className);
        if (classObject != null && classObject.fields.containsKey(fieldName)) {
            return classObject.fields.get(fieldName);
        }
        return -1; // Field not found
    }

    /**
     * Get method offset in VTable for a class
     */
    public int getMethodOffset(String className, String methodName) {
        ClassObject classObject = ClassObjects.get(className);
        if (classObject != null && classObject.methods.containsKey(methodName)) {
            return classObject.methods.get(methodName);
        }
        return -1; // Method not found
    }

    // /**
    // * Get total size of class (for allocation)
    // * This is the size of all fields, vtable pointer is separate
    // */
    // public int getClassSize(String className) {
    // ClassObject classObject = ClassObjects.get(className);
    // if (classObject != null) {
    // // Return size + 4 for vtable pointer
    // return classObject.size + 4;
    // }
    // return 4; // Just vtable pointer if no fields
    // }

    // /**
    // * Get the actual class where a method is defined
    // * (useful for finding which class's VTable to use)
    // */
    // public String getMethodDefiningClass(String className, String methodName) {
    // SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);

    // // Check if method is in this class
    // if (classInfo.methods.containsKey(methodName)) {
    // return className;
    // }

    // // Otherwise check parent
    // if (classInfo.parent != null) {
    // return getMethodDefiningClass(classInfo.parent, methodName);
    // }

    // return null; // Method not found
    // }

    // /**
    // * Check if a field belongs to this class or is inherited
    // */
    // public String getFieldDefiningClass(String className, String fieldName) {
    // SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);

    // // Check if field is in this class
    // if (classInfo.fields.containsKey(fieldName)) {
    // return className;
    // }

    // // Otherwise check parent
    // if (classInfo.parent != null) {
    // return getFieldDefiningClass(classInfo.parent, fieldName);
    // }

    // return null; // Field not found
    // }

    // /**
    // * Get list of all methods in VTable order
    // * Useful for generating VTable initialization code
    // */
    // public List<String> getMethodsInOrder(String className) {
    // ClassObject classObject = ClassObjects.get(className);
    // if (classObject == null) {
    // return new ArrayList<>();
    // }

    // // Create array of methods sorted by offset
    // String[] methodArray = new String[classObject.methods.size()];
    // for (Map.Entry<String, Integer> entry : classObject.methods.entrySet()) {
    // methodArray[entry.getValue()] = entry.getKey();
    // }

    // return Arrays.asList(methodArray);
    // }

    // /**
    // * Print VTable information (for debugging)
    // */
    // public void printVTables() {
    // for (String className : ClassObjects.keySet()) {
    // ClassObject obj = ClassObjects.get(className);
    // System.err.println("Class: " + className);
    // System.err.println(" VTable:");

    // List<String> methods = getMethodsInOrder(className);
    // for (int i = 0; i < methods.size(); i++) {
    // String methodName = methods.get(i);
    // String definingClass = getMethodDefiningClass(className, methodName);
    // System.err.println(" " + i + ": " + methodName +
    // " (defined in " + definingClass + ")");
    // }
    // }
    // }

    // /**
    // * Print field offset information (for debugging)
    // */
    // public void printFieldOffsets() {
    // for (String className : ClassObjects.keySet()) {
    // ClassObject obj = ClassObjects.get(className);
    // System.err.println("Class: " + className + " (total size: " +
    // getClassSize(className) + " bytes)");
    // System.err.println(" Fields:");

    // for (Map.Entry<String, Integer> entry : obj.fields.entrySet()) {
    // String definingClass = getFieldDefiningClass(className, entry.getKey());
    // System.err.println(" " + entry.getKey() + " at offset " +
    // entry.getValue() + " (defined in " + definingClass + ")");
    // }
    // }
    // }

    // /**
    // * Get number of methods in VTable for a class
    // */
    // public int getVTableSize(String className) {
    // ClassObject classObject = ClassObjects.get(className);
    // if (classObject != null) {
    // return classObject.methods.size();
    // }
    // return 0;
    // }
}