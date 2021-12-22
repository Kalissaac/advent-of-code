package dec02

import (
	_ "embed"
	"log"
	"strconv"
	"strings"

	"github.com/Kalissaac/advent-of-code/year-2021/util"
)

var (
	//go:embed input.txt
	raw_input string
)

const (
	forward = iota
	down    = iota
	up      = iota
)

type directionEnum int

type Command struct {
	direction directionEnum
	distance  int
}

type Position struct {
	depth      int
	horizontal int
	aim        int
}

func parseInput(raw_input []string) []Command {
	formatted := make([]Command, len(raw_input))

	for i, v := range raw_input {
		split := strings.Split(v, " ")

		raw_direction := split[0]
		var direction directionEnum
		switch raw_direction {
		case "forward":
			direction = forward
		case "down":
			direction = down
		case "up":
			direction = up
		default:
			log.Fatal("Unknown direction: ", raw_direction)
		}

		distance, err := strconv.Atoi(split[1])
		if err != nil {
			log.Fatal("Could not parse distance: ", err)
		}

		formatted[i] = Command{
			direction,
			distance,
		}
	}
	return formatted
}

func Main() {
	println("Part One:", PartOne())
	println("Part Two:", PartTwo())
}

func PartOne() string {
	input := parseInput(util.ParseInput(raw_input))
	position := Position{}
	for _, command := range input {
		switch command.direction {
		case forward:
			position.horizontal += command.distance
		case down:
			position.depth += command.distance
		case up:
			position.depth -= command.distance
		}
	}
	return strconv.Itoa(position.horizontal * position.depth)
}

func PartTwo() string {
	input := parseInput(util.ParseInput(raw_input))
	position := Position{}
	for _, command := range input {
		switch command.direction {
		case forward:
			position.horizontal += command.distance
			position.depth += position.aim * command.distance
		case down:
			position.aim += command.distance
		case up:
			position.aim -= command.distance
		}
	}
	return strconv.Itoa(position.horizontal * position.depth)
}
