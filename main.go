package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	// "os"

	// "github.com/pkg/profile"
	"github.com/ua-parser/uap-go/uaparser"
)

func agent(r *http.Request) (string, string, string) {
	parser, err := uaparser.New("./regexes.yaml")
	if err != nil {
		log.Fatal(err)
	}
	client := parser.Parse(r.UserAgent())
	family := client.UserAgent.Family
	osfamily := client.Os.Family
	devfamily := client.Device.Family
	return family, osfamily, devfamily
}

// Start ...
func start(w http.ResponseWriter, r *http.Request) {
	family, osfamily, devfamily := agent(r)
	switch ua := osfamily; ua {
	case "iOS", "Android":
		fmt.Fprintf(w, "iOS, yo \n%s \n%s \n%s", osfamily, family, devfamily)
	default:
		fmt.Fprintf(w, "Whatevs \n%s \n%s \n%s", osfamily, family, devfamily)
	}
}

func login(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Eastern:", r.PostFormValue("eastern"))
	fmt.Println("Central:", r.PostFormValue("central"))
	fmt.Println("Northern:", r.PostFormValue("northern"))
	fmt.Println("Western:", r.PostFormValue("western"))
}

// RegHandler ...
func reghandler(w http.ResponseWriter, r *http.Request) {
	body, _ := ioutil.ReadFile(string("./templates/index.html"))
	_, osfamily, _ := agent(r)
	switch ua := osfamily; ua {
	case "iOS", "Android":
		fmt.Fprint(w, string(body))
	default:
		fmt.Fprint(w, string(body))
	}
}

func main() {
	// defer profile.Start().Stop()
	// defer profile.Start(profile.ProfilePath(os.Getenv("HOME"))).Stop()
	http.HandleFunc("/", start)
	http.HandleFunc("/reghandler", reghandler)
	http.HandleFunc("/login", login)
	log.Fatal(http.ListenAndServe(":8000", nil))
}
