public class  Thread1 extends Thread{
    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName());
        System.out.println("Hello From Thread ");
    }
}
