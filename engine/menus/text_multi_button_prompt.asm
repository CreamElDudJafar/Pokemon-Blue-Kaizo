; Pokédex-specific flashing prompt for custom multi-page screens.
; A advances; any button in wMenuWatchedKeys interrupts/returns.
PokedexPromptMultiButton::
	call LoadDownArrowCoord
	ld [hl], '▼'
	call Delay3
	call ManualTextScrollMultiButton
	call LoadDownArrowCoord
	ld [hl], ' '
	ret

ManualTextScrollMultiButton::
	call WaitForTextScrollSpecificButtonsPress
	ld a, d
	bit B_PAD_A, a
	jr nz, .continueText
	ld d, 1
	ret
.continueText
	ld a, SFX_PRESS_AB
	call PlaySound
	ld d, 0
	ret

WaitForTextScrollSpecificButtonsPress::
	ldh a, [hDownArrowBlinkCount1]
	push af
	ldh a, [hDownArrowBlinkCount2]
	push af
	xor a
	ldh [hDownArrowBlinkCount1], a
	ld a, $6
	ldh [hDownArrowBlinkCount2], a
.loop
	push hl
	ld a, [wTownMapSpriteBlinkingEnabled]
	and a
	jr z, .skipAnimation
	callfar TownMapSpriteBlinkingAnimation
.skipAnimation
	call LoadDownArrowCoord
	call HandleDownArrowBlinkTiming
	pop hl
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld d, a
	ld a, [wMenuWatchedKeys]
	or PAD_A
	and d
	jr z, .loop
	pop af
	ldh [hDownArrowBlinkCount2], a
	pop af
	ldh [hDownArrowBlinkCount1], a
	ret

LoadDownArrowCoord::
	ld a, [wMenuCursorLocation]
	ld h, a
	ld a, [wMenuCursorLocation + 1]
	ld l, a
	ret
