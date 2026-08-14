ShowPokedexMenu:
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wLastMenuItem], a
	inc a
	ld [wPokedexNum], a
	ldh [hJoy7], a
.setUpGraphics
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	callfar LoadPokedexTilePatterns
.doPokemonListMenu
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	xor a
	ld [hli], a ; top menu item X
	inc a
	ld [wMenuWatchMovingOutOfBounds], a
	inc hl
	inc hl
	ld a, 6
	ld [hli], a ; max menu item ID
	ld [hl], PAD_LEFT | PAD_RIGHT | PAD_B | PAD_A
	call HandlePokedexListMenu
	jr c, .goToSideMenu ; if the player chose a pokemon from the list
.exitPokedex
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ldh [hJoy7], a
	ld [wUnusedOverrideSimulatedJoypadStatesIndex], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	pop af
	ld [wListScrollOffset], a
	call GBPalWhiteOutWithDelay3
	call RunDefaultPaletteCommand
	jp ReloadMapData
.goToSideMenu
	call HandlePokedexSideMenu
	dec b
	jr z, .exitPokedex ; if the player chose Quit
	dec b
	jr z, .doPokemonListMenu ; if pokemon not seen or player pressed B button
	jp .setUpGraphics ; if pokemon data or area was shown

; handles the menu on the lower right in the pokedex screen
; OUTPUT:
; b = reason for exiting menu
; 00: showed pokemon data or area
; 01: the player chose Quit
; 02: the pokemon has not been seen yet or the player pressed the B button
HandlePokedexSideMenu:
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	push af
	ld b, a
	ld a, [wLastMenuItem]
	push af
	ld a, [wListScrollOffset]
	push af
	add b
	inc a
	ld [wPokedexNum], a
	ld a, [wPokedexNum]
	push af
	ld a, [wDexMaxSeenMon]
	push af ; this doesn't need to be preserved
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	ld b, 2
	jr z, .exitSideMenu
	call PokedexToIndex
	ld hl, wTopMenuItemY
	ld a, 7
	ld [hli], a ; top menu item Y
	ld a, 15
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 5
	ld [hli], a ; max menu item ID
	ld a, PAD_A | PAD_B
	ld [hli], a ; menu watched keys (A button and B button)
	xor a
	ld [hli], a ; old menu item ID
	ld [wMenuWatchMovingOutOfBounds], a
.handleMenuInput
	call HandleMenuInput
	bit B_PAD_B, a
	ld b, 2
	jr nz, .buttonBPressed
	ld a, [wCurrentMenuItem]
	and a
	jr z, .choseData
	dec a
	jr z, .choseStat
	dec a
	jr z, .choseMove
	dec a
	jr z, .choseCry
	dec a
	jr z, .choseArea
; chose Quit
	ld b, 1
.exitSideMenu
	pop af
	ld [wDexMaxSeenMon], a
	pop af
	ld [wPokedexNum], a
	pop af
	ld [wListScrollOffset], a
	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	push bc
	hlcoord 0, 3
	ld de, 20
	lb bc, ' ', 13
	call DrawTileLine ; cover up the menu cursor in the pokemon list
	pop bc
	ret

.buttonBPressed
	push bc
	hlcoord 15, 7
	ld de, 20
	lb bc, ' ', 11
	call DrawTileLine ; cover up the menu cursor in the side menu
	pop bc
	jr .exitSideMenu

.choseData
	xor a
	ld [wPokedexModeSelect], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

.choseStat
	ld a, 2
	ld [wPokedexModeSelect], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

.choseMove
	ld a, 1
	ld [wPokedexModeSelect], a
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

; play pokemon cry
.choseCry
	ld a, [wPokedexNum]
	call GetCryData
	call PlaySound
	jr .handleMenuInput

.choseArea
	predef LoadTownMap_Nest ; display pokemon areas
	ld b, 0
	jr .exitSideMenu

; handles the list of pokemon on the left of the pokedex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandlePokedexListMenu:
	xor a
	ldh [hAutoBGTransferEnabled], a
; draw the horizontal line separating the seen and owned amounts from the menu
	hlcoord 15, 6
	ld a, '─'
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	hlcoord 14, 0
	ld [hl], $71 ; vertical line tile
	hlcoord 14, 1
	call DrawPokedexVerticalLine
	hlcoord 14, 9
	call DrawPokedexVerticalLine
	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 2
	lb bc, 1, 3
	call PrintNumber ; print number of seen pokemon
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 5
	lb bc, 1, 3
	call PrintNumber ; print number of owned pokemon
	hlcoord 16, 1
	ld de, PokedexSeenText
	call PlaceString
	hlcoord 16, 4
	ld de, PokedexOwnText
	call PlaceString
	hlcoord 1, 1
	ld de, PokedexContentsText
	call PlaceString
	hlcoord 16, 7
	ld de, PokedexMenuItemsText
	call PlaceString
