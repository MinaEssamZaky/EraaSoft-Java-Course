package service.implementation;

import model.Account;
import service.AccountService;
import service.ApplicationServices;

import java.util.Objects;
import java.util.Scanner;

public class EWalletServiceImp implements ApplicationServices {
    private AccountService accountService = new AccountServiceImp();
    private Account currentUser = null;
    private int loginAttempts = 0;

    @Override
    public void startApplication() {
        System.out.println("========================================");
        System.out.println("     Welcome to Cash E-Wallet System    ");
        System.out.println("========================================");

        Scanner input = new Scanner(System.in);

        while (true) {
            if (currentUser == null) {
                showMainMenu(input);
            } else {
                showProfileMenu(input);
            }
        }
    }

    private void showMainMenu(Scanner input) {
        System.out.println("\n========== MAIN MENU ==========");
        System.out.println("1 - Signup");
        System.out.println("2 - Login");
        System.out.println("3 - Exit");
        System.out.println("===============================");
        System.out.print("Please enter your choice: ");

        int choice = -1;
        String line = input.nextLine();
        try {
            choice = Integer.parseInt(line);
        } catch (NumberFormatException e) {
            System.out.println("Invalid input! Please enter a number.");
            return;
        }

        switch (choice) {
            case 1:
                signup(input);
                break;
            case 2:
                login(input);
                break;
            case 3:
                System.out.println("\nThank you for using our service. Goodbye!");
                System.exit(0);
                break;
            default:
                System.out.println("Invalid choice! Please try again.");
        }
    }

    private void signup(Scanner scanner) {
        System.out.println("\n========== SIGNUP ==========");

        System.out.print("Enter Your Name: ");
        String userName = scanner.nextLine();

        System.out.print("Enter Your Password: ");
        String password = scanner.nextLine();

        System.out.print("Enter Your Phone Number: ");
        String phoneNumber = scanner.nextLine();

        System.out.print("Enter Your Address: ");
        String address = scanner.nextLine();

        System.out.print("Enter Your Age: ");
        Float age = null;
        String ageInput = scanner.nextLine();
        try {
            age = Float.parseFloat(ageInput);
        } catch (NumberFormatException e) {
            System.out.println("Invalid age input! Age must be a number.");
            return;
        }

        Account account = new Account(userName, password, phoneNumber, address, age);
        boolean isAccountCreated = accountService.createAccount(account);

        if (isAccountCreated) {
            System.out.println("\nAccount Created Successfully!");
            System.out.println("Please login with your new credentials.");
        } else {
            System.out.println("\nAccount creation failed!");
            System.out.println("Possible reasons:");
            System.out.println("- Username already exists");
            System.out.println("- Invalid username format (must start with uppercase)");
            System.out.println("- Invalid password format");
            System.out.println("- Invalid phone number");
            System.out.println("- Age must be 18 or older");
        }
    }

    private void login(Scanner scanner) {
        if (loginAttempts >= 3) {
            System.out.println("\nToo many failed attempts. Please try again later.");
            return;
        }

        System.out.println("\n========== LOGIN ==========");
        System.out.print("Enter Your Username: ");
        String userName = scanner.nextLine();

        System.out.print("Enter Your Password: ");
        String password = scanner.nextLine();

        Account account = new Account(userName, password);
        boolean loginSuccess = accountService.getAccount(account);

        if (loginSuccess) {
            loginAttempts = 0;
            currentUser = ((AccountServiceImp) accountService).getAccountDetails(account);
            System.out.println("\nLogin Successful! Welcome " + currentUser.getUserName());
        } else {
            loginAttempts++;
            System.out.println("\nIncorrect Username or Password!");
            System.out.println("Attempts remaining: " + (3 - loginAttempts));
        }
    }

    private void showProfileMenu(Scanner scanner) {
        System.out.println("\n========== SERVICES MENU ==========");
        System.out.println("Welcome, " + currentUser.getUserName() + "!");
        System.out.println("1 - Deposit Money");
        System.out.println("2 - Withdraw Money");
        System.out.println("3 - Show Account Details");
        System.out.println("4 - Transfer Money");
        System.out.println("5 - Change Password");
        System.out.println("6 - Transaction History");
        System.out.println("7 - Logout");

        if (currentUser.isAdmin()) {
            System.out.println("8 - Admin Panel");
            System.out.println("9 - Deactivate Account");
            System.out.println("10 - Delete Account");
        }

        System.out.println("===================================");
        System.out.print("Enter your choice: ");

        int choice = -1;
        String inputLine = scanner.nextLine();
        try {
            choice = Integer.parseInt(inputLine);
        } catch (NumberFormatException e) {
            System.out.println("Invalid input! Please enter a number.");
            return;
        }

        switch (choice) {
            case 1:
                deposit(scanner);
                break;
            case 2:
                withdraw(scanner);
                break;
            case 3:
                showAccountDetails();
                break;
            case 4:
                transfer(scanner);
                break;
            case 5:
                changePassword(scanner);
                break;
            case 6:
                showTransactionHistory();
                break;
            case 7:
                logout();
                break;
            case 8:
                if (currentUser.isAdmin()) {
                    adminPanel();
                } else {
                    System.out.println("Invalid choice!");
                }
                break;
            case 9:
                if (currentUser.isAdmin()) {
                    deactivateAccount(scanner);
                } else {
                    System.out.println("Invalid choice!");
                }
                break;
            case 10:
                if (currentUser.isAdmin()) {
                    deleteAccount(scanner);
                } else {
                    System.out.println("Invalid choice!");
                }
                break;
            default:
                System.out.println("Invalid choice!");
        }
    }

