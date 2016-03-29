using System;
using System.IO;

class Program
{
    static void Main(string[] args)
    {
        StreamReader reader = File.OpenText(args[0]);
        while (!reader.EndOfStream)
        {
            string line = reader.ReadLine();
            if (null == line) continue;
            string[] data = line.Split();
            int M = Int32.Parse(data[data.Length-1]);
            if (data.Length-M > 0) Console.WriteLine(data[data.Length-1-M]);
        }
    }
}
