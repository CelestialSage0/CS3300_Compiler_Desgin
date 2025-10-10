class Test5 {
    public static void main(String[] args) {
        System.out.println(new D().change());
    }
}

class A {
    int x;

    public int change() {
        x = 1;
        return x;
    }
}

class B extends A {
    int x;

    public int change() {
        x = 2;
        return x;
    }
}

class C extends B {
    public int hey() {
        int k;
        k = this.change();
        return x;
    }
}

class D extends C {
    public int change() {
        return new C().hey();
    }
}