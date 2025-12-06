package tasks;

import data.NestedWords;
import data.NamesData;
import java.util.List;
import java.util.Arrays;
import java.util.Optional;
public class OptionalMapFlatMap {
    public static void run() {
        List<List<String>> nestedWords = NestedWords.nestedWords;
        List<String> names = NamesData.names;

        // Task 1 → Flatten the nested list of words 
        List<String> flatWords =nestedWords.stream()
            .flatMap(list -> list.stream())
            .toList();
        System.out.println("\nFlattened words: " + flatWords);

        // Task 2 → Get characters of all names using flatMap
        System.out.println("\nChar of names :"+
            names.stream()
                .filter(name -> name != null && !name.isEmpty())
                .flatMap(name -> Arrays.stream(name.split("")))
                .distinct()
                .toList()
        );

        // Task 3 → Use Optional to handle potential null values in names list
        System.out.println("\nOptional names : " +
            names.stream()
                .map(name -> Optional.ofNullable(name) 
                    .filter(n -> !n.isEmpty()))
                .map(opt -> opt.orElse("Unknown"))
                .toList()
        );

        //task 4 → Get lengths of names using map
        System.out.println("\nLengths of names: "+
            names.stream()
                .filter(name -> name != null && !name.isEmpty())
                .map(String::length)
                .toList()
        );

        // Task 5 → Use Optional to find the first name that starts with 'A'
        System.out.println("\nFirst name starting with A: " +
            names.stream()
                .filter(name -> name != null 
                    && !name.isEmpty())
                .filter(name -> name.startsWith("A") 
                    || name.startsWith("a")) 
                .map(String::toUpperCase)
                .toList()
                
        );

            
    }
    
}
