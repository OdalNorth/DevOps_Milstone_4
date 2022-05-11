package main

import (
	"fmt"
	"os"
	"strconv"
)

func findLimit(arr []string) (float64, float64) {
	max, _ := strconv.ParseFloat(arr[0], 64)
	min := max

	for i := 0; i < len(arr); i++ {
		temp, _ := strconv.ParseFloat(arr[i], 64)

		if temp > max {
			max = temp
		}

		if temp < min {
			min = temp
		}
	}

	return max, min
}

func main() {
	arguments := os.Args[1:]

	max, min := findLimit(arguments)

	fmt.Println("max number:", max)
	fmt.Println("min number:", min)
}