; find the highest pokedex number among the pokemon the player has seen
	ld hl, wPokedexSeenEnd - 1
	ld b, (wPokedexSeenEnd - wPokedexSeen) * 8 + 1
.maxSeenPokemonLoop
	ld a, [hld]
	ld c, 8
.maxSeenPokemonInnerLoop
	dec b
	sla a
	jr c, .storeMaxSeenPokemon
	dec c
	jr nz, .maxSeenPokemonInnerLoop
	jr .maxSeenPokemonLoop

.storeMaxSeenPokemon
	ld a, b
	ld [wDexMaxSeenMon], a
.loop
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 2
	lb bc, 14, 10
	call ClearScreenArea
	hlcoord 1, 3
	ld a, [wListScrollOffset]
	ld [wPokedexNum], a
	ld d, 7
	ld a, [wDexMaxSeenMon]
	cp 7
	jr nc, .printPokemonLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a
; loop to print pokemon pokedex numbers and names
; if the player has owned the pokemon, it puts a pokeball beside the name
.printPokemonLoop
	ld a, [wPokedexNum]
	inc a
	ld [wPokedexNum], a
	push af
	push de
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wPokedexNum
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber
	ld de, SCREEN_WIDTH
	add hl, de
	dec hl
	push hl
	ld hl, wPokedexOwned
	call IsPokemonBitSet
	pop hl
	ld a, ' '
	jr z, .writeTile
	ld a, $72 ; pokeball tile
.writeTile
	ld [hl], a ; put a pokeball next to pokemon that the player has owned
	push hl
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	jr nz, .getPokemonName ; if the player has seen the pokemon
	ld de, .dashedLine ; print a dashed line in place of the name if the player hasn't seen the pokemon
	jr .skipGettingName
.dashedLine ; for unseen pokemon in the list
	db "----------@"
.getPokemonName
	call PokedexToIndex
	call GetMonName
.skipGettingName
	pop hl
	inc hl
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	pop af
	ld [wPokedexNum], a
	dec d
	jr nz, .printPokemonLoop
	ld a, 01
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call GBPalNormal
	call HandleMenuInput
	bit B_PAD_B, a
	jp nz, .buttonBPressed
; check if Up pressed
	bit B_PAD_UP, a
	jr z, .checkIfDownPressed
.upPressed ; scroll up one row
	ld a, [wListScrollOffset]
	and a
	jp z, .loop
	dec a
	ld [wListScrollOffset], a
	jp .loop
.checkIfDownPressed
	bit B_PAD_DOWN, a
	jr z, .checkIfRightPressed
; Down pressed, scroll down one row
	ld a, [wDexMaxSeenMon]
	cp 7
	jp c, .loop ; can't if the list is shorter than 7
	sub 7
	ld b, a
	ld a, [wListScrollOffset]
	cp b
	jp z, .loop
	inc a
	ld [wListScrollOffset], a
	jp .loop
.checkIfRightPressed
	bit B_PAD_RIGHT, a
	jr z, .checkIfLeftPressed
; Right pressed, scroll down 7 rows
	ld a, [wDexMaxSeenMon]
	cp 7
	jp c, .loop ; can't if the list is shorter than 7
	sub 6
	ld b, a
	ld a, [wListScrollOffset]
	add 7
	ld [wListScrollOffset], a
	cp b
	jp c, .loop
	dec b
	ld a, b
	ld [wListScrollOffset], a
	jp .loop
.checkIfLeftPressed ; scroll up 7 rows
	bit B_PAD_LEFT, a
	jr z, .buttonAPressed
; Left pressed
	ld a, [wListScrollOffset]
	sub 7
	ld [wListScrollOffset], a
	jp nc, .loop
	xor a
	ld [wListScrollOffset], a
	jp .loop
.buttonAPressed
	scf
	ret
.buttonBPressed
	and a
	ret

DrawPokedexVerticalLine:
	ld c, 9 ; height of line
	ld de, SCREEN_WIDTH
	ld a, $71 ; vertical line tile
