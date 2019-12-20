package adserver

import (
	"context"
	"strconv"

	"database/sql"

	"github.com/VG-Tech-Dojo/asase201910/auction"
	"github.com/VG-Tech-Dojo/asase201910/model"
)

func Ad(ctx context.Context, db *sql.DB, pubid int, dspsHost string) (auction.Result, error) {
	c, err := model.FindCampaign(ctx, db, pubid)
	if err != nil {
		return auction.Result{}, err
	}
	dsps := make(auction.Dsps, len(c.Dsps))
	for i, dspCode := range c.Dsps {
		dsps[i] = auction.Dsp{dspCode, dspsHost + "/dsp/" + strconv.Itoa(dspCode)}
	}
	return auction.Do(ctx, pubid, dsps), nil
}
