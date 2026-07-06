DEF OPTION_PAGE_NEXT_X EQU 1
DEF OPTION_PAGE_PREV_X EQU 7
DEF OPTION_PAGE_Y EQU 16

DEF OPTION2_COLOR_Y EQU 3
DEF OPTION2_PAGE_Y EQU 6
DEF OPTION2_PREV_X EQU 1

DEF OPTION_COLORS_LEFT_XPOS EQU 8
DEF OPTION_COLORS_MIDDLE_XPOS EQU 11
DEF OPTION_COLORS_RIGHT_XPOS EQU 16

DisplayOptionMenu::
	hlcoord 0, 0
	ld b, 3
	ld c, 18
	call TextBoxBorder
	hlcoord 0, 5
	ld b, 3
	ld c, 18
	call TextBoxBorder
	hlcoord 0, 10
	ld b, 3
	ld c, 18
	call TextBoxBorder
	hlcoord 1, 1
	ld de, TextSpeedOptionText
	call PlaceString
	hlcoord 1, 6
	ld de, BattleAnimationOptionText
	call PlaceString
	hlcoord 1, 11
	ld de, BattleStyleOptionText
	call PlaceString
	hlcoord 0, OPTION_PAGE_Y
	ld de, OptionPageControlText
	call PlaceString

	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ASSERT BIT_FAST_TEXT_DELAY == 0
	inc a ; 1 << BIT_FAST_TEXT_DELAY
	ld [wLetterPrintingDelayFlags], a

	ld a, OPTION_PAGE_NEXT_X ; default page-control cursor X coordinate: NEXT
	ld [wOptionsCancelCursorX], a

	ld a, 3 ; text speed cursor Y coordinate
	ld [wTopMenuItemY], a
	call SetCursorPositionsFromOptions
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld [wTopMenuItemX], a
	ld a, $01
	ldh [hAutoBGTransferEnabled], a ; enable auto background transfer
	call Delay3

.loop
	call PlaceMenuCursor
	call SetOptionsFromCursorPositions

.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and ~PAD_SELECT ; any key besides select pressed?
	jr z, .getJoypadStateLoop
	bit B_PAD_B, b
	jr nz, .exitMenu
	bit B_PAD_START, b
	jr nz, .exitMenu
	bit B_PAD_A, b
	jr z, .checkDirectionKeys

; A was pressed
	ld a, [wTopMenuItemY]
	cp OPTION_PAGE_Y ; is the cursor on NEXT/PREV?
	jr nz, .loop
	ld a, [wOptionsCancelCursorX]
	cp OPTION_PAGE_NEXT_X
	jr z, .goToOptionsPage2
	cp OPTION_PAGE_PREV_X
	jr nz, .loop
.goToOptionsPage2
	ld a, SFX_PRESS_AB
	call PlaySound
	jp DisplayOptions2

.exitMenu
	ld a, SFX_PRESS_AB
	call PlaySound
	ret

.eraseOldMenuCursor
	ld [wTopMenuItemX], a
	call EraseMenuCursor
	jp .loop

.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit B_PAD_DOWN, b
	jr nz, .downPressed
	bit B_PAD_UP, b
	jr nz, .upPressed
	cp 8 ; cursor in Battle Animation section?
	jr z, .cursorInBattleAnimation
	cp 13 ; cursor in Battle Style section?
	jr z, .cursorInBattleStyle
	cp OPTION_PAGE_Y ; cursor in NEXT/PREV section?
	jr z, .cursorInPageControls
; cursor in Text Speed
	bit B_PAD_LEFT, b
	jp nz, .pressedLeftInTextSpeed
	jp .pressedRightInTextSpeed

.downPressed
	cp OPTION_PAGE_Y
	ld b, -13
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	ld b, 5
	cp 3
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .updateMenuVariables
	cp 8
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .updateMenuVariables
	ld b, 3
	inc hl ; wOptionsCancelCursorX / page controls cursor X
	jr .updateMenuVariables

.upPressed
	cp 8
	ld b, -5
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	cp 13
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .updateMenuVariables
	cp OPTION_PAGE_Y
	ld b, -3
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .updateMenuVariables
	ld b, 13
	inc hl ; wOptionsCancelCursorX / page controls cursor X

