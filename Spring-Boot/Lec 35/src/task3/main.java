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
