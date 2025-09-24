import java.util.function.Function;

class Main {
    public static void main(String[] args) {
        System.out.println(10);
    }
}

class test {
    public int test1() {
        // Define a lambda: (x) -> x + 1
        Function<Integer, Integer> f;
        int y;
        y = 1;
        f = (x) -> x + 1;

        // Call it: f.apply(5)
        return (f.apply(5)); // should print 6
    }

}
