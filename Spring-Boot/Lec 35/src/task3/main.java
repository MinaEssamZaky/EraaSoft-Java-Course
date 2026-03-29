<<<<<<< HEAD
package task3;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService",UserService.class);
		
		person.destroy(); // close the prototype scope
		app.close(); // close only singleton scope
		
	}

}
=======
package task3;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService",UserService.class);
		
		person.destroy(); // close the prototype scope
		app.close(); // close only singleton scope
		
	}

}
>>>>>>> 328ba2eeb4eb5e47c473c7f03fcab039f4181d4c
