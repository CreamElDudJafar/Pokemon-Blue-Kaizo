DEF OPTION_PAGE_NEXT_X EQU 1
DEF OPTION_PAGE_PREV_X EQU 7
DEF OPTION_PAGE_Y EQU 16

DEF OPTION2_COLOR_Y EQU 3
DEF OPTION2_SOUND_Y EQU 9
DEF OPTION2_PAGE_Y EQU 13
DEF OPTION2_PREV_X EQU 1

DEF OPTION_COLORS_LEFT_XPOS EQU 8
DEF OPTION_COLORS_MIDDLE_XPOS EQU 11
DEF OPTION_COLORS_RIGHT_XPOS EQU 16

DEF OPTION_SOUND_MONO_X EQU 1
DEF OPTION_SOUND_EAR1_X EQU 8
DEF OPTION_SOUND_EAR2_X EQU 12
DEF OPTION_SOUND_EAR3_X EQU 16


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
	inc a
	ld [wLetterPrintingDelayFlags], a

	ld a, OPTION_PAGE_NEXT_X
	ld [wOptionsCancelCursorX], a

	ld a, 3
	ld [wTopMenuItemY], a
	call SetCursorPositionsFromOptions
	ld a, [wOptionsTextSpeedCursorX]
	ld [wTopMenuItemX], a
	ld a, $01
	ldh [hAutoBGTransferEnabled], a
	call Delay3

.loop
	call PlaceMenuCursor
	call SetOptionsFromCursorPositions

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

	ld a, [wTopMenuItemY]
	cp OPTION_PAGE_Y
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
	cp 8
	jr z, .cursorInBattleAnimation
	cp 13
	jr z, .cursorInBattleStyle
	cp OPTION_PAGE_Y
	jr z, .cursorInPageControls

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
	inc hl
	jr z, .updateMenuVariables
	cp 8
	inc hl
	jr z, .updateMenuVariables
	ld b, 3
	inc hl
	jr .updateMenuVariables

.upPressed
	cp 8
	ld b, -5
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	cp 13
	inc hl
	jr z, .updateMenuVariables
	cp OPTION_PAGE_Y
	ld b, -3
	inc hl
	jr z, .updateMenuVariables
	ld b, 13
	inc hl

.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.cursorInBattleAnimation
	ld a, [wOptionsBattleAnimCursorX]
	xor 1 ^ 10
	ld [wOptionsBattleAnimCursorX], a
	jp .eraseOldMenuCursor

.cursorInBattleStyle
	ld a, [wOptionsBattleStyleCursorX]
	xor 1 ^ 10
	ld [wOptionsBattleStyleCursorX], a
	jp .eraseOldMenuCursor

.cursorInPageControls
	ld a, [wOptionsCancelCursorX]
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
	ld a, [wOptionsTextSpeedCursorX]
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
	ld a, [wOptionsTextSpeedCursorX]
	cp 14
	jr z, .updateTextSpeedXCoord
	cp 7
	jr nz, .fromFastToMedium
	add 7
	jr .updateTextSpeedXCoord

.fromFastToMedium
	add 6

.updateTextSpeedXCoord
	ld [wOptionsTextSpeedCursorX], a
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


SetOptionsFromCursorPositions:
	ld hl, TextSpeedOptionData
	ld a, [wOptionsTextSpeedCursorX]
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

	ld a, [wOptionsBattleAnimCursorX]
	dec a
	jr z, .battleAnimationOn
	set BIT_BATTLE_ANIMATION, d
	jr .checkBattleStyle

.battleAnimationOn
	res BIT_BATTLE_ANIMATION, d

.checkBattleStyle
	ld a, [wOptionsBattleStyleCursorX]
	dec a
	jr z, .battleStyleShift
	set BIT_BATTLE_SHIFT, d
	jr .storeOptions

.battleStyleShift
	res BIT_BATTLE_SHIFT, d

