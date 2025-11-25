import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        task1 inputUser = new task1();
        inputUser.divideNumbers();

        task2 stringUser = new task2();
        stringUser.convertStringToInteger();

        task3 nullUser = new task3();
        nullUser.nullException();

        task4 indexNumber = new task4();

        indexNumber.AccessArrayElement();

        task5 readeFile = new task5();
        readeFile.FileNotFoundException();

        task6 multipleCatch = new task6();

        multipleCatch.MultipleCatch();


        Scanner input = new Scanner(System.in);

        System.out.print("Enter your age: ");
        int age = input.nextInt();

        try {
            CheckAge.checkAge(age);
        } catch (InvalidAgeException e) {
            System.out.println("Error: " + e.getMessage());
        }

        input.close();

        try {
            task8.method2();
        }catch (Exception e) {
            System.out.println("Error From Main");
        }

        String fileName ="test2.txt";
        try {
            task9.readFile(fileName);
        }catch (IOException e){
            System.out.println("Can't read file");
        }

        task10 flat = new task10();
        flat.finallyBlock();


    }}