.loop
	ld [hl], a
	add hl, de
	xor 1 ; toggle between vertical line tile and box tile
	dec c
	jr nz, .loop
	ret

PokedexSeenText:
	db "SEEN@"

PokedexOwnText:
	db "OWN@"

PokedexContentsText:
	db "CONTENTS@"

PokedexMenuItemsText:
	db   "DATA"
	next "STAT"
	next "MOVE"
	next "CRY"
	next "AREA"
	next "QUIT@"

; tests if a pokemon's bit is set in the seen or owned pokemon bit fields
; INPUT:
; [wPokedexNum] = pokedex number
; hl = address of bit field
IsPokemonBitSet:
	ld a, [wPokedexNum]
	dec a
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret

; function to display pokedex data from outside the pokedex
ShowPokedexData:
	xor a
	ld [wPokedexModeSelect], a
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	callfar LoadPokedexTilePatterns ; load pokedex tiles

; function to display pokedex data from inside the pokedex
ShowPokedexDataInternal:
	ld hl, wStatusFlags2
	set BIT_NO_AUDIO_FADE_OUT, [hl]
	ld a, $33 ; 3/7 volume
	ldh [rAUDVOL], a
	call GBPalWhiteOut ; zero all palettes
	call ClearScreen
	ld a, [wPokedexNum]
	ld [wCurPartySpecies], a
	push af
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	pop af
	ld [wPokedexNum], a
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a

	hlcoord 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLine ; draw top border

	hlcoord 0, 17
	ld b, $6f
	call DrawTileLine ; draw bottom border

	hlcoord 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLine ; draw left border

	hlcoord 19, 1
	ld b, $67
	call DrawTileLine ; draw right border

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 9
	ld de, PokedexDataDividerLine
	call PlaceString ; draw horizontal divider line

	hlcoord 9, 6
	ld de, HeightWeightText
	call PlaceString

	call GetMonName
	hlcoord 9, 2
	call PlaceString

	ld hl, PokedexEntryPointers
	ld a, [wPokedexNum]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl] ; de = address of pokedex entry

	hlcoord 9, 4
	call PlaceString ; print species name

	ld h, b
	ld l, c
	push de
	ld a, [wPokedexNum]
	push af
	call IndexToPokedex

	hlcoord 2, 8
	ld a, '№'
	ld [hli], a
	ld a, '<DOT>'
	ld [hli], a
	ld de, wPokedexNum
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; print pokedex number

	ld hl, wPokedexOwned
	call IsPokemonBitSet
	pop af
	ld [wPokedexNum], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	pop de

	push af
	push bc
	push de
	push hl

	call Delay3
	call GBPalNormal
	call GetMonHeader ; load pokemon picture location
	hlcoord 1, 1
	call LoadFlippedFrontSpriteByMonIndex ; draw pokemon picture
	ld a, [wCurPartySpecies]
	call PlayCry

	pop hl
	pop de
	pop bc
	pop af

	ld a, c
	and a
	jp z, .waitForButtonPress ; if the pokemon has not been owned, don't print the height, weight, description, or moves
	inc de ; de = address of feet (height)
	ld a, [de] ; reads feet, but a is overwritten without being used
	hlcoord 12, 6
	lb bc, 1, 2
	call PrintNumber ; print feet (height)
	ld a, '′'
	ld [hl], a
	inc de
	inc de ; de = address of inches (height)
	hlcoord 15, 6
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber ; print inches (height)
	ld a, '″'
	ld [hl], a
; now print the weight (note that weight is stored in tenths of pounds internally)
	inc de
	inc de
	inc de ; de = address of upper byte of weight
	push de
; put weight in big-endian order at hDexWeight
	ld hl, hDexWeight
	ld a, [hl] ; save existing value of [hDexWeight]
	push af
	ld a, [de] ; a = upper byte of weight
	ld [hli], a ; store upper byte of weight in [hDexWeight]
	ld a, [hl] ; save existing value of [hDexWeight + 1]
	push af
	dec de
	ld a, [de] ; a = lower byte of weight
	ld [hl], a ; store lower byte of weight in [hDexWeight + 1]
	ld de, hDexWeight
	hlcoord 11, 8
	lb bc, 2, 5 ; 2 bytes, 5 digits
	call PrintNumber ; print weight
	hlcoord 14, 8
	ldh a, [hDexWeight + 1]
	sub 10
	ldh a, [hDexWeight]
	sbc 0
	jr nc, .next
	ld [hl], '0' ; if the weight is less than 10, put a 0 before the decimal point
