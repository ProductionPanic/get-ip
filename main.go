package main

//
// get-ip
//
// A simple go cli tool that takes a domain name or url and returns the IP address

import (
	"fmt"
	"log"
	"net"
	"os"
	"regexp"
)

func main() {
	args := os.Args[1:]

	if len(args) == 0 {
		log.Fatal("Please provide a domain name or url")
	}

	var domain string = args[0]

	// Get the IP address of the domain
	ip, err := getIP(domain)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(ip)
}

func getIP(domain string) (string, error) {
	re := regexp.MustCompile(`(?:https?:\/\/)?(?:www\.)?([^/]+).*`)
	domain = re.FindStringSubmatch(domain)[1]

	// Get the IP address of the domain
	ips, err := net.LookupIP(domain)
	if err != nil {
		return "", err
	}

	return ips[0].String(), nil
}
