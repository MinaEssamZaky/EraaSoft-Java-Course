package tasks;

import data.NamesData;
import data.NumbersData;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class IntermediateStreamTasks {
    public static void run() {
        List<String> names = NamesData.names;
        List<Integer> numbers = NumbersData.numbers;
        // Task 1 →  names Longer then 5 characters
        System.out.println("\ncount of name Longer then 5 characters: " +
                    names.stream()
                        .filter(name -> name != null && !name.isEmpty() && name.length() > 5)
                        .count()
        );
        // Task 2 → Find the first even number
        System.out.println("\nFrist even number :"+
            numbers.stream()
                .filter(n -> n % 2 == 0).
                findFirst()
        );
        // Task 3 → Any number divisible by 5
        System.out.println("\nAny number divisible by 5 :"+
            numbers.stream()
                .anyMatch(n -> n % 5 == 0 )
        );

        // Task 4 → Set instead of a List
        Set<Integer> SetNumbers = numbers.stream()
                .filter(n -> n!=null)
                .collect(Collectors.toSet());
        System.out.println("\nSet of Numbers: " + SetNumbers);


        // Task 5 → Skip the first 3 elements
        System.out.println("\nSkip the first 3 elements :"+
            numbers.stream()
                .skip(3)
                .collect(Collectors.toList())
        );

    }
}