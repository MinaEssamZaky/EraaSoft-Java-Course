package tasks;

import data.EmployeesData;
import data.StudentsData;
import data.NumbersData;
import data.NamesData;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Comparator;
import models.Employee;
import models.Student;


public class AdvancedOperations {

    public static void run() {

        List<Employee> employees = EmployeesData.employees;
        List<Student> students = StudentsData.students;
        List<Integer> numbers = NumbersData.numbers;
        Set<Integer> seenNumbers = new HashSet<>();
        List<String> names = NamesData.names;
    
        //task 1 → sort the employee by salary.
        System.out.println("\nEmployees sorted by salary: "+
            employees.stream()
               .sorted(Comparator.comparing(Employee::getSalary))
                .toList()
        );

        //task 2 → find second the employee with the highest salary.
        System.out.println("\nEmployee with second highest salary: "+
            employees.stream()
                .sorted(Comparator.comparing(Employee::getSalary).reversed())
                .skip(1)
                .findFirst()
        );

        //task 3 → find duplicate numbers in the list.
        System.out.println("\nDuplicate nambers "+
            numbers.stream()
                .filter(n -> !seenNumbers.add(n))
                .collect(Collectors.toSet())
        );

        //task 4 →  filter out empty names from the list.

        System.out.println("\nNon-empty names: "+
            names.stream()
                .filter(name -> name != null && !name.isBlank())
                .toList()
        );

        //task 5 → partition students based on whether their grade is above or below 75.
        Map<Boolean, List<Student>> partitionedStudents =students.stream()
                .collect(Collectors.partitioningBy(stu -> stu.getGrade() >= 75));
                
            System.out.println("\npass : "+ partitionedStudents.get(true));
            System.out.println("\nfail : "+ partitionedStudents.get(false));
    }

    
}
