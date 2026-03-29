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
