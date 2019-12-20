package auction

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
	"io/ioutil"
	"log"
	"net/http"
	"sort"
)

type Dsp struct {
	Id        int
	RequestTo string
}

type Dsps []Dsp

type Ecpm int

type Bid struct {
	Adid     string `json:"adid"`
	Creative string `json:"creative"`
	BidPrice Ecpm   `json:"price"`
	Impid    string `json:"impid"`
	Dsp      int
}

type Bids []Bid

type ResultStatus int

const (
	HAS_WINNER ResultStatus = iota
	NO_WINNER
)

type Result struct {
	Status ResultStatus
	Winner Bid
	Price  Ecpm
}

func Do(ctx context.Context, pubid int, dsps Dsps) Result {
	var bids Bids
	for _, dsp := range dsps {
		b, err := request(ctx, dsp, pubid)
		if err == nil {
			bids = append(bids, b)
		} else {
			log.Println(err)
		}
	}
	return auctionResult(bids)
}

func auctionResult(bids Bids) Result {
	sort.Slice(bids, func(i, j int) bool {
		return bids[i].BidPrice < bids[j].BidPrice
	})

	if len(bids) == 1 {
		return Result{HAS_WINNER, bids[0], 1} // 一人勝ちの場合は 1 円
	} else if len(bids) > 1 {
		return Result{HAS_WINNER, bids[0], bids[1].BidPrice + 1}
	} else {
		return Result{NO_WINNER, Bid{}, 0}
	}
}

func request(ctx context.Context, dsp Dsp, pubid int) (Bid, error) {
	reqBody := `{"pub":` + string(pubid) + `}`
	req, err := http.NewRequest(
		"POST",
		dsp.RequestTo,
		bytes.NewBuffer([]byte(reqBody)),
	)

	req = req.WithContext(ctx)

	if err != nil {
		return Bid{}, err
	}

	req.Header.Set("Content-Type", "application/json")
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return Bid{}, err
	}
	defer resp.Body.Close()

	bid := Bid{Dsp: dsp.Id}
	if resp.StatusCode != http.StatusOK {
		if resp.StatusCode == http.StatusNoContent {
			return Bid{}, errors.New("no bid")
		} else {
			return Bid{}, errors.New("bid response has error")
		}
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return Bid{}, err
	}
	if err := json.Unmarshal(body, &bid); err != nil {
		return Bid{}, err
	}

	return bid, nil
}
