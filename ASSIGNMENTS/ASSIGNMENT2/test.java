import java.util.function.Function;

class test {
    public static void main(String[] args) {
        System.out.println(5);
    }
}

class A {
    int s;
}

class B extends A {
    int p;
}

class tests {
    int y;
    int x;
    Function<A, Integer> func1;
    Function<B, Integer> func2;
    A a;
    B b;
    Function<Integer, A> func3;
    Function<Integer, B> func4;
    Function<Integer, Integer> func5;

    public int foo(int y) {
        int x;
        func1 = (z) -> (5);
        func2 = (w) -> (10);
        // func1=func2;-> not valid as the lambda with B as param might be using
        // func2=func1; -> not allowed by java
        x = this.bar1(func1);

        // functions taking lambdas as arguments

        System.out.println(func1.apply(b));

        // func1=(x)->(5+y); //=> this is incorrect
        func1 = (a) -> (5 + y); // =>this is correct,

        // x=this.bar1(((x)->(5+y)));// => this is incorrect

        x = this.bar2((m) -> (4));

        // these are allowed-> so for lambda expression call, just infer type of m from
        // the type of the function call
        // then type check by adding m to the scope properly ...
        // need to make a new scope for this situation

        // lambdas using lambdas as arguments

        // func5 =(l)->(func1.apply(l.apply(5)));
        // No issue during application as the types of inp and op are known

        // x=this.bar2(func1);//-> invalid same signatures must be used
        func3 = (p) -> (a);
        func3 = (q) -> (b);
        // func4=(r)->(a);//-> return arguments may be upcasted only-> downcasting is
        // not allowed
        func4 = (s) -> (b);
        // func3=func4;//-> invalid , both types must be the same for it to be a valid
        // lambda assignment
        System.out.println(x);
        System.out.println(func1.apply(b));
        // System.out.println(func2.apply(a));//->invalid as a can't be downcasted while
        // assignment

        func5 = this.add(5);
        // System.out.println(((g)->(5)).apply(1));//-> this isn't valid as the type of
        // g cannot be inferred
        // need to check this as well and report error -> what kind of error !?
        return 1;
    }

    public int bar1(Function<A, Integer> f) {
        // System.out.println("A is used");
        return 5;
    }

    public int bar2(Function<B, Integer> f) {
        // System.out.println("B is used");
        return 5;
    }

    // function with lambda as return type
    public Function<Integer, Integer> add(int y) {
        return (e) -> (e + y);
    }

    public int foos(int x, boolean z, int[] p, Function<A, B> func, int k) {
        return this.foos(5, true, (new int[5]), ((a) -> (b)), 5);
    }

    public int foosa() {
        return 5;
    }
    // If someone is still having issues with lambda- the most exhaustive lambda
    // test case I could think of - the commented out things may be uncommented to
    // get errors
}