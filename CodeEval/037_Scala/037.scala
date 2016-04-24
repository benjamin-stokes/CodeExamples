object Main extends App {
  val abc = "abcdefghijklmnopqrstuvwxyz".split("")
  val source = scala.io.Source.fromFile(args(0))
  val lines = source.getLines.filter(_.length > 0)
  for (l <- lines) {
    val compstring = l.toLowerCase()
    val abc2 = abc.filter(compstring.lastIndexOf(_) == -1).mkString("")
    if (abc2.length() == 0) printf("NULL\n")
    else printf("%s\n", abc2)
  }
}
