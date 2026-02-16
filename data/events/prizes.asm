PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

NoThanksText:
	db "NO THANKS@"

PrizeMenuMon1Entries:
	db IVYSAUR
	db CHARMELEON
	db WARTORTLE
	db "@"

PrizeMenuMon1Cost:
	bcd2 950
	bcd2 950
	bcd2 1050
	db "@"

PrizeMenuMon2Entries:
	db NIDOKING
	db NIDOQUEEN
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
	bcd2 4600
	bcd2 4600
	bcd2 1000
	db "@"

PrizeMenuTMsEntries:
	db TM_ROCK_SLIDE
	db TM_HYPER_BEAM
	db TM_SUBSTITUTE
	db "@"

PrizeMenuTMsCost:
	bcd2 3300
	bcd2 5555
	bcd2 9900
	db "@"