.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.cursorInBattleAnimation
	ld a, [wOptionsBattleAnimCursorX] ; battle animation cursor X coordinate
	xor 1 ^ 10 ; toggle between 1 and 10
	ld [wOptionsBattleAnimCursorX], a
	jp .eraseOldMenuCursor

.cursorInBattleStyle
	ld a, [wOptionsBattleStyleCursorX] ; battle style cursor X coordinate
	xor 1 ^ 10 ; toggle between 1 and 10
	ld [wOptionsBattleStyleCursorX], a
	jp .eraseOldMenuCursor

.cursorInPageControls
	ld a, [wOptionsCancelCursorX] ; page controls cursor X coordinate
	cp OPTION_PAGE_NEXT_X
	jr z, .moveToPrev
	ld a, OPTION_PAGE_NEXT_X
	jr .storePageControlCursor
.moveToPrev
	ld a, OPTION_PAGE_PREV_X
.storePageControlCursor
	ld [wOptionsCancelCursorX], a
	jp .eraseOldMenuCursor

.pressedLeftInTextSpeed
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	cp 1
	jr z, .updateTextSpeedXCoord
	cp 7
	jr nz, .fromSlowToMedium
	sub 6
	jr .updateTextSpeedXCoord

.fromSlowToMedium
	sub 7
	jr .updateTextSpeedXCoord

.pressedRightInTextSpeed
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	cp 14
	jr z, .updateTextSpeedXCoord
	cp 7
	jr nz, .fromFastToMedium
	add 7
	jr .updateTextSpeedXCoord

.fromFastToMedium
	add 6

.updateTextSpeedXCoord
	ld [wOptionsTextSpeedCursorX], a ; text speed cursor X coordinate
	jp .eraseOldMenuCursor

TextSpeedOptionText:
	db   "TEXT SPEED"
	next " FAST  MEDIUM SLOW@"

BattleAnimationOptionText:
	db   "BATTLE ANIMATION"
	next " ON       OFF@"

BattleStyleOptionText:
	db   "BATTLE STYLE"
	next " SHIFT    SET@"

OptionPageControlText:
	db "  NEXT  PREV@"

; sets the options variable according to the current placement of the menu cursors in the options menu
SetOptionsFromCursorPositions:
	ld hl, TextSpeedOptionData
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .textSpeedMatchFound
	inc hl
	jr .loop
.textSpeedMatchFound
	ld a, [hl]
	ld d, a
	ld a, [wOptionsBattleAnimCursorX] ; battle animation cursor X coordinate
	dec a
	jr z, .battleAnimationOn
; battle animation Off
	set BIT_BATTLE_ANIMATION, d
	jr .checkBattleStyle
.battleAnimationOn
	res BIT_BATTLE_ANIMATION, d
.checkBattleStyle
	ld a, [wOptionsBattleStyleCursorX] ; battle style cursor X coordinate
	dec a
	jr z, .battleStyleShift
; battle style Set
	set BIT_BATTLE_SHIFT, d
	jr .storeOptions
.battleStyleShift
	res BIT_BATTLE_SHIFT, d
.storeOptions
	ld a, d
	ld [wOptions], a
	ret

; reads the options variable and places menu cursors in the correct positions within the options menu
SetCursorPositionsFromOptions:
	ld hl, TextSpeedOptionData + 1
	ld a, [wOptions]
	ld c, a
	and $3f
	push bc
	ld de, 2
	call IsInArray
	pop bc
	dec hl
	ld a, [hl]
	ld [wOptionsTextSpeedCursorX], a ; text speed cursor X coordinate
	hlcoord 0, 3
	call .placeUnfilledRightArrow
	sla c
	ld a, 1 ; On
	jr nc, .storeBattleAnimationCursorX
	ld a, 10 ; Off
.storeBattleAnimationCursorX
	ld [wOptionsBattleAnimCursorX], a ; battle animation cursor X coordinate
	hlcoord 0, 8
	call .placeUnfilledRightArrow
	sla c
	ld a, 1
	jr nc, .storeBattleStyleCursorX
	ld a, 10
.storeBattleStyleCursorX
	ld [wOptionsBattleStyleCursorX], a ; battle style cursor X coordinate
	hlcoord 0, 13
	call .placeUnfilledRightArrow
; cursor in front of NEXT
	hlcoord 0, OPTION_PAGE_Y
	ld a, OPTION_PAGE_NEXT_X
	ld [wOptionsCancelCursorX], a
