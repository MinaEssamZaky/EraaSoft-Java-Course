import java.util.Scanner;

public class task2 {
    public  void convertStringToInteger(){
        Scanner stringInput = new Scanner(System.in);
        System.out.print("Enter a number: ");
        String inputString = stringInput.nextLine();
        try{
            int number = Integer.parseInt(inputString);
            System.out.println(number);
        }catch(NumberFormatException e){
            System.out.println("Invalid input please Input Number");
        }

    }
}
