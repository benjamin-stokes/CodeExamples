package main

import (
	"fmt"
	"math"
	"sort"
	"strconv"
	"strings"
)
import "log"
import "bufio"
import "os"

func main() {
	file, err := os.Open(os.Args[1])
	slen := 0
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		testline := scanner.Text()
		text := strings.Split(testline, ",")
		slen, err = strconv.Atoi(text[0])
		letters := strings.Split(text[1], "")
		sort.Strings(letters)
		var uniqueLettersTmp [1024]string
		uniqueLettersTmp[0] = letters[0]
		j := 1
		for i := 1; i < len(letters); i++ {
			if letters[i] != letters[i-1] {
				uniqueLettersTmp[j] = letters[i]
				j++
			}
		}
		uniqueLetters := uniqueLettersTmp[0:j]
		var indices [32]int
		for i := 0; i < slen; i++ {
			indices[i] = 0
		}
		var tmpStr string
		for j := 0; j < slen; j++ {
			tmpStr = uniqueLetters[indices[j]] + tmpStr
		}
		fmt.Printf("%s", tmpStr)
		i := 1
		for i < int(math.Pow(float64(len(uniqueLetters)),
			float64(slen))) {
			var tmpStr string
			indices[0]++
			for indice := range indices {
				if indices[indice] == len(uniqueLetters) {
					indices[indice] = 0
					indices[indice+1]++
				}
			}
			for j := 0; j < slen; j++ {
				tmpStr = uniqueLetters[indices[j]] + tmpStr
			}
			fmt.Printf(",%s", tmpStr)
			i++

		}
		fmt.Printf("\n")
	}
}
