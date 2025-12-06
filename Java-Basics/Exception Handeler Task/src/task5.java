import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;

public class task5 {
    public void FileNotFoundException(){
        try {
            FileReader readeFile = new FileReader("test.txt");
            BufferedReader br = new BufferedReader(readeFile);
            System.out.print(br.readLine());
            br.close();
        }catch (FileAlreadyExistsException e){
        System.out.println("File already exists");
        }catch (IOException e){
            System.out.println("IO Exception");
        }
    }
}
