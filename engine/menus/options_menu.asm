DisplayOptionMenu::
	call InitOptionsMenu

.optionMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and PAD_START | PAD_B
	jr nz, .exitOptionMenu

	call OptionsControl
	jr c, .dpadDelay

	call GetOptionPointer
	jr c, .exitOptionMenu

.dpadDelay
	call OptionsMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .optionMenuLoop

.exitOptionMenu
	ret


GetOptionPointer:
	ld a, [wOptionsCursorLocation]
	ld e, a
	ld d, 0
	ld hl, OptionMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl


OptionMenuJumpTable:
	dw OptionsMenu_TextSpeed
	dw OptionsMenu_BattleAnimations
	dw OptionsMenu_BattleStyle
	dw OptionsMenu_SpeakerSettings
	dw OptionsMenu_Color
	dw OptionsMenu_Cancel


OptionsMenu_TextSpeed:
	call GetTextSpeed
	ldh a, [hJoy5]
	bit B_PAD_RIGHT, a
	jr nz, .pressedRight
	bit B_PAD_LEFT, a
	jr nz, .pressedLeft
	jr .print

.pressedRight
	inc c
	ld a, c
	cp 3
	jr c, .save
	ld c, 0
	jr .save

.pressedLeft
	ld a, c
	and a
	jr nz, .noWrapLeft
	ld c, 3
.noWrapLeft
	dec c

.save
	call GetTextSpeedValueFromIndex
	ld a, [wOptions]
	and ~TEXT_DELAY_MASK
	or e
	ld [wOptions], a

.print
	ld b, 0
	ld hl, TextSpeedStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 2
	call PlaceString
	and a
	ret


TextSpeedStringsPointerTable:
	dw SlowText
	dw MediumText
	dw FastText

SlowText:
	db "SLOW@"
MediumText:
	db "MID @"
FastText:
	db "FAST@"


GetTextSpeed:
	ld a, [wOptions]
	and TEXT_DELAY_MASK
	ld c, 0
	cp TEXT_DELAY_SLOW
	ret z
	inc c
	cp TEXT_DELAY_MEDIUM
	ret z
	inc c
	cp TEXT_DELAY_FAST
	ret z
	ld c, 2
	ret


GetTextSpeedValueFromIndex:
	ld hl, TextSpeedValueTable
	ld b, 0
	add hl, bc
	ld e, [hl]
	ret


TextSpeedValueTable:
	db TEXT_DELAY_SLOW
	db TEXT_DELAY_MEDIUM
	db TEXT_DELAY_FAST


OptionsMenu_BattleAnimations:
	ldh a, [hJoy5]
	and PAD_RIGHT | PAD_LEFT
	jr nz, .buttonPressed
	jr .nothingPressed

.buttonPressed
	ld a, [wOptions]
	xor 1 << BIT_BATTLE_ANIMATION
	ld [wOptions], a

.nothingPressed
	ld a, [wOptions]
	bit BIT_BATTLE_ANIMATION, a
	ld c, 0
	jr z, .print
	inc c

.print
	ld b, 0
	ld hl, AnimationOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 4
	call PlaceString
	and a
	ret


AnimationOptionStringsPointerTable:
	dw AnimationOnText
	dw AnimationOffText

AnimationOnText:
	db "ON @"
AnimationOffText:
	db "OFF@"


OptionsMenu_BattleStyle:
	ldh a, [hJoy5]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .buttonPressed
	jr .done

.buttonPressed
	ld a, [wOptions]
	xor 1 << BIT_BATTLE_SHIFT
	ld [wOptions], a

.done
	ld a, [wOptions]
	bit BIT_BATTLE_SHIFT, a
	ld c, 0
	jr z, .print
	inc c

.print
	ld b, 0
	ld hl, BattleStyleOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 6
	call PlaceString
	and a
	ret


BattleStyleOptionStringsPointerTable:
	dw BattleStyleShiftText
	dw BattleStyleSetText

BattleStyleShiftText:
	db "SHIFT@"
BattleStyleSetText:
	db "SET  @"


OptionsMenu_SpeakerSettings:
	ld a, [wOptions]
	and SOUND_MASK
	swap a
	ld c, a
	ldh a, [hJoy5]
	bit B_PAD_RIGHT, a
	jr nz, .pressedRight
	bit B_PAD_LEFT, a
	jr nz, .pressedLeft
	jr .nothingPressed

.pressedRight
	ld a, c
	inc a
	and $3
	jr .save

