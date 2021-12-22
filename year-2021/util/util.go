package util

import (
	"log"
	"strconv"
	"strings"
)

func ParseInput(raw_input string) []string {
	content := strings.Split(raw_input, "\n")

	return content
}

func ParseInputAsInt(raw_input string) []int {
	input := ParseInput(raw_input)
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
