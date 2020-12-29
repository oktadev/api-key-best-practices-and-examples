package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func Weather(c *gin.Context) {
	location := c.PostForm("location")
	fmt.Println("Location " + location)
	uri := "http://api.openweathermap.org/data/2.5/weather?q=" + location + "&APPID=" + os.Getenv("OPEN_WEATHER_TOKEN")
	response, error := http.Get(uri)
	if error != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": error.Error()})
	}
	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	c.Header("Access-Control-Allow-Origin", "http://localhost:8080")
	c.String(http.StatusOK, string(body))
}

func main() {
	r := gin.Default()
	r.POST("/api/weather", Weather)
	r.Run(":8000")
}
