package main

import "fmt"

func main() {
	var a, b float64

	fmt.Println("Input number a: ")
	fmt.Scan(&a)
	fmt.Println("Input number b: ")
	fmt.Scan(&b)

	fmt.Println("a + b =", a+b)
	fmt.Println("a - b =", a-b)
	fmt.Println("a * b =", a*b)
	fmt.Println("a / b =", a/b)
}
