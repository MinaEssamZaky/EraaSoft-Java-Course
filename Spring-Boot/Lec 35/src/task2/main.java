<<<<<<< HEAD
package task2;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService",UserService.class);
		person.save("amr");
		
		
		AccountService acc = app.getBean("accSerImpl",AccountService.class);
		acc.getSavedPerson();

	}

}
=======
package task2;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService",UserService.class);
		person.save("amr");
		
		
		AccountService acc = app.getBean("accSerImpl",AccountService.class);
		acc.getSavedPerson();

	}

}
>>>>>>> 328ba2eeb4eb5e47c473c7f03fcab039f4181d4c
