import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class task9 {
    public static void readFile(String fileName) throws IOException {
        FileReader  file  = new FileReader(fileName);
        BufferedReader br = new BufferedReader(file);

        String line;
        while ((line = br.readLine()) != null) {
            System.out.println(line);
        }
        br.close();
    }
}
