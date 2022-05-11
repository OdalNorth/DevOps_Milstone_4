package main

import "fmt"

func main() {
	var a, b, c float64

	fmt.Println("Input number a: ")
	fmt.Scan(&a)
	fmt.Println("Input number b: ")
	fmt.Scan(&b)
	fmt.Println("Input number c: ")
	fmt.Scan(&c)

	var firststate bool = a >= -5 && b >= -5 && c >= -5
	var secondstate bool = a <= 5 && b <= 5 && c <= 5

	if firststate == true && secondstate == true {
		fmt.Println("OK")
	} else {
		fmt.Println("Wrong")
	}
}
