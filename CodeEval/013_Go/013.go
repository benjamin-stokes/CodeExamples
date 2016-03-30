package main

import (
	"fmt"
	"strings"
)
import "log"
import "bufio"
import "os"

func main() {
	file, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		testline := scanner.Text()
		text := strings.Split(testline, ", ")
		testcases := strings.Split(text[1], "")
		for i := range testcases {
			text[0] = strings.Replace(text[0], testcases[i], "", -1)
		}
		fmt.Println(text[0])
	}
}
