package util

import (
	"io/ioutil"
	"log"
	"strings"
)

func ParseInput(file_name string) []string {
	raw_content, err := ioutil.ReadFile(file_name)

	if err != nil {
		log.Fatal(err)
	}

	str_content := string(raw_content)
	content := strings.Split(str_content, "\n")

	return content
}
