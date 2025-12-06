public class  Thread2 implements Runnable{
    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName());
        System.out.println("Hello From Thread 2");
    }

}

