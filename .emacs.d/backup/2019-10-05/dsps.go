package mock

import (
	"encoding/json"
	"fmt"
	"github.com/VG-Tech-Dojo/asase201910/auction"
	"log"
	"math/rand"
	"net/http"
	"strconv"
	"strings"
	"time"
)

func DspHandler(w http.ResponseWriter, r *http.Request) {
	log.Println(r)

	// God Number: この数値を元に挙動を変更する
	gn := rand.New(rand.NewSource(time.Now().UnixNano())).Intn(200)

	// 4 で割り切れたら no bid
	if (gn % 4) == 0 {
		write(w, http.StatusNoContent, "")
		return
	}

	// thinking time for bidding
	time.Sleep(time.Duration(gn) * time.Millisecond)

	dsp, _ := strconv.Atoi(strings.Split(r.URL.Path, "/")[2])
	b := auction.Bid{
		Adid: "adid",
		Creative: fmt.Sprintf("creative dsp: %d", dsp),
		BidPrice: auction.Ecpm(gn),
		Impid: "impid",
		Dsp: dsp,
	}

	bid, err := json.Marshal(b)
	if err != nil {
		log.Println("can't marshal bid object")
		write(w, http.StatusInternalServerError, "")
		return
	}

	write(w, http.StatusOK, string(bid))
}

func write(w http.ResponseWriter, statusCode int, body string) {
	w.Header().Set(`Content-Type`, `application/json`)
	w.WriteHeader(statusCode)
	fmt.Fprintf(w, string(body))
}
