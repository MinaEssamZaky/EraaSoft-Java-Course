package service.implementation;

import model.Account;
import model.EWalletSystem;
import service.AccountService;
import service.AccountValidationService;

import java.time.LocalDateTime;
import java.util.Optional;

public class AccountServiceImp implements AccountService {

    private final EWalletSystem wallet;
    private final AccountValidationService validator;

    public AccountServiceImp() {
        this.wallet = new EWalletSystem();
        this.validator = new AccountValidationServiceImp(wallet);
        initializeAdminAccount();
    }

    private void initializeAdminAccount() {
        Account adminAccount = new Account("IAM", "IAM123", true);
        adminAccount.setAddress("Admin Address");
        adminAccount.setPhoneNumber("01000000000");
        adminAccount.setAge(30.0f);
        adminAccount.addTransaction(" Admin account created at " + LocalDateTime.now());
        wallet.getAccounts().add(adminAccount);
    }

    // ================= CREATE ACCOUNT =================
    @Override
    public boolean createAccount(Account account) {

        if (!validator.validateUsername(account.getUserName())) {
            return false;
        }

        if (!validator.validatePassword(account.getPassword())) {
            return false;
        }

        if (!validator.validatePhone(account.getPhoneNumber())) {
            return false;
        }

        if (!validator.validateAge(account.getAge())) {
            return false;
        }

        if (isUsernameExists(account.getUserName())) {
            return false;
        }

        if (isPhoneExists(account.getPhoneNumber())) {
            return false;
        }

        account.addTransaction("Account created at " + LocalDateTime.now());
        wallet.getAccounts().add(account);
        return true;
    }

    // ================= LOGIN =================
    @Override
    public boolean getAccount(Account account) {
        Optional<Account> optionalAccount = getOptionalAccountByUserName(account.getUserName());

        if (optionalAccount.isEmpty()) {
            return false;
        }

        Account foundAccount = optionalAccount.get();

        if (!foundAccount.isActive()) {
            return false;
        }

        return foundAccount.getPassword().equals(account.getPassword());
    }

    // ================= DEPOSIT =================
    @Override
    public int deposit(Account account, double amount) {
        Optional<Account> optionalAccount = getOptionalAccountByUserName(account.getUserName());

        if (optionalAccount.isEmpty()) {
            return 1; // account not found
        }

        Account acc = optionalAccount.get();

        if (!acc.isActive()) {
            return 4; // inactive
        }

        if (amount < 1) {
            return 2; // invalid amount
        }

        acc.setBalance(acc.getBalance() + amount);
        acc.addTransaction("Deposit +" + amount + " EGP at " + LocalDateTime.now());
        return 3; // success
    }

    // ================= WITHDRAW =================
    @Override
    public int Withdrew(Account account, double amount) {
        Optional<Account> optionalAccount = getOptionalAccountByUserName(account.getUserName());

        if (optionalAccount.isEmpty()) {
            return 1;
        }

        Account acc = optionalAccount.get();

        if (!acc.isActive()) {
            return 5;
        }

        if (amount < 1) {
            return 2;
        }

        if (acc.getBalance() < amount) {
            return 3;
        }

        acc.setBalance(acc.getBalance() - amount);
        acc.addTransaction("Withdrawal -" + amount + " EGP at " + LocalDateTime.now());
        return 4;
    }

    // ================= TRANSFER =================
    public boolean transfer(Account sender, String receiverUsername, double amount) {

        Optional<Account> senderOpt = getOptionalAccountByUserName(sender.getUserName());
        Optional<Account> receiverOpt = getOptionalAccountByUserName(receiverUsername);
        if (senderOpt.isEmpty() || receiverOpt.isEmpty()) {
            return false;
        }

        Account senderAcc = senderOpt.get();
        Account receiverAcc = receiverOpt.get();

        if (senderAcc.getUserName().equals(receiverAcc.getUserName())) {
            return false;
        }

        if (!senderAcc.isActive() || !receiverAcc.isActive()) {
            return false;
        }

        if (amount < 1 || senderAcc.getBalance() < amount) {
            return false;
        }

        senderAcc.setBalance(senderAcc.getBalance() - amount);
        receiverAcc.setBalance(receiverAcc.getBalance() + amount);

        senderAcc.addTransaction("Transfer to " + receiverUsername + " -" + amount);
        receiverAcc.addTransaction("Transfer from " + sender.getUserName() + " +" + amount);

        return true;
    }

    // ================= PASSWORD =================
    public boolean changePassword(Account account, String oldPassword, String newPassword) {

        Optional<Account> optionalAccount = getOptionalAccountByUserName(account.getUserName());

        if (optionalAccount.isEmpty()) {
            return false;
        }

        Account acc = optionalAccount.get();

        if (!acc.getPassword().equals(oldPassword)) {
            return false;
        }

        if (!validator.validatePassword(newPassword)) {
            return false;
        }

        acc.setPassword(newPassword);
        acc.addTransaction("Password changed at " + LocalDateTime.now());
        return true;
    }

    // ================= ADMIN =================
    public boolean deactivateAccount(String username) {
        Optional<Account> optionalAccount = getOptionalAccountByUserName(username);

        if (optionalAccount.isEmpty() || optionalAccount.get().isAdmin()) {
            return false;
        }

        Account acc = optionalAccount.get();
        acc.setActive(false);
        acc.addTransaction("Account deactivated at " + LocalDateTime.now());
        return true;
    }

    public boolean deleteAccount(String username) {
        Optional<Account> optionalAccount = getOptionalAccountByUserName(username);

        if (optionalAccount.isEmpty() || optionalAccount.get().isAdmin()) {
            return false;
        }

        return wallet.getAccounts().remove(optionalAccount.get());
    }

    public void showAllAccounts(Account requester) {
        if (!requester.isAdmin()) {
            System.out.println("Access Denied");
            return;
        }

        for (Account acc : wallet.getAccounts()) {
            System.out.println(acc.getUserName() + " | "
                    + acc.getBalance() + " | "
                    + (acc.isActive() ? "Active" : "Inactive"));
        }
    }


    private Optional<Account> getOptionalAccountByUserName(String username) {
        return wallet.getAccounts().stream()
                .filter(acc -> acc.getUserName().equals(username))
                .findFirst();
    }

    private boolean isUsernameExists(String username) {
        return getOptionalAccountByUserName(username).isPresent();
    }

    private boolean isPhoneExists(String phone) {
        return wallet.getAccounts().stream()
                .anyMatch(acc -> phone.equals(acc.getPhoneNumber()));
    }

    @Override
    public Account getAccountDetails(Account account) {
        return getOptionalAccountByUserName(account.getUserName()).orElse(null);
    }
}
