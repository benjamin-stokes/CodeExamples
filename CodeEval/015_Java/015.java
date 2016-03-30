import java.io.*;
public class Main {
    public static void main (String[] args) throws IOException {
	int x = 0;
	int y = 1;
	int xy = (y<<16) | x;
	if (xy == 65536){
	    System.out.println("LittleEndian");
	}else{
	    System.out.println("BigEndian");
	}
    }
}
