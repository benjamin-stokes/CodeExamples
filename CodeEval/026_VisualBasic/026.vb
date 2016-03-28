Module Challenge
    Sub Main()
    	Dim infoReader As System.IO.FileInfo
    	infoReader = My.Computer.FileSystem.GetFileInfo(System.Environment.GetCommandLineArgs()(1))
    	Console.WriteLine(infoReader.Length)
    End Sub
End Module
