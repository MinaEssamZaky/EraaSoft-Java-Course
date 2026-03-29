<<<<<<< HEAD
package task2;

import org.springframework.stereotype.Component;

@Component
public class PersonService implements UserService {
	
	private String name;
	

	@Override
	public void save(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name ;
	}

}
=======
package task2;

import org.springframework.stereotype.Component;

@Component
public class PersonService implements UserService {
	
	private String name;
	

	@Override
	public void save(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name ;
	}

}
>>>>>>> 328ba2eeb4eb5e47c473c7f03fcab039f4181d4c
