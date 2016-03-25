import java.io.*;
import java.util.Arrays;
import java.util.Comparator;
public class Main {
    public static void main (String[] args) throws IOException {
        File file = new File(args[0]);
        BufferedReader buffer = new BufferedReader(new FileReader(file));
        String line;
	int[] TimeArray = new int[3];
	while ((line = buffer.readLine()) != null) {
            line = line.trim();
	    String[] TimeStamps = line.split(" ");
	    int i=0;
	    int[][] SortArray = new int[TimeStamps.length][2];
	    for (String TimeStamp : TimeStamps){
		int j=0;
		for (String TimeTmp: TimeStamp.split(":")){
		    TimeArray[j] = Integer.parseInt(TimeTmp); j++;
		}
		SortArray[i][0] =
		    3600*TimeArray[0]+60*TimeArray[1]+TimeArray[2];
		SortArray[i][1] = i;
		i++;
	    }
	    Arrays.sort(SortArray, new Comparator<int[]>() {
		    public int compare(int[] int1, int[] int2) {
			return Integer.valueOf(int2[0]).compareTo(Integer.valueOf(int1[0]));
		    }
		});
	    System.out.printf("%s", TimeStamps[SortArray[0][1]]);
	    for (i=1; i < TimeStamps.length; i++){
		System.out.printf(" %s", TimeStamps[SortArray[i][1]]);
	    }
	    System.out.printf("\n"); 
	}
    }
}
