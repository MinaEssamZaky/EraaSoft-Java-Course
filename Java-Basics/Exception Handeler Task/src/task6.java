public class task6 {
    public void MultipleCatch(){
        String name = "mina";
        int int1 = 10,int2 = 0;

        try {
            System.out.println(name.length());

            int result = int1 / int2;
            System.out.println(result);

        } catch (NullPointerException e) {
            System.out.println("Invalid input");
        } catch (ArithmeticException e) {
            System.out.println("You Can't divide by zero!");
        }
    }
}
