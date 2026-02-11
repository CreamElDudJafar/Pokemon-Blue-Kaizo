PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries, PrizeMenuMon1Cost
	dw PrizeMenuMon2Entries, PrizeMenuMon2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

NoThanksText:
	db "NO THANKS@"

PrizeMenuMon1Entries:
	db IVYSAUR
	db CHARMELEON
IF DEF(_RED)
	db NIDORINA
ENDC
IF DEF(_BLUE)
	db WARTORTLE
ENDC
	db "@"

PrizeMenuMon1Cost:
IF DEF(_RED)
	bcd2 180
	bcd2 500
ENDC
IF DEF(_BLUE)
	bcd2 950
	bcd2 950
ENDC
	bcd2 1050
	db "@"

PrizeMenuMon2Entries:
IF DEF(_RED)
	db DRATINI
	db SCYTHER
ENDC
IF DEF(_BLUE)
	db NIDOKING
	db NIDOQUEEN
ENDC
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
IF DEF(_RED)
	bcd2 0950
	bcd2 5500
	bcd2 9999
ENDC
IF DEF(_BLUE)
	bcd2 4600
	bcd2 4600
	bcd2 1000
ENDC
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
