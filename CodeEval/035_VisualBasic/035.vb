Imports System.Text.RegularExpressions

Module Challenge
    Sub Main()
        Dim test As String
        Dim pattern As String = "^(?("")("".+?(?<!\\)""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" + "(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9][\-a-z0-9]{0,22}[a-z0-9]))$"
        Using fileStream As New System.IO.StreamReader(System.Environment.GetCommandLineArgs()(1))
            Do Until fileStream.EndOfStream
                test = fileStream.ReadLine
                Console.WriteLine(Regex.IsMatch(test, pattern, RegexOptions.IgnoreCase).ToString().ToLower())
            Loop
        End Using
    End Sub
End Module
