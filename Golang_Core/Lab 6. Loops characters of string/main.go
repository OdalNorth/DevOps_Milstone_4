package main

import (
	"fmt"
	"os"
)

func main() {
	str := os.Args[1]
	for i := 0; i < len(str); i++ {
		fmt.Println(string(str[i]))
	}
}
