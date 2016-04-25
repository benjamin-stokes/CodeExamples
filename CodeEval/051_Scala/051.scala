import scala.math
import scala.util.control._
object Main extends App {
  val loop = new Breaks
  val source = scala.io.Source.fromFile(args(0))
  val lines = source.getLines.filter(_.length > 0)
  loop.breakable{
    while(lines.hasNext){
      val num = lines.next().toInt
       if (num == 0) loop.break
      val pairs = Array.ofDim[Float](num,2)
      for (i <- 0 to num-1) {
        pairs(i) = lines.next().split(" ").map(_.toFloat)
      }
      var dist = 10000.0
      for (i <- 0 to num-2){
        for (j <- i+1 to num-1){
          val disttmp = math.sqrt(math.pow((pairs(i)(0)-pairs(j)(0)),2) +
            math.pow((pairs(i)(1)-pairs(j)(1)),2))
          if (disttmp < dist) dist = disttmp
        }
      }
      if (dist < 10000) printf("%.4f\n", dist)
      else printf("INFINITY\n")
    }
  }
}