.placeUnfilledRightArrow
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], '▷'
	ret

; table that indicates how the 3 text speed options affect frame delays
; Format:
; 00: X coordinate of menu cursor
; 01: delay after printing a letter (in frames)
TextSpeedOptionData:
	db 14, TEXT_DELAY_SLOW
	db  7, TEXT_DELAY_MEDIUM
	db  1, TEXT_DELAY_FAST
	db  7, -1 ; end (default X coordinate)


; PureRGB-style second options page.
; This page only has the COLOR: OG / SGB / Y option and a PREV control.
; Left/Right immediately changes OG/SGB/Y and applies the palette.
; A toggles SGB1/SGB2 or Y1/Y2 only when the cursor is on SGB or Y.
DisplayOptions2:
	call DrawOptions2Menu
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a

	ld a, OPTION2_COLOR_Y
	ld [wTopMenuItemY], a
	call GetOptions2ColorXFromOptions
	ld a, b
	ld [wTopMenuItemX], a

	ld a, $01
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call WaitForOptions2NoKeys ; consume A/Left/Right used to enter page 2

.loop
	call PlaceMenuCursor

.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and ~PAD_SELECT
	jr z, .getJoypadStateLoop

	bit B_PAD_B, b
	jr nz, .exitMenu
	bit B_PAD_START, b
	jr nz, .exitMenu
	bit B_PAD_A, b
	jr z, .checkDirectionKeys

; A was pressed.
	ld a, [wTopMenuItemY]
	cp OPTION2_PAGE_Y
	jp z, DisplayOptionMenu ; PREV returns to page 1

; A on COLOR toggles SGB1/SGB2 or Y1/Y2, but does nothing on OG.
; Match PureRGB: A only toggles the secondary palette bit when not on OG.
	ld a, [wTopMenuItemX]
	cp OPTION_COLORS_LEFT_XPOS
	jr z, .loop
	call ToggleAltSGBYellowColors
	jp .loop

.exitMenu
	ld a, SFX_PRESS_AB
	call PlaySound
	ret

.eraseOldMenuCursor
	ld [wTopMenuItemX], a
	call EraseMenuCursor
	jp .loop

.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit B_PAD_DOWN, b
	jr nz, .downPressed
	bit B_PAD_UP, b
	jr nz, .upPressed
	cp OPTION2_PAGE_Y
	jr z, .loop

; cursor in COLOR row
	bit B_PAD_LEFT, b
	jr nz, .pressedLeftInColors
	bit B_PAD_RIGHT, b
	jr nz, .pressedRightInColors
	jp .loop

.downPressed
	cp OPTION2_PAGE_Y
	jr z, .moveToColors

; move from COLOR to PREV
	ld a, OPTION2_PAGE_Y
	ld [wTopMenuItemY], a
	ld a, OPTION2_PREV_X
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.upPressed
	cp OPTION2_PAGE_Y
	jr z, .moveToColors
	jp .loop

.moveToColors
	ld a, OPTION2_COLOR_Y
	ld [wTopMenuItemY], a
	call GetOptions2ColorXFromOptions
	ld a, b
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.pressedLeftInColors
	ld b, PAD_LEFT
	call GetOptions2ColorXPosition
	ld a, b
	ld [wTopMenuItemX], a
	call SetOptions2ColorFromCursorX
	call UpdateOptions2ColorPalette
	ld a, [wTopMenuItemX]
	jp .eraseOldMenuCursor

.pressedRightInColors
	ld b, PAD_RIGHT
	call GetOptions2ColorXPosition
	ld a, b
	ld [wTopMenuItemX], a
	call SetOptions2ColorFromCursorX
	call UpdateOptions2ColorPalette
	ld a, [wTopMenuItemX]
	jp .eraseOldMenuCursor

DrawOptions2Menu:
	call ClearScreen
	hlcoord 0, 0
	lb bc, 4, 18
	call TextBoxBorder
	hlcoord 1, 1
	ld de, Options2Text
	call PlaceString
	hlcoord 1, OPTION2_PAGE_Y
	ld de, Options2PrevText
	call PlaceString
	ld a, [wOptions2]
	and %01000011
	jp PrintSGBYellowOptionNumbers

