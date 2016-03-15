/* Ball Clock Solution version 4 by Ben Stokes March 3, 2016 */

package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

//Constants specifying how many balls can reside in each track
const MinMax = 4
const FiveMinMax = 11
const HourMax = 11
const MainMax = 128       // Maximum balls + 1
const MainMin = 27        // MinMax + FiveMinMax + HourMax + 1
const MinPerHalfDay = 720 // Minutes per Day

//Structure describing the current state of the ball clock

type ballclock struct {
	numMin     int             //ball count in minute track
	numFiveMin int             //ball count in five-minute track
	numHour    int             //ball count in hour track
	numMain    int             //ball count in main track
	Min        [MinMax]int     //ball #s in minute track
	FiveMin    [FiveMinMax]int //ball #s in five-minute track
	Hour       [HourMax]int    //ball #s in hour track
	Main       [MainMax]int    //ball #s in main track
}

//Initialize the ball clock with all balls in main track

func (b *ballclock) initialize() {
	b.numMin = 0
	b.numFiveMin = 0
	b.numHour = 0
	i := 0
	for i < b.numMain {
		b.Main[i] = i + 1
		i++
	}

}

/*
   Print out the current state of the ball clock in JSON format.  While there
   is almost certainly an easier way to do this, for a one-off this was a lot
   quicker than spending hours fussing over documentation
*/

func (b ballclock) printJSON() {
	var i int
	fmt.Printf("{\"Min\":[")
	if b.numMin > 0 {
		fmt.Printf("%d", b.Min[0])
		i = 1
		for i < b.numMin {
			fmt.Printf(",%d", b.Min[i])
			i++
		}
	}
	fmt.Printf("],\"FiveMin\":[")
	if b.numFiveMin > 0 {
		fmt.Printf("%d", b.FiveMin[0])
		i = 1
		for i < b.numFiveMin {
			fmt.Printf(",%d", b.FiveMin[i])
			i++
		}
	}
	fmt.Printf("],\"Hour\":[")
	if b.numHour > 0 {
		fmt.Printf("%d", b.Hour[0])
		i = 1
		for i < b.numHour {
			fmt.Printf(",%d", b.Hour[i])
			i++
		}
	}
	fmt.Printf("],\"Main\":[")
	if b.numMain > 0 {
		fmt.Printf("%d", b.Main[0])
		i = 1
		for i < b.numMain {
			fmt.Printf(",%d", b.Main[i])
			i++
		}
	}
	fmt.Printf("]}\n")
}

// Advance the ball clock by one minute

func (b *ballclock) advance() {
	var i, hotball int

	// The ball in motion -- the hotball

	hotball = b.Main[0]

	// Move the balls in the main track down one position

	i = 0
	for i < b.numMain {
		b.Main[i] = b.Main[i+1]
		i++
	}
	b.numMain--

	// Drop the hotball in the minute track

	if b.numMin < MinMax {
		b.Min[b.numMin] = hotball
		b.numMin++
	} else {

		// Return the minute track balls to the main track

		i = 0
		for i < MinMax {
			b.Main[b.numMain+i] = b.Min[MinMax-i-1]
			b.Min[MinMax-i-1] = 0
			i++
		}
		b.numMin = 0
		b.numMain += MinMax

		// Drop the hotball in the five minute track

		if b.numFiveMin < FiveMinMax {
			b.FiveMin[b.numFiveMin] = hotball
			b.numFiveMin++
		} else {

			// Return the five minute balls to the main track

			i = 0
			for i < FiveMinMax {
				b.Main[b.numMain+i] = b.FiveMin[FiveMinMax-i-1]
				b.FiveMin[FiveMinMax-i-1] = 0
				i++
			}
			b.numFiveMin = 0
			b.numMain += FiveMinMax

			// Drop the hotball in the hour track

			if b.numHour < HourMax {
				b.Hour[b.numHour] = hotball
				b.numHour++
			} else {

				// Return the hour balls to the main track

				i = 0
				for i < HourMax {
					b.Main[b.numMain+i] = b.Hour[HourMax-i-1]
					b.Hour[HourMax-i-1] = 0
					i++
				}
				b.numHour = 0
				b.numMain += HourMax

				// Return the hotball to the main track

				b.Main[b.numMain] = hotball
				b.numMain++
			}
		}
	}
}

func main() {

	// Parse the command line

	if len(os.Args) < 2 || len(os.Args) > 3 {
		fmt.Printf("Usage: ballclock <number of balls> [<minutes>]\n")
		os.Exit(2)
	}

	// Make sure the numBall variable is an integer

	numBall, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}

	// Make sure the numBall variable is in the range [27,127]

	if numBall < MainMin {
		fmt.Printf("Not enough balls!\n")
		os.Exit(2)
	} else if numBall > MainMax-1 {
		fmt.Printf("Too many balls!\n")
		os.Exit(2)
	}

	// Initialize the ball clock

	b := &ballclock{numMain: numBall}
	b.initialize()

	// Initialize a second ball clock to preserve the starting point

	bstart := &ballclock{numMain: numBall}
	bstart.initialize()

	// Consider case where number of minutes is specified

	if len(os.Args) == 3 {

		// Make sure variable numAdvance is an integer

		numAdvance, err := strconv.Atoi(os.Args[2])
		if err != nil {
			fmt.Println(err)
			os.Exit(2)
		}

		// Advance ball clock by NumAdvance minutes or until it cycles

		i := 0
		for i < numAdvance {
			b.advance()
			i++
			if b.numMain == numBall {
				if b.Main == bstart.Main {
					break
				}
			}
		}

		// If clock cycles subtract the number of full cycles from
		// numAdvance and then advance clock rest of the way

		if i < numAdvance {
			numAdvance = int(math.Mod(float64(numAdvance), float64(i)))
			i = 0
			for i < numAdvance {
				b.advance()
				i++
			}
		}
		// Print result in JSON and exit

		b.printJSON()
		os.Exit(0)
	}

	// Advance the clock 12 hours

	i := 0
	for i < MinPerHalfDay {
		b.advance()
		i++
	}
	days := 0.5

	// Advance 12 hours at a time until it cycles

	for b.Main != bstart.Main {
		i = 0
		for i < MinPerHalfDay {
			b.advance()
			i++
		}
		days += 0.5
	}

	fmt.Printf("%d balls cycle after %g days.\n", numBall, days)
}
