import tasks.*;


public class Main {
    public static void main(String[] args) {
        //Set<Integer> sampleSet =  new HashSet<>();

        System.out.println("---- Basic Stream Operations ----");
        BasicStreamOperations.run();

        System.out.println("\n---- Intermediate Stream Tasks ----");
        IntermediateStreamTasks.run();

        System.out.println("\n---- Numeric Streams ----");
        NumericStreams.run();

        System.out.println("\n---- Collectors and Grouping ----");
        CollectorsAndGrouping.run();

        System.out.println("\n---- Optional, Map, and FlatMap ----");
        OptionalMapFlatMap.run();

        System.out.println("\n---- Advanced Operations ----");
        AdvancedOperations.run();

        // System.out.println("\n---- test ----");
        // System.out.println(sampleSet.add(3));
        // System.out.println(sampleSet.add(3));
        // System.out.println(sampleSet);

        System.out.println("\n---- End of Stream Tasks :)----");
        

    }
}
