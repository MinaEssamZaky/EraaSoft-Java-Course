package task3;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("prototype")
public class PersonService implements UserService {

	@Override
	@PostConstruct
	public void init() {
		System.out.println("hello");
	}

	@Override
	@PreDestroy
	public void destroy() {
		System.out.println("buy");
	}
	


}
