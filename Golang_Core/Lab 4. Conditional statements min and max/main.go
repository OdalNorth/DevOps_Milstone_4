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

	var max, min float64

	if a > b && a > c {
		max = a
	} else if b > c {
		max = b
	} else {
		max = c
	}

	if a < b && a < c {
		min = a
	} else if b < c {
		min = b
	} else {
		min = c
	}

	fmt.Println("max = ", max)
	fmt.Println("min = ", min)
}
