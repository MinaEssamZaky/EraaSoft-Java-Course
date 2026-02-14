package user.services;

import java.util.List;
import user.model.User;

public interface UserAccount {

    List<User> getAllUsers();

    User signUp(User user);

    User signIn(String email, String password);

    boolean updateUser(Long id, User user);

    boolean deleteUser(Long id);

    boolean isEmailExists(String email);
}
