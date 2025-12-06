package tasks;

import data.NumbersData;
import java.util.List;

public class NumericStreams {
    public static void run() {
        List<Integer> numbers = NumbersData.numbers;
        // Task 1 → Sum of all numbers
        System.out.println("\nSum of all numbers: " +
            numbers.stream()
                .reduce( 0 , (a,b) -> a + b )
        );

        // Task 2 → max and min values
        System.out.println("\nmax value: "+
            numbers.stream()
                .reduce(Integer::max)
            +"\t min value: "+
            numbers.stream()
                .reduce(Integer::min)
                
        );

        // Task 3 → Average of numbers Double
        System.out.println("\nAverage of numbers: "+
            numbers.stream()
                .mapToDouble(n -> n)
                .average()
        );
        // Task 4 → Product of all numbers
        System.out.println("\nProduct of all numbers: " +
            numbers.stream()
                .reduce( 1 , (a,b) -> a * b )
        );

        // Task 5 → Count of positive numbers
        System.out.println("\nCount of positive numbers: "+
            numbers.stream()
                .filter(n -> n > 0)
                .count()
        );
    }
}
