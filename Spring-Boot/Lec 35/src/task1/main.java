package task1;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class main {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext app 
					= new AnnotationConfigApplicationContext(SpringConfig.class);
		
		UserService person = app.getBean("personService", UserService.class);
		
		person.save("amir");
		person.update("amir hany");
		
		
		UserService manager = app.getBean("managerService", UserService.class); 
		manager.save("andro");
		manager.update("andro hany");
	}

}
