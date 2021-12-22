package util

import (
	"strings"
)

func ParseInput(input string) []string {
	content := strings.Split(input, "\n")

	return content
}
