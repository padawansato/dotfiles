package adserver

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strconv"

	"github.com/VG-Tech-Dojo/asase201910/auction"
	"github.com/VG-Tech-Dojo/asase201910/db"
	_ "github.com/go-sql-driver/mysql"
)

type Server struct {
	DspsHost string
	ImpHost  string
	Db       *sql.DB
}

func NewServer(path string) Server {
	conf, err := NewConfig(path)
	if err != nil {
		panic(err)
	}

	db, err := db.OpenCampaignDB(conf.CampaignDB)
	if err != nil {
		panic(err)
	}
	return Server{conf.DspsHost, conf.ImpHost, db}
}

func (s *Server) Handler(w http.ResponseWriter, r *http.Request) {
	log.Println(r.Header.Get("User-Agent"))
        agent := r.Header.Get("User-Agent")
	pubid, err := getPubidParam(r.URL.Query())
	if err != nil {
		badParamResponse(w, err)
		return
	}

	ad, err := Ad(r.Context(), s.Db, pubid, s.DspsHost)
	if err != nil {
		// no content と 区別をつけたい (Ad の type を作るべき)
		errorResponse(w, err, http.StatusNoContent)
		return
	}

	adResponse(w, ad, pubid, s.ImpHost)
}

func getPubidParam(params url.Values) (int, error) {
	pubidParam := params.Get("pub")
	if pubidParam == "" {
		return -1, errors.New("no pubid")
	}

	pubid, err := strconv.Atoi(pubidParam)
	if err != nil {
		return -1, err
	}

	return pubid, nil
}

func adResponse(w http.ResponseWriter, ad auction.Result, pubid int, impHost string) {
	res := Response(ad, pubid, impHost)
	json, err := res.Json()
	if err != nil {
		errorResponse(w, err, http.StatusInternalServerError)
		return
	}
	w.Header().Set("Access-Control-Allow-Origin", "*")
	response(w, http.StatusOK, json)
}

func response(w http.ResponseWriter, statusCode int, body []byte) {
	w.WriteHeader(statusCode)
	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}

func badParamResponse(w http.ResponseWriter, err error) {
	log.Println(err)
	response(w, http.StatusBadRequest, []byte(""))
}

func errorResponse(w http.ResponseWriter, err error, responseCode int) {
	log.Println(err)
	w.WriteHeader(responseCode)
	w.Header().Set("Content-Type", "application/json")
	fmt.Fprintf(w, "")
}

