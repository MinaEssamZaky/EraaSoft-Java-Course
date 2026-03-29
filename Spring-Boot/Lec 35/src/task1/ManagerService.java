package task1;

import org.springframework.stereotype.Component;

@Component
public class ManagerService implements UserService {

	@Override
	public void save(String name) {
		System.out.println("Save " + name);
	}

	@Override
	public void update(String name) {
		System.out.println("update " + name);
	}
	
}