.next
	inc hl
	ld a, [hli]
	ld [hld], a ; make space for the decimal point by moving the last digit forward one tile
	ld [hl], '<DOT>' ; decimal point tile
	pop af
	ldh [hDexWeight + 1], a ; restore original value of [hDexWeight + 1]
	pop af
	ldh [hDexWeight], a ; restore original value of [hDexWeight]
	pop hl
	ld a, [wPokedexModeSelect]
	cp 1
	jr z, .showMoves
	cp 2
	jr z, .showStats
	inc hl ; hl = address of pokedex description text
	bccoord 1, 11
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor ; print pokedex description text
	xor a
	ldh [hClearLetterPrintingDelayFlags], a
	jr .waitForButtonPress

.showStats
	ld a, [wPokedexNum]
	ld [wCurSpecies], a
	call GetMonHeader
	call Pokedex_PrintStatsText
	jr .exitDataPage

.showMoves
	call Pokedex_PrintMovesText
	jr .exitDataPage

.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and PAD_A | PAD_B
	jr z, .waitForButtonPress

.exitDataPage
	pop af
	ldh [hTileAnimations], a
	call GBPalWhiteOut
	call ClearScreen
	call RunDefaultPaletteCommand
	call LoadTextBoxTilePatterns
	call GBPalNormal
	ld hl, wStatusFlags2
	res BIT_NO_AUDIO_FADE_OUT, [hl]
	ld a, $77 ; max volume
	ldh [rAUDVOL], a
	ret


; STAT page 1: types and base stats. A advances to evolution data;
; B returns to the Pokédex side menu.
Pokedex_PrintStatsText:
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea

	hlcoord 1, 11
	ld de, DexType1Text
	call PlaceString
	hlcoord 2, 12
	predef PrintMonType
	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	jr z, .stats
	hlcoord 1, 13
	ld de, DexType2Text
	call PlaceString

.stats
	hlcoord 9, 10
	ld de, BaseStatsText
	call PlaceString
	hlcoord 12, 11
	ld de, HPText
	call PlaceString
	ld de, wMonHBaseHP
	hlcoord 15, 11
	lb bc, 1, 3
	call PrintNumber
	hlcoord 11, 12
	ld de, AtkText
	call PlaceString
	ld de, wMonHBaseAttack
	hlcoord 15, 12
	lb bc, 1, 3
	call PrintNumber
	hlcoord 11, 13
	ld de, DefText
	call PlaceString
	ld de, wMonHBaseDefense
	hlcoord 15, 13
	lb bc, 1, 3
	call PrintNumber
	hlcoord 11, 14
	ld de, SpdText
	call PlaceString
	ld de, wMonHBaseSpeed
	hlcoord 15, 14
	lb bc, 1, 3
	call PrintNumber
	hlcoord 11, 15
	ld de, SpcText
	call PlaceString
	ld de, wMonHBaseSpecial
	hlcoord 15, 15
	lb bc, 1, 3
	call PrintNumber

	ld b, 0
	ld hl, 0
	ld a, [wMonHBaseHP]
	ld c, a
	add hl, bc
	ld a, [wMonHBaseAttack]
	ld c, a
	add hl, bc
	ld a, [wMonHBaseDefense]
	ld c, a
	add hl, bc
	ld a, [wMonHBaseSpeed]
	ld c, a
	add hl, bc
	ld a, [wMonHBaseSpecial]
	ld c, a
	add hl, bc
	ld a, h
	ld [wBuffer], a
	ld a, l
	ld [wBuffer + 1], a
	hlcoord 9, 16
	ld de, TotalText
	call PlaceString
	ld de, wBuffer
	hlcoord 15, 16
	lb bc, 2, 3
	call PrintNumber

	; Another STAT page follows, so use the normal flashing continuation arrow.
	call Pokedex_WaitForPageInput
	ret c

	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	hlcoord 5, 10
	ld de, EvolutionsText
	call PlaceString
	ld a, [wPokedexNum]
	ld [wWhichPokemon], a
	ld [wCurPartySpecies], a
	farcall PrepareEvolutionData
	ld de, wPokedexDataBuffer
	ld a, 1
	ldh [hItemCounter], a

.loopEvolutionData
	ld a, [wMoveListCounter]
	ld c, a
	and a
	jp z, .waitEvolutionPage
	ld a, [de]
	cp EVOLVE_LEVEL
	jr z, .printLevelText
	cp EVOLVE_TRADE
	jr z, .printTradeText
	cp EVOLVE_ITEM
	jr z, .printItemText
	jp .nextEvolution
