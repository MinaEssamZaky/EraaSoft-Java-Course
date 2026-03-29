<<<<<<< HEAD
package task1;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService", UserService.class);
		
		person.save("Mina");
		person.update("Mina Essam");
		
		
		UserService manager = app.getBean("managerService", UserService.class); 
		manager.save("Ahmed");
		manager.update("Ahmed Ali");
	}

}
=======
package task1;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService", UserService.class);
		
		person.save("Omar Ahmed");
		person.update("Amir Hany");
		
		
		UserService manager = app.getBean("managerService", UserService.class); 
		manager.save("Kiro");
		manager.update("Kiro Ibrahim");
	}

}
>>>>>>> 328ba2eeb4eb5e47c473c7f03fcab039f4181d4c