Options2Text:
	db   "OPTIONS 2"
	next " COLOR: OG SGB  Y@"

Options2PrevText:
	db " PREV@"

UpdateOptions2ColorPalette:
	ld a, [wOptions2]
	and %01000011
	call PrintSGBYellowOptionNumbers
	jp RunDefaultPaletteCommand

SetOptions2ColorFromCursorX:
; Left/Right chooses the main color mode explicitly.
; This always drops SGB2/Y2 back to SGB1/Y1, like PureRGB.
	ld a, [wTopMenuItemX]
	cp OPTION_COLORS_RIGHT_XPOS
	jr z, .yellow
	cp OPTION_COLORS_MIDDLE_XPOS
	jr z, .sgb

.og
	ld b, PALETTES_DEFAULT
	jr StoreOptions2PaletteValue

.sgb
	ld b, PALETTES_SGB
	jr StoreOptions2PaletteValue

.yellow
	ld b, PALETTES_YELLOW
	jr StoreOptions2PaletteValue

StoreOptions2PaletteValue:
; Input: b = new palette value using bits 0,1,6.
; Preserve any unrelated wOptions2 bits, but replace the palette bits.
	ld a, [wOptions2]
	and %10111100
	or b
	ld [wOptions2], a
	ret

SetTwoBitPropFromXPosition:
; Compatibility label for older calls.
	jp SetOptions2ColorFromCursorX

GetOptions2ColorXFromOptions:
	ld a, [wOptions2]
	and %11
	ld b, OPTION_COLORS_LEFT_XPOS
	ret z
	cp PALETTES_YELLOW
	ld b, OPTION_COLORS_RIGHT_XPOS
	ret z
	ld b, OPTION_COLORS_MIDDLE_XPOS
	ret

GetOptions2ColorXPosition:
	ld a, b
	bit B_PAD_LEFT, b
	ld a, [wTopMenuItemX]
	jr nz, .left
	ld b, OPTION_COLORS_LEFT_XPOS
	cp OPTION_COLORS_RIGHT_XPOS
	ret z
	ld b, OPTION_COLORS_MIDDLE_XPOS
	cp OPTION_COLORS_LEFT_XPOS
	ret z
	ld b, OPTION_COLORS_RIGHT_XPOS
	ret
.left
	ld b, OPTION_COLORS_MIDDLE_XPOS
	cp OPTION_COLORS_RIGHT_XPOS
	ret z
	ld b, OPTION_COLORS_LEFT_XPOS
	cp OPTION_COLORS_MIDDLE_XPOS
	ret z
	ld b, OPTION_COLORS_RIGHT_XPOS
	ret

ToggleAltSGBYellowColors:
; A toggles only the current non-OG palette family.
; This reads wOptions2 instead of cursor X, so it works for SGB1/SGB2 and Y1/Y2.
	ld a, [wOptions2]
	and %01000011
	cp PALETTES_SGB
	jr z, .setSGB2
	cp PALETTES_SGB2
	jr z, .setSGB1
	cp PALETTES_YELLOW
	jr z, .setYellow2
	cp PALETTES_YELLOW2
	jr z, .setYellow1
	ret ; OG does nothing

.setSGB2
	ld b, PALETTES_SGB2
	jr .store

.setSGB1
	ld b, PALETTES_SGB
	jr .store

.setYellow2
	ld b, PALETTES_YELLOW2
	jr .store

.setYellow1
	ld b, PALETTES_YELLOW

.store
	call StoreOptions2PaletteValue
	ld a, SFX_PRESS_AB
	call PlaySound
	call UpdateOptions2ColorPalette
	jp WaitForOptions2NoKeys

WaitForOptions2NoKeys:
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and PAD_A | PAD_B | PAD_START | PAD_LEFT | PAD_RIGHT | PAD_UP | PAD_DOWN
	jr nz, WaitForOptions2NoKeys
	ret

; input: a = color mode indicator.
; bit 6 = alternate color mode, bits 0-1 = main color mode.
PrintSGBYellowOptionNumbers:
	hlcoord 15, 3
	cp PALETTES_SGB2 ; SGB2
	ld [hl], '2'
	jr z, .next
	ld [hl], '1'
.next
	hlcoord 18, 3
	cp PALETTES_YELLOW2 ; Y2
	ld [hl], '2'
	ret z
	ld [hl], '1'
	ret