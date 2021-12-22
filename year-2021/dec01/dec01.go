package dec01

import (
	_ "embed"
	"log"
	"math"
	"strconv"

	"github.com/Kalissaac/advent-of-code/year-2021/util"
)

var (
	//go:embed input.txt
	raw_input string
)

func Main() {
	println("Part One:", PartOne())
	println("Part Two:", PartTwo())
}

func formatInput(input []string) []int {
	formatted := make([]int, len(input))
	for i, v := range input {
		num, err := strconv.Atoi(v)
		if err != nil {
			log.Fatal("Could not parse input: ", err)
		}
		formatted[i] = num
	}
	return formatted
}

func PartOne() string {
	input := formatInput(util.ParseInput(raw_input))

	previous_measurement := input[0]
	depth_increases := 0
	for _, depth := range input {
		if depth > previous_measurement {
			depth_increases++
		}
		previous_measurement = depth
	}

	return strconv.Itoa(depth_increases)
}

func PartTwo() string {
	input := formatInput(util.ParseInput(raw_input))

	previous_measurement := 0
	measurement_increases := 0
	for i := range input {
		window_sum := 0
		for j := i; float64(j) < math.Min(float64(i+3), float64(len(input))); j++ {
			window_sum += input[j]
		}
		if window_sum > previous_measurement {
			measurement_increases++
		}
		previous_measurement = window_sum
	}

	return strconv.Itoa(measurement_increases - 1)
}
