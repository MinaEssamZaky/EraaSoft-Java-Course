<<<<<<< HEAD
package task2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccSerImpl implements AccountService {
	
	PersonService person ;
	
	@Autowired
	public AccSerImpl(PersonService person) {
		this.person = person;
	}
	
	@Override
	public void getSavedPerson() {
		System.out.println("Retrieved name: " + person.getName());
	}

}
=======
package task2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccSerImpl implements AccountService {
	
	PersonService person ;
	
	@Autowired
	public AccSerImpl(PersonService person) {
		this.person = person;
	}
	
	@Override
	public void getSavedPerson() {
		System.out.println("Retrieved name: " + person.getName());
	}

}
>>>>>>> 328ba2eeb4eb5e47c473c7f03fcab039f4181d4c
