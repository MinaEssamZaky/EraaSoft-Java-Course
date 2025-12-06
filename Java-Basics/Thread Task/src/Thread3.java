public class Thread3 extends Thread {
    public void run() {
        try {
            for (int i = 1; i <= 5; i++) {

                System.out.println(i);
                Thread.sleep(1000);
            }
        } catch (InterruptedException e) {
            throw  new RuntimeException(e);
        }
    }

}
