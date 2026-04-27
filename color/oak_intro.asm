; Helper functions for oak intro

GetNidorinoPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_NIDORINO
ELSE
	ld a, PAL_PURPLEMON
ENDC
	jr GotPalID

GetRedPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_HERO
ELSE
	ld a, PAL_REDMON
ENDC
	jr GotPalID

GetGreenPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_LEAF
ELSE
	ld a, PAL_GIRL
ENDC
	jr GotPalID

GetRivalPalID:
	call ClearScreen
IF GEN_2_GRAPHICS
	ld a, PAL_GARY1
ELSE
	ld a, PAL_MEWMON
ENDC
	jr GotPalID

GotPalID:
	ld e, 0
	ld d, a

	ld a, 2
	ldh [rWBK], a
	push de
	CALL_INDIRECT LoadSGBPalette
	pop de
	ld e, 2
	CALL_INDIRECT LoadSGBPalette_Sprite
	xor a
	ldh [rWBK], a
	ret

