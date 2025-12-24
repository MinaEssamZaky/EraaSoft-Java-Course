import service.ApplicationServices;
import service.implementation.EWalletServiceImp;

public class Main {
    public static void main(String[] args) {
        ApplicationServices appService = new EWalletServiceImp();
        appService.startApplication();
    }
}