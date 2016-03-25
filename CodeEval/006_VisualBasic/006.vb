

Module Challenge

    Function BackTrack(ByVal c(,) As Integer, ByVal x() As Char, ByVal y() As Char, ByVal i As Integer, ByVal j As Integer) As String
        If i = 0 Or j = 0 Then
            Return ""
        ElseIf x(i-1) = y(j-1) Then
            Return BackTrack(c, x, y, i-1, j-1) & x(i-1).ToString
        Else
            If c(i,j-1) > c(i-1,j) Then
                Return BackTrack(c, x, y, i, j-1)
            Else
                Return BackTrack(c, x, y, i-1, j)
            End If
        End If
    End Function

    Sub Main()
        Dim test As String
        Dim i As Integer
        Dim j As Integer
        Using fileStream As New System.IO.StreamReader(System.Environment.GetCommandLineArgs()(1))
            Do Until fileStream.EndOfStream
                test = fileStream.ReadLine
                Dim words As String() = test.Split(New Char() {";"c})
                Dim x() As Char = words(0).ToCharArray
                Dim y() As Char = words(1).ToCharArray
                Dim c(x.Length,y.Length) As Integer
                For i = 0 To x.Length
                    c(i,0) = 0
                Next
                For j = 0 To y.Length
                    c(0,j) = 0
                Next
                For i = 1 To x.Length
                    For j = 1 To y.Length
                        If x(i-1) = y(j-1) Then
                            c(i,j) = c(i-1,j-1) + 1
                        Else
                            c(i,j) = Math.Max(c(i-1,j), c(i,j-1))
                        End If
                    Next
                Next
                Console.WriteLine(BackTrack(c, x, y, x.Length, y.Length))
            Loop
        End Using
    End Sub
End Module
