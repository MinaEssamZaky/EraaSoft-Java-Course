package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class EWalletSystem {
    private final String name = "Cash E Wallet System";
    private List<Account> accounts = new ArrayList<>();

    public String getName() {
        return name;
    }

    public List<Account> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public Account findByUsername(String username) {
        Optional<Account> account = accounts.stream()
                .filter(acc -> acc.getUserName() != null &&
                        acc.getUserName().equals(username))
                .findFirst();
        return account.orElse(null);
    }

    public Account findByPhone(String phone) {
        Optional<Account> account = accounts.stream()
                .filter(acc -> acc.getPhoneNumber() != null &&
                        acc.getPhoneNumber().equals(phone))
                .findFirst();
        return account.orElse(null);
    }

    public void addAccount(Account account) {
        accounts.add(account);
    }

    public boolean removeAccount(String username) {
        Account account = findByUsername(username);
        if (account != null && !account.isAdmin()) {
            return accounts.remove(account);
        }
        return false;
    }
}