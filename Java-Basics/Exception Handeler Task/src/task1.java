import java.util.Scanner;

public class task1 {
 public void divideNumbers() {
     Scanner input =new Scanner(System.in);

     System.out.println("Input a first number");
     int num1=input.nextInt();

     System.out.println("Input a second number");
     int num2=input.nextInt();

     try{
         int result=num1/num2;
         System.out.println("Result =" +result);
     }catch (ArithmeticException e){
         System.out.println("Error You Can't divide by zero");
     }
 }
}
