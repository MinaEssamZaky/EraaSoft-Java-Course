import java.util.Scanner;

public class task4  {
    public  void AccessArrayElement(){
        int[] arr= {5,10,15,20,25};
        Scanner input=new Scanner(System.in);

        System.out.print("Enter Index number : ");
        int index=input.nextInt();

        try {
            System.out.println("Number Is: "+arr[index]);
        }catch (ArrayIndexOutOfBoundsException e){
            System.out.println("Invalid index number");
        }
    }
}