.pressedLeft
	ld a, c
	dec a
	and $3

.save
	ld c, a
	swap a
	ld b, a
	xor a
	ldh [rNR51], a
	ld a, [wOptions]
	and ~SOUND_MASK
	or b
	ld [wOptions], a

.nothingPressed
	ld b, 0
	ld hl, SpeakerOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 8
	call PlaceString
	and a
	ret


SpeakerOptionStringsPointerTable:
	dw MonoSoundText
	dw Earphone1SoundText
	dw Earphone2SoundText
	dw Earphone3SoundText

MonoSoundText:
	db "MONO     @"
Earphone1SoundText:
	db "EARPHONE1@"
Earphone2SoundText:
	db "EARPHONE2@"
Earphone3SoundText:
	db "EARPHONE3@"


OptionsMenu_Color:
	call GetColorSetting
	ldh a, [hJoy5]
	bit B_PAD_RIGHT, a
	jr nz, .pressedRight
	bit B_PAD_LEFT, a
	jr nz, .pressedLeft
	jr .nothingPressed

.pressedRight
	inc c
	ld a, c
	cp 5
	jr c, .save
	ld c, 0
	jr .save

.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, 5
.decrease
	dec c

.save
	push bc
	call GetColorValueFromIndex
	ld b, a
	ld a, [wOptions2]
	and %10111100
	or b
	ld [wOptions2], a
	call RunDefaultPaletteCommand
	pop bc

.nothingPressed
	ld b, 0
	ld hl, ColorOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 10
	call PlaceString
	and a
	ret


GetColorSetting:
	ld a, [wOptions2]
	and %01000011
	ld c, 0
	cp PALETTES_DEFAULT
	ret z
	inc c
	cp PALETTES_SGB
	ret z
	inc c
	cp PALETTES_SGB2
	ret z
	inc c
	cp PALETTES_YELLOW
	ret z
	inc c
	cp PALETTES_YELLOW2
	ret z
	ld c, 0
	ret


GetColorValueFromIndex:
	ld hl, ColorOptionValueTable
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret


ColorOptionValueTable:
	db PALETTES_DEFAULT
	db PALETTES_SGB
	db PALETTES_SGB2
	db PALETTES_YELLOW
	db PALETTES_YELLOW2


ColorOptionStringsPointerTable:
	dw ColorOGText
	dw ColorSGB1Text
	dw ColorSGB2Text
	dw ColorY1Text
	dw ColorY2Text

ColorOGText:
	db "OG  @"
ColorSGB1Text:
	db "SGB1@"
ColorSGB2Text:
	db "SGB2@"
ColorY1Text:
	db "Y1  @"
ColorY2Text:
	db "Y2  @"


OptionsMenu_Cancel:
	ldh a, [hJoy5]
	and PAD_A
	jr nz, .pressedCancel
	and a
	ret

.pressedCancel
	scf
	ret


OptionsControl:
	ld hl, wOptionsCursorLocation
	ldh a, [hJoy5]
	cp PAD_DOWN
	jr z, .pressedDown
	cp PAD_UP
	jr z, .pressedUp
	and a
	ret

.pressedDown
	ld a, [hl]
	cp 5
	jr nz, .regularIncrement
	ld [hl], 0
	scf
	ret

.regularIncrement
	inc [hl]
	scf
	ret

.pressedUp
	ld a, [hl]
	and a
	jr nz, .regularDecrement
	ld [hl], 5
	scf
	ret

.regularDecrement
	dec [hl]
	scf
	ret


OptionsMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
.loop
	ld [hl], ' '
	add hl, de
	dec c
	jr nz, .loop

	ld a, [wOptionsCursorLocation]
	cp 5
	jr z, .cancel

	hlcoord 1, 2
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld [hl], '▶'
	ret

.cancel
	hlcoord 1, 16
	ld [hl], '▶'
	ret


InitOptionsMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder

	hlcoord 2, 2
	ld de, AllOptionsText
	call PlaceString

	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString

	xor a
	ld [wOptionsCursorLocation], a

	ld c, 5
.loop
	push bc
	call GetOptionPointer
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl]
	dec c
	jr nz, .loop

	xor a
	ld [wOptionsCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret


AllOptionsText:
	db "TEXT SPEED :"
	next "ANIMATION  :"
	next "BATTLESTYLE:"
	next "SOUND:"
	next "COLOR:@"

OptionMenuCancelText:
	db "CANCEL@"