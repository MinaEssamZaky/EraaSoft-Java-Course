public class BankAccount {
    long balance;

    public synchronized  void  deposit(long amount) {
        balance += amount;
        System.out.println("The balance after the deposit =  " + balance);
        notify();
    }

    public synchronized void withdraw(long amount) throws InterruptedException {
        while (balance < amount) {
            System.out.println("no enough balance");
            wait();
        }
        balance -= amount;
        System.out.println("The balance after the withdraw =  " + balance);
    }
}