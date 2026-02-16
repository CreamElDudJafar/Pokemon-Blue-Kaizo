MACRO npctrade
; give mon, get mon, dialog id, nickname
	db \1, \2, \3
	dname \4, NAME_LENGTH
ENDM

TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH
	; The two instances of TRADE_DIALOGSET_EVOLUTION are a leftover
	; from the Japanese Blue trades, which used species that evolve.
	; TRADE_DIALOGSET_EVOLUTION did not refer to evolution in Japanese
	; Red/Green. Japanese Blue changed _AfterTrade2Text to say your Pokémon
	; "went and evolved" and also changed the trades to match. English
	; Red/Blue uses the original JP Red/Green trades but with the JP Blue
	; post-trade text. English Yellow changed _AfterTrade2Text to
	; not mention evolution.
	npctrade FARFETCHD,  FLAREON,   TRADE_DIALOGSET_CASUAL,    "FLAREON"
	npctrade GOLBAT,     MR_MIME,   TRADE_DIALOGSET_CASUAL,    "Mr.×MIME"
	npctrade BUTTERFREE, BEEDRILL,  TRADE_DIALOGSET_HAPPY,     "CHIKUCHIKU" ; unused
	npctrade STARYU,     DRATINI,   TRADE_DIALOGSET_CASUAL,    "DRAGONITE"
	npctrade BUTTERFREE, TENTACOOL, TRADE_DIALOGSET_HAPPY,     "TENTACRUEL"
	npctrade CHANSEY,    PINSIR,    TRADE_DIALOGSET_CASUAL,    "PINSIR"
	npctrade SPEAROW,    HORSEA,    TRADE_DIALOGSET_EVOLUTION, "SEADRA"
	npctrade KADABRA,    ALAKAZAM,  TRADE_DIALOGSET_EVOLUTION, "ALAKAZAM"
	npctrade RAICHU,     RAICHU,    TRADE_DIALOGSET_HAPPY,     "RAICHU"
	npctrade BEEDRILL,   GOLDEEN,   TRADE_DIALOGSET_HAPPY,     "SEAKING"
	assert_table_length NUM_NPC_TRADES