.printLevelText
	push de
	push bc
	ld de, EvolveLevelText
	hlcoord 1, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop bc
	pop de
	jr .itemIdByte
.printTradeText
	push de
	push bc
	ld de, EvolveTradeText
	hlcoord 1, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop bc
	pop de
	jr .itemIdByte
.printItemText
	push de
	push bc
	ld de, EvolveItemText
	hlcoord 1, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop bc
	pop de
.itemIdByte
	inc de
	ld a, [de]
	cp $ff
	jr z, .levelByte
	push de
	push bc
	ld [wNamedObjectIndex], a
	call GetItemName
	hlcoord 2, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop bc
	pop de
.levelByte
	inc de
	ld a, [de]
	cp 1
	jr z, .targetByte
	push de
	push bc
	hlcoord 16, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	lb bc, LEFT_ALIGN | 1, 3
	call PrintNumber
	pop bc
	pop de
	push de
	push bc
	ld de, EvolveLVLText
	hlcoord 15, 11
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop bc
	pop de
.targetByte
	inc de
.nextEvolution
	dec c
	ld a, c
	ld [wMoveListCounter], a
	ld hl, hItemCounter
	inc [hl]
	inc de
	jp .loopEvolutionData
.waitEvolutionPage
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and PAD_A | PAD_B
	jr z, .waitEvolutionPage
	ret

EvolutionsText:
	db "EVOLUTIONS@"
EvolveLevelText:
	db ".LEVEL-UP@"
EvolveTradeText:
	db ".TRADE@"
EvolveItemText:
	db ".@"
EvolveLVLText:
	db "<LVL>@"

; Build and display the current monster's level-up moves followed by its
; compatible TM/HM moves. Five entries are shown per page.
Pokedex_PrintMovesText:
	ld a, [wPokedexNum]
	ld [wWhichPokemon], a
	ld [wCurPartySpecies], a
	callfar PrepareLevelUpMoveList
	ld de, wMoveBuffer

.levelPage
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	hlcoord 1, 10
	ld de, LevelUpMovesText
	call PlaceString
	ld de, wMoveBuffer
	ld a, [wMoveListOffset]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, de
	ld d, h
	ld e, l
	xor a
	ld [wMovePrintCounter], a
	ld b, 5
.levelLines
	ld a, [wMoveListOffset]
	ld c, a
	ld a, [wMoveListCounter]
	cp c
	jr z, .levelPageDone
	jr c, .levelPageDone
	push bc
	push de
	call PrintLevelUpMoveLine
	pop de
	pop bc
	inc de
	inc de
	ld hl, wMoveListOffset
	inc [hl]
	dec b
	jr nz, .levelLines
.levelPageDone
	call Pokedex_WaitMovePageInput
	jr c, .done
	ld a, [wMoveListOffset]
	ld c, a
	ld a, [wMoveListCounter]
	cp c
	jr nz, .levelPage

	; Switch to TM/HM compatibility pages.
	callfar GetTMMoves
	xor a
	ld [wMoveListOffset], a
.tmPage
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	hlcoord 1, 10
	ld de, TMHMMovesText
	call PlaceString
	ld de, wMoveBuffer
	ld a, [wMoveListOffset]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, de
	ld d, h
	ld e, l
	xor a
	ld [wMovePrintCounter], a
	ld b, 5
.tmLines
	ld a, [de]
	and a
	jr z, .tmPageDone
	push bc
	push de
	call PrintTMHMMoveLine
	pop de
	pop bc
	inc de
	inc de
	ld hl, wMoveListOffset
	inc [hl]
	dec b
	jr nz, .tmLines
.tmPageDone
	ld a, [wMoveListOffset]
	ld c, a
	ld a, [wMoveListCounter]
	cp c
	jr z, .finalTMPage

	; More TM/HM entries follow, so show the continuation arrow.
	call Pokedex_WaitMovePageInput
	jr c, .done
	jr .tmPage

.finalTMPage
	; No page follows this one; wait normally without a down arrow.
	call Pokedex_WaitFinalPageInput
.done
	xor a
	ld [wMoveListOffset], a
	ret

