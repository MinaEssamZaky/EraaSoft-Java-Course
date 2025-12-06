
public class Main {
    public static void main(String[] args) {

        Thread1 thread1 = new Thread1();
        thread1.start();
        Thread2 thread2 = new Thread2();
        thread2.run();
        Thread3 thread3 = new Thread3();
        thread3.start();

        BankAccount bankAccount = new BankAccount();
        Depositor depositor = new Depositor(bankAccount);
        Withdrawer withdrawer = new Withdrawer(bankAccount);
        depositor.start();
        withdrawer.start();
        try{
            thread1.join();
            thread3.join();
            depositor.join();
            withdrawer.join();
        }catch (InterruptedException e){
            throw  new RuntimeException(e);
        }


        System.out.println("main end");


    }}