    private void deposit(Scanner scanner) {
        System.out.print("\nEnter amount to deposit (minimum 1 EGP): ");
        double amount = 0;
        String line = scanner.nextLine();
        try {
            amount = Double.parseDouble(line);
        } catch (NumberFormatException e) {
            System.out.println("Invalid amount!");
            return;
        }

        int depositResult = accountService.deposit(currentUser, amount);

        switch (depositResult) {
            case 1:
                System.out.println("Account not found!");
                break;
            case 2:
                System.out.println("Amount must be at least 1 EGP!");
                break;
            case 3:
                System.out.println("Deposit successful!");
                System.out.println("Current balance: " + currentUser.getBalance() + " EGP");
                break;
            case 4:
                System.out.println("Account is deactivated!");
                break;
        }
    }

    private void withdraw(Scanner scanner) {
        System.out.print("\nEnter amount to withdraw (minimum 1 EGP): ");
        double amount = 0;
        String line = scanner.nextLine();
        try {
            amount = Double.parseDouble(line);
        } catch (NumberFormatException e) {
            System.out.println("Invalid amount!");
            return;
        }

        int withdrawResult = accountService.Withdrew(currentUser, amount);

        switch (withdrawResult) {
            case 1:
                System.out.println("Account not found!");
                break;
            case 2:
                System.out.println("Amount must be at least 1 EGP!");
                break;
            case 3:
                System.out.println("Insufficient balance!");
                System.out.println("Current balance: " + currentUser.getBalance() + " EGP");
                break;
            case 4:
                System.out.println("Withdrawal successful!");
                System.out.println("Current balance: " + currentUser.getBalance() + " EGP");
                break;
            case 5:
                System.out.println("Account is deactivated!");
                break;
        }
    }

    private void transfer(Scanner scanner) {
        System.out.print("\nEnter recipient username: ");
        String recipient = scanner.nextLine();

        if (recipient.equals(currentUser.getUserName())) {
            System.out.println("You cannot transfer money to yourself!");
            return;
        }

        System.out.print("Enter amount to transfer (minimum 1 EGP): ");
        double amount = 0;
        String line = scanner.nextLine();
        try {
            amount = Double.parseDouble(line);
        } catch (NumberFormatException e) {
            System.out.println(" Invalid amount!");
            return;
        }

        boolean transferResult = ((AccountServiceImp) accountService).transfer(currentUser, recipient, amount);

        if (transferResult) {
            System.out.println("Transfer successful!");
            System.out.println("Sent " + amount + " EGP to " + recipient);
            System.out.println("Your new balance: " + currentUser.getBalance() + " EGP");
        } else {
            System.out.println("Transfer failed!");
            System.out.println("Possible reasons:");
            System.out.println("- Recipient account not found");
            System.out.println("- Recipient account is inactive");
            System.out.println("- Insufficient balance");
            System.out.println("- Minimum transfer amount is 1 EGP");
        }
    }


    private void changePassword(Scanner scanner) {
        System.out.print("\nEnter old password: ");
        String oldPassword = scanner.nextLine();

        System.out.print("Enter new password: ");
        String newPassword = scanner.nextLine();

        boolean changeResult = ((AccountServiceImp) accountService).changePassword(currentUser, oldPassword, newPassword);

        if (changeResult) {
            System.out.println("Password changed successfully!");
        } else {
            System.out.println("Password change failed!");
            System.out.println("Possible reasons:");
            System.out.println("- Old password is incorrect");
            System.out.println("- New password doesn't meet requirements");
            System.out.println("- New password is same as old password");
        }
    }

    private void showAccountDetails() {
        Account accountDetails = accountService.getAccountDetails(currentUser);
        if (Objects.isNull(accountDetails)) {
            System.out.println("Account not found!");
            return;
        }
        System.out.println(accountDetails);
    }

    private void showTransactionHistory() {
        System.out.println("\n========== TRANSACTION HISTORY ==========");
        if (currentUser.getHistory().isEmpty()) {
            System.out.println("No transactions yet.");
        } else {
            for (String transaction : currentUser.getHistory()) {
                System.out.println("- " + transaction);
            }
        }
        System.out.println("=========================================\n");
    }

    private void adminPanel() {
        ((AccountServiceImp) accountService).showAllAccounts(currentUser);
    }

    private void deactivateAccount(Scanner scanner) {
        System.out.print("\nEnter username to deactivate: ");
        String username = scanner.nextLine();

        if (username.equals(currentUser.getUserName())) {
            System.out.println("Cannot deactivate your own account!");
            return;
        }

        boolean result = ((AccountServiceImp) accountService).deactivateAccount(username);

        if (result) {
            System.out.println("Account deactivated successfully!");
        } else {
            System.out.println("Failed to deactivate account!");
            System.out.println("Possible reasons:");
            System.out.println("Account not found");
            System.out.println("Cannot deactivate admin account");
        }
    }

    private void deleteAccount(Scanner scanner) {
        System.out.print("\nEnter username to delete: ");
        String username = scanner.nextLine();

        if (username.equals(currentUser.getUserName())) {
            System.out.println("Cannot delete your own account!");
            return;
        }

        boolean result = ((AccountServiceImp) accountService).deleteAccount(username);

        if (result) {
            System.out.println("Account deleted successfully!");
        } else {
            System.out.println("Failed to delete account!");
            System.out.println("Possible reasons:");
            System.out.println("- Account not found");
            System.out.println("- Cannot delete admin account");
        }
    }

    private void logout() {
        System.out.println("\nLogout successful. Goodbye " + currentUser.getUserName() + "!");
        currentUser = null;
        loginAttempts = 0;
    }
}