.storeOptions
	ld a, d
	and $cf
	ld d, a
	ld a, [wOptions]
	and $30
	or d
	ld [wOptions], a
	ret

SetCursorPositionsFromOptions:
	ld hl, TextSpeedOptionData + 1
	ld a, [wOptions]
	ld c, a
	and $0f
	push bc
	ld de, 2
	call IsInArray
	pop bc
	dec hl
	ld a, [hl]
	ld [wOptionsTextSpeedCursorX], a
	hlcoord 0, 3
	call .placeUnfilledRightArrow

	sla c
	ld a, 1
	jr nc, .storeBattleAnimationCursorX
	ld a, 10

.storeBattleAnimationCursorX
	ld [wOptionsBattleAnimCursorX], a
	hlcoord 0, 8
	call .placeUnfilledRightArrow

	sla c
	ld a, 1
	jr nc, .storeBattleStyleCursorX
	ld a, 10

.storeBattleStyleCursorX
	ld [wOptionsBattleStyleCursorX], a
	hlcoord 0, 13
	call .placeUnfilledRightArrow

	hlcoord 0, OPTION_PAGE_Y
	ld a, OPTION_PAGE_NEXT_X
	ld [wOptionsCancelCursorX], a

.placeUnfilledRightArrow
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], '▷'
	ret


TextSpeedOptionData:
	db 14, TEXT_DELAY_SLOW
	db  7, TEXT_DELAY_MEDIUM
	db  1, TEXT_DELAY_FAST
	db  7, -1


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
	call WaitForOptions2NoKeys

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

	ld a, [wTopMenuItemY]
	cp OPTION2_PAGE_Y
	jp z, DisplayOptionMenu

	cp OPTION2_COLOR_Y
	jr nz, .loop

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

	cp OPTION2_COLOR_Y
	jr z, .cursorInColor
	cp OPTION2_SOUND_Y
	jr z, .cursorInSound
	jp .loop

.cursorInColor
	bit B_PAD_LEFT, b
	jr nz, .pressedLeftInColors
	bit B_PAD_RIGHT, b
	jr nz, .pressedRightInColors
	jp .loop

.cursorInSound
	bit B_PAD_LEFT, b
	jp nz, .pressedLeftInSound
	bit B_PAD_RIGHT, b
	jp nz, .pressedRightInSound
	jp .loop

.downPressed
	cp OPTION2_COLOR_Y
	jr z, .moveToSound
	cp OPTION2_SOUND_Y
	jr z, .moveToPrev
	cp OPTION2_PAGE_Y
	jr z, .moveToColor
	jp .loop

.upPressed
	cp OPTION2_COLOR_Y
	jr z, .moveToPrev
	cp OPTION2_SOUND_Y
	jr z, .moveToColor
	cp OPTION2_PAGE_Y
	jr z, .moveToSound
	jp .loop

.moveToColor
	ld a, OPTION2_COLOR_Y
	ld [wTopMenuItemY], a
	call GetOptions2ColorXFromOptions
	ld a, b
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.moveToSound
	ld a, OPTION2_SOUND_Y
	ld [wTopMenuItemY], a
	call GetOptions2SoundXFromOptions
	ld a, b
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	jp .loop

.moveToPrev
	ld a, OPTION2_PAGE_Y
	ld [wTopMenuItemY], a
	ld a, OPTION2_PREV_X
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

.pressedLeftInSound
	call MoveOptions2SoundLeft
	ld a, b
	ld [wTopMenuItemX], a
	call SetOptions2SoundFromCursorX
	ld a, [wTopMenuItemX]
	jp .eraseOldMenuCursor

.pressedRightInSound
	call MoveOptions2SoundRight
	ld a, b
	ld [wTopMenuItemX], a
	call SetOptions2SoundFromCursorX
	ld a, [wTopMenuItemX]
	jp .eraseOldMenuCursor


DrawOptions2Menu:
	call ClearScreen

; original Color box
	hlcoord 0, 0
	lb bc, 4, 18
	call TextBoxBorder
	hlcoord 1, 1
	ld de, Options2ColorText
	call PlaceString

