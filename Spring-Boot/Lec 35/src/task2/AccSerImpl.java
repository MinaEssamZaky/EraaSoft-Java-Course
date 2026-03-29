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