; Flash the normal Pokédex continuation arrow at the lower-right.
; Carry = B (leave the current custom page). A advances.
Pokedex_WaitForPageInput:
	hlcoord 18, 16
	ld a, h
	ld [wMenuCursorLocation], a
	ld a, l
	ld [wMenuCursorLocation + 1], a

	; A always advances in PokedexPromptMultiButton; B interrupts.
	ld a, PAD_B
	ld [wMenuWatchedKeys], a
	callfar PokedexPromptMultiButton

	ldh a, [hJoy5]
	bit B_PAD_B, a
	jr nz, .cancel
	and a
	ret
.cancel
	scf
	ret

; MOVE uses the same flashing prompt whenever another page follows.
Pokedex_WaitMovePageInput:
	jp Pokedex_WaitForPageInput

; Final custom pages wait for A/B without showing a continuation arrow.
Pokedex_WaitFinalPageInput:
.wait
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and PAD_A | PAD_B
	jr z, .wait
	ret

PrintLevelUpMoveLine:
	push de
	ld a, [de]
	cp 1
	jr z, .startingMove

	; Level marker and level number.
	hlcoord 1, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld [hl], '<LVL>'
	hlcoord 2, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	lb bc, LEFT_ALIGN | 1, 3
	push de
	call PrintNumber
	pop de
	jr .moveName

.startingMove
	hlcoord 1, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	push de
	ld de, StartingMoveText
	call PlaceString
	pop de

.moveName
	inc de
	ld a, [de]
	ld [wNamedObjectIndex], a
	call GetMoveName
	hlcoord 5, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop de
	ld hl, wMovePrintCounter
	inc [hl]
	ret

PrintTMHMMoveLine:
	push de
	ld a, [de]
	ld c, a ; TM/HM number
	cp NUM_TMS + 1
	jr nc, .hm
	ld de, TMSymbolText
	jr .symbol
.hm
	ld de, HMSymbolText
.symbol
	hlcoord 1, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	pop de

	push de
	ld a, [de]
	cp NUM_TMS + 1
	jr c, .tmNumber
	sub NUM_TMS
.tmNumber
	ld [wBuffer], a
	ld de, wBuffer
	hlcoord 3, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber
	pop de

	inc de
	ld a, [de]
	ld [wNamedObjectIndex], a
	call GetMoveName
	hlcoord 6, 12
	ld a, [wMovePrintCounter]
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call PlaceString
	ld hl, wMovePrintCounter
	inc [hl]
	ret

DexType1Text:
	db "TYPE1/@"
DexType2Text:
	db "TYPE2/@"
BaseStatsText:
	db "BASE STATS@"
HPText:
	db "HP@"
AtkText:
	db "ATK@"
DefText:
	db "DEF@"
SpdText:
	db "SPD@"
SpcText:
	db "SPC@"
TotalText:
	db "TOTAL@"
LevelUpMovesText:
	db "LEVEL-UP MOVES:@"
TMHMMovesText:
	db "TM/HM MOVES:@"
TMSymbolText:
	db "TM@"
HMSymbolText:
	db "HM@"
StartingMoveText:
	db "---@"

HeightWeightText:
	db   "HT  ?′??″"
	next "WT   ???lb@"

; leftover from JPN Pokedex, where species have the suffix "Pokemon"
PokeText: ; unreferenced
	db "#@"

; horizontal line that divides the pokedex text description from the rest of the data
PokedexDataDividerLine:
	db $68, $69, $6B, $69, $6B, $69, $6B, $69, $6B, $6B
	db $6B, $6B, $69, $6B, $69, $6B, $69, $6B, $69, $6A
	db "@"

; draws a line of tiles
; INPUT:
; b = tile ID
; c = number of tile ID's to write
; de = amount to destination address after each tile (1 for horizontal, 20 for vertical)
; hl = destination address
DrawTileLine:
	push bc
	push de
.loop
	ld [hl], b
	add hl, de
	dec c
	jr nz, .loop
	pop de
	pop bc
	ret

INCLUDE "data/pokemon/dex_entries.asm"

PokedexToIndex:
	; converts the Pokédex number at [wPokedexNum] to an index
	push bc
	push hl
	ld a, [wPokedexNum]
	ld b, a
	ld c, 0
	ld hl, PokedexOrder

.loop ; go through the list until we find an entry with a matching dex number
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, c
	ld [wPokedexNum], a
	pop hl
	pop bc
	ret

IndexToPokedex:
	; converts the index number at [wPokedexNum] to a Pokédex number
	push bc
	push hl
	ld a, [wPokedexNum]
	dec a
	ld hl, PokedexOrder
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wPokedexNum], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/dex_order.asm"
