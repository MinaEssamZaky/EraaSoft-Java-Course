public class task10 {
    public void finallyBlock() {

            try {
                int a = 5;
                int b = 0;
                int result = a / b;
                System.out.println("Result: " + result);

            } catch (ArithmeticException e) {
                System.out.println("You Can't divide by zero!");

            } finally {
                System.out.println("Hello From Task 10!");
            }

            System.out.println("Program Steel continues  ...");
        }
    }


