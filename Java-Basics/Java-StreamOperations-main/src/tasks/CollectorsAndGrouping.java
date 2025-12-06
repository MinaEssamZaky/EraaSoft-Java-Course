package tasks;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.Map;
import models.Student;
import data.StudentsData;
import models.Employee;
import data.EmployeesData;
import data.NumbersData;

public class CollectorsAndGrouping {
    public static void run() {
        List<Student> students = StudentsData.students;
        List<Integer> numbers = NumbersData.numbers;
        List<Employee> employees = EmployeesData.employees;

        //task 1 -> Group students by department.
        Map<String, List<Student>> studentsByDepartment = students.stream()
            .collect(Collectors.groupingBy(Student::getDepartment));
        System.out.println("\nStudents grouped by department :"+ studentsByDepartment);

        //task 2 -> Partition numbers into even and odd.
        Map<Boolean,List<Integer>> partitionMap =numbers.stream()
            .collect(Collectors.partitioningBy( n -> n % 2 == 0));
        System.out.println("\nPartitioned numbers (even/odd): " + partitionMap);

        //task 3 -> Join names of all students into a single string, separated by commas.
        System.out.println("\nNames of all students: " + 
            students.stream()
                .map(Student::getName)
                .collect(Collectors.joining(", "))
        );

        //task 4 -> Employees grouped by age with count:
        System.out.println("\nEmployees grouped by age with count: "+
            employees.stream()
                .collect(Collectors.groupingBy(Employee::getAge,Collectors.counting()))
        );

        //task 5 -> 
        System.out.println("\naverage salary  by department: "+
            employees.stream()
                .collect(Collectors.groupingBy(
                    Employee::getDepartment,
                    Collectors.averagingDouble(Employee::getSalary
                    )))
        );
        
    }
    
}
