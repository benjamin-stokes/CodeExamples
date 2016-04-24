object Main extends App {
  val source = scala.io.Source.fromFile(args(0))
  val lines = source.getLines.filter(_.length > 0)
  for (l <- lines) {
    val numlist = l.split(",").map(_.toInt).distinct
    var first = true
    for (i <- numlist){
      if (first) {
        printf("%d", i); first = false
      }
      else printf(",%d", i)
    }
    printf("\n")
  }
}
