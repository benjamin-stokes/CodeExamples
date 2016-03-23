package main

import "fmt"
import "math"

func main() {

	var i, k int
	var j, primesum float64
	primesum = 2
	j = 3
	i = 1
	for i < 1000 {
		k = 2
		for k < int(j) {
			if k > int(math.Sqrt(j)) {
				primesum += j
				i++
				j++
				break
			} else if int(j)%k == 0 {
				j++
				break
			}
			k++
		}
	}
	fmt.Printf("%7.0f\n", primesum)
}
