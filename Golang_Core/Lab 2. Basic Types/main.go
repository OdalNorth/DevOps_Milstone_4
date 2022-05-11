package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	_, err := strconv.Atoi(os.Args[1])
	if err == nil {
		fmt.Println("OK")
	} else {
		fmt.Println("Wrong")
	}
}
