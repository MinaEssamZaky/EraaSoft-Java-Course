package service;

public interface AccountValidationService {
    boolean validateUsername(String username);
    boolean validatePassword(String password);
    boolean validatePhone(String phone);
    boolean validateAge(Float age);
}