; new Sound box
	hlcoord 0, 6
	lb bc, 4, 18
	call TextBoxBorder
	hlcoord 1, 7
	ld de, Options2SoundText
	call PlaceString

; PREV below Sound box
	hlcoord 1, OPTION2_PAGE_Y
	ld de, Options2PrevText
	call PlaceString

	ld a, [wOptions2]
	and %01000011
	call PrintSGBYellowOptionNumbers
	ret


Options2ColorText:
	db   "OPTIONS 2"
	next " COLOR: OG SGB  Y@"

Options2SoundText:
	db   "SOUND:"
	next " MONO   E1  E2  E3@"

Options2PrevText:
	db " PREV@"


UpdateOptions2ColorPalette:
	ld a, [wOptions2]
	and %01000011
	call PrintSGBYellowOptionNumbers
	jp RunDefaultPaletteCommand


SetOptions2ColorFromCursorX:
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
	ld a, [wOptions2]
	and %10111100
	or b
	ld [wOptions2], a
	ret


SetTwoBitPropFromXPosition:
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
	ret

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


GetOptions2SoundXFromOptions:
	ld a, [wOptions]
	and $30
	swap a
	and $03
	ld b, OPTION_SOUND_MONO_X
	ret z
	cp $01
	ld b, OPTION_SOUND_EAR1_X
	ret z
	cp $02
	ld b, OPTION_SOUND_EAR2_X
	ret z
	ld b, OPTION_SOUND_EAR3_X
	ret


MoveOptions2SoundRight:
	ld a, [wTopMenuItemX]
	cp OPTION_SOUND_MONO_X
	jr z, .ear1
	cp OPTION_SOUND_EAR1_X
	jr z, .ear2
	cp OPTION_SOUND_EAR2_X
	jr z, .ear3
	ld b, OPTION_SOUND_MONO_X
	ret

.ear1
	ld b, OPTION_SOUND_EAR1_X
	ret

.ear2
	ld b, OPTION_SOUND_EAR2_X
	ret

.ear3
	ld b, OPTION_SOUND_EAR3_X
	ret


MoveOptions2SoundLeft:
	ld a, [wTopMenuItemX]
	cp OPTION_SOUND_MONO_X
	jr z, .ear3
	cp OPTION_SOUND_EAR1_X
	jr z, .mono
	cp OPTION_SOUND_EAR2_X
	jr z, .ear1
	ld b, OPTION_SOUND_EAR2_X
	ret

.mono
	ld b, OPTION_SOUND_MONO_X
	ret

.ear1
	ld b, OPTION_SOUND_EAR1_X
	ret

.ear3
	ld b, OPTION_SOUND_EAR3_X
	ret


SetOptions2SoundFromCursorX:
	ld a, [wTopMenuItemX]
	cp OPTION_SOUND_EAR1_X
	jr z, .ear1
	cp OPTION_SOUND_EAR2_X
	jr z, .ear2
	cp OPTION_SOUND_EAR3_X
	jr z, .ear3

.mono
	ld b, $00
	jr .store

.ear1
	ld b, $10
	jr .store

.ear2
	ld b, $20
	jr .store

.ear3
	ld b, $30

.store
	xor a
	ldh [rNR51], a
	ld a, [wOptions]
	and $cf
	or b
	ld [wOptions], a
	ret


WaitForOptions2NoKeys:
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and PAD_A | PAD_B | PAD_START | PAD_LEFT | PAD_RIGHT | PAD_UP | PAD_DOWN
	jr nz, WaitForOptions2NoKeys
	ret


PrintSGBYellowOptionNumbers:
	hlcoord 15, 3
	cp PALETTES_SGB2
	ld [hl], '2'
	jr z, .next
	ld [hl], '1'

.next
	hlcoord 18, 3
	cp PALETTES_YELLOW2
	ld [hl], '2'
	ret z
	ld [hl], '1'
	ret