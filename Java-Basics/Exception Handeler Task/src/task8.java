public class task8 {
    public static void method1() throws Exception {
        System.out.println("Inside method1...");
        throw new Exception("Something went wrong in method1!");
    }


    public static void method2() throws Exception {
        System.out.println("Inside method2...");
        method1();
    }
}
