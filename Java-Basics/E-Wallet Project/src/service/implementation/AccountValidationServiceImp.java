package service.implementation;

import model.Account;
import model.EWalletSystem;
import service.AccountValidationService;

public class AccountValidationServiceImp implements AccountValidationService {
    private EWalletSystem system;

    public AccountValidationServiceImp(EWalletSystem system) {
        this.system = system;
    }

    @Override
    public boolean validateUsername(String username) {
        if (username == null || username.trim().isEmpty()) return false;
        if (username.length() < 3 || username.length() > 20) return false;
        if (!Character.isUpperCase(username.charAt(0))) return false;
        if (system.findByUsername(username) != null) return false;
        return true;
    }

    @Override
    public boolean validatePassword(String password) {
        if (password == null || password.length() < 8) return false;
        boolean upper = false, lower = false, digit = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) upper = true;
            if (Character.isLowerCase(c)) lower = true;
            if (Character.isDigit(c)) digit = true;
        }
        return upper && lower && digit;
    }

    @Override
    public boolean validatePhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) return false;
        if (!phone.matches("\\d{11}")) return false;
        if (!phone.startsWith("01")) return false;
        if (system.findByPhone(phone) != null) return false;
        return true;
    }



    public boolean validateAge(Float age) {
        return age != null && age >= 18;
    }


}