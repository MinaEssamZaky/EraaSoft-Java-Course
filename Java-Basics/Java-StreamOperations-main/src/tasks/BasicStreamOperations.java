package tasks;

import data.NumbersData;
import data.NamesData;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class BasicStreamOperations {

    public static void run() {

        List<Integer> numbers = NumbersData.numbers;
        List<String> names = NamesData.names;


        // Task 1 → Filter Even Numbers
        List<Integer> evens = numbers.stream()
                .filter(n -> n % 2 == 0)
                .collect(Collectors.toList());

        System.out.println("\nEven numbers: " + evens);

        // Task 2 → Find names starting with a 
        System.out.println("\nNames starting with 'A': " +
                names.stream()
                        .filter(name -> name != null && !name.isEmpty()&& name.startsWith("A"))
                        .collect(Collectors.toList())
        );

        // Task 3 → Convert names to uppercase
        List<String> UpperNames = names.stream()
                .filter(name -> name != null && !name.isEmpty())
                .map(String::toUpperCase)
                .collect(Collectors.toList());
        System.out.println("\nUppercase Names: " + UpperNames);
        // Task 4 → Sort numbers in descending order
        List<Integer> descendingNumber =numbers.stream()
                .sorted(Comparator.reverseOrder())
                .collect(Collectors.toList());
        System.out.println("\nDescending Numbers: " + descendingNumber);

        // Task 5 → Remove duplicate numbers
        List<Integer> RemoveDuplicate  = numbers.stream()
                .filter(n -> n != null)
                .distinct()
                .collect(Collectors.toList());
        System.out.println("\nNumbers without Duplicates: " + RemoveDuplicate);
        

    }
}
