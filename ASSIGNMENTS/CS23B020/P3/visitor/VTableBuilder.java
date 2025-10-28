package visitor;

import syntaxtree.*;
import java.util.*;

public class VTableBuilder {

    public SymbolTableBuilder.SymbolTable ST;

    public class ClassObject {
        public String name;
        public HashMap<String, Integer> fields;
        public HashMap<String, Integer> methods;
        public int size;
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

    public void build() {
        for (String className : ST.classes.keySet()) {
            buildClassInfo(className);
        }
    }

    private void buildClassInfo(String className) {
        if (ClassObjects.containsKey(className)) {
            return;
        }

        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);

        if (classInfo.parent != null) {
            buildClassInfo(classInfo.parent);
        }

        ClassObject classObject = new ClassObject(className);
        classObject.classInfo = classInfo;

        buildVTable(className, classObject);

        buildFields(className, classObject);

        ClassObjects.put(className, classObject);
    }

    private void buildVTable(String className, ClassObject classObject) {
        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);
        HashMap<String, Integer> methods = new HashMap<>();

        if (classInfo.parent != null) {
            ClassObject parentObject = ClassObjects.get(classInfo.parent);
            methods.putAll(parentObject.methods);
        }

        int nextOffset = methods.size() * 4;
        for (String methodName : classInfo.methods.keySet()) {
            if (!methods.containsKey(methodName)) {
                methods.put(methodName, nextOffset);
                nextOffset += 4;
            }
        }

        classObject.methods = methods;
    }

    private void buildFields(String className, ClassObject classObject) {
        SymbolTableBuilder.ClassInfo classInfo = ST.classes.get(className);
        HashMap<String, Integer> fields = new HashMap<>();

        int currentOffset = 4;

        if (classInfo.parent != null) {
            ClassObject parentObject = ClassObjects.get(classInfo.parent);
            for (Map.Entry<String, Integer> field : parentObject.fields.entrySet()) {
                fields.put(field.getKey(), field.getValue());
            }
            currentOffset = parentObject.size;
        }

        for (String fieldName : classInfo.fields.keySet()) {
            fields.put(fieldName, currentOffset);
            currentOffset += 4;
        }

        classObject.fields = fields;
        classObject.size = currentOffset;
    }

    public int getFieldOffset(String className, String fieldName) {
        ClassObject classObject = ClassObjects.get(className);
        if (classObject != null && classObject.fields.containsKey(fieldName)) {
            return classObject.fields.get(fieldName);
        }
        return -1;
    }

    public int getMethodOffset(String className, String methodName) {
        ClassObject classObject = ClassObjects.get(className);
        if (classObject != null && classObject.methods.containsKey(methodName)) {
            return classObject.methods.get(methodName);
        }
        return -1;
    }
}