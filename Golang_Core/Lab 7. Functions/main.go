package main

import (
	"fmt"
	"os"
	"strconv"
)

func calc(x string, y string) {
	a, _ := strconv.ParseFloat(x, 32)
	b, _ := strconv.ParseFloat(y, 32)

	fmt.Println("a + b =", a+b)
	fmt.Println("a - b =", a-b)
	fmt.Println("a * b =", a*b)
	fmt.Println("a / b =", a/b)
}

func main() {
	calc(os.Args[1], os.Args[2])
}
