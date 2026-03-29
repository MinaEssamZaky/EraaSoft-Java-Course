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
