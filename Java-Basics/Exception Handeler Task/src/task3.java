public class task3 {
    public void nullException(){
        try{
            String x = null ;
            System.out.println(x.toUpperCase());
        }catch (NullPointerException e){
            System.out.println("Invalid input = null");
        }
    }
}
