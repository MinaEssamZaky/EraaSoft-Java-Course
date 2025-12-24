package model;

import java.util.ArrayList;
import java.util.List;

public class Account {
    private String userName;
    private String password;
    private String phoneNumber;
    private String address;
    private Float age;
    private double balance;
    private List<String> history = new ArrayList<>();
    private boolean isAdmin;
    private boolean isActive;

    public Account() {
        this.balance = 0;
        this.history = new ArrayList<>();
        this.isAdmin = false;
        this.isActive = true;
    }

    public Account(String userName, String password) {
        this.userName = userName;
        this.password = password;
        this.balance = 0;
        this.history = new ArrayList<>();
        this.isAdmin = false;
        this.isActive = true;
    }

    public Account(String userName, String password, String phoneNumber, String address, Float age) {
        this.userName = userName;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.age = age;
        this.balance = 0;
        this.history = new ArrayList<>();
        this.isAdmin = false;
        this.isActive = true;
    }

    public Account(String userName, String password, boolean isAdmin) {
        this.userName = userName;
        this.password = password;
        this.balance = 0;
        this.history = new ArrayList<>();
        this.isAdmin = isAdmin;
        this.isActive = true;
    }

    public Account(String username, String password, int age, String phone) {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Float getAge() {
        return age;
    }

    public void setAge(Float age) {
        this.age = age;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public List<String> getHistory() {
        return history;
    }

    public void setHistory(List<String> history) {
        this.history = history;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void addTransaction(String transaction) {
        this.history.add(transaction);
    }

    @Override
    public String toString() {
        return "--------->Account Information<---------\n" +
                "Username   : " + (userName != null ? userName : "N/A") + "\n" +
                "Phone No.  : " + (phoneNumber != null ? phoneNumber : "N/A") + "\n" +
                "Address    : " + (address != null ? address : "N/A") + "\n" +
                "Age        : " + (age != null ? age : "N/A") + "\n" +
                "Balance    : " + balance + " EGP\n" +
                "Status     : " + (isActive ? "Active" : "Inactive") + "\n" +
                "Admin      : " + (isAdmin ? "Yes" : "No") + "\n" +
                "--------------------------------------";
    }
}