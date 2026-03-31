package main

import (
	"encoding/json"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	errorCount = promauto.NewCounter(prometheus.CounterOpts{
		Name: "api_error_count",
		Help: "Number of errors occurred",
	})
)

type Weather struct {
	Temperature float64 `json:"temperature"`
	Humidity    float64 `json:"humidity"`
	Pressure    float64 `json:"pressure"`
}

func main() {
	http.Handle("/metrics", promhttp.Handler())

	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("OK"))
	})

	http.HandleFunc("/weather", func(w http.ResponseWriter, r *http.Request) {
		weather := Weather{Temperature: 25.5, Humidity: 60.5, Pressure: 1013.25}

		errorCount.Inc()

		json.NewEncoder(w).Encode(weather)
	})

	http.ListenAndServe(":8080", nil)
}
