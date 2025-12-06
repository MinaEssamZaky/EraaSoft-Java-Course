package data;

import models.Student;
import java.util.Arrays;
import java.util.List;

public class StudentsData {
    public static List<Student> students = Arrays.asList(
            new Student("Ali", "IT", 85),
            new Student("Mona", "CS", 92),
            new Student("Ahmed", "IT", 60),
            new Student("Sara", "CS", 70),
            new Student("Omar", "IS", 45),
            new Student("Laila", "IS", 78)
    );
}
