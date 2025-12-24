package service;

import model.Account;

public interface AccountService  {
    boolean createAccount(Account account);
    boolean getAccount(Account account);
    int deposit(Account account, double amount);
    int Withdrew(Account account, double amount);
    Account getAccountDetails(Account account);
}
