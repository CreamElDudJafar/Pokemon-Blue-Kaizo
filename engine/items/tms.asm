; tests if mon [wCurPartySpecies] can learn move [wMoveNum]
CanLearnTM:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetMonHeader
	ld hl, wMonHLearnset
	push hl
	ld a, [wMoveNum]
	ld b, a
	ld c, $0
	ld hl, TechnicalMachines
.findTMloop
	ld a, [hli]
	cp b
	jr z, .TMfoundLoop
	inc c
	jr .findTMloop
.TMfoundLoop
	pop hl
	ld b, FLAG_TEST
	predef_jump FlagActionPredef

; converts TM/HM number in [wTempTMHM] into move number
; HMs start at 51
TMToMove:
	ld a, [wTempTMHM]
	dec a
	ld hl, TechnicalMachines
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempTMHM], a
	ret


; Build [TM/HM number, move] pairs for the Pokédex MOVE display.
GetTMMoves::
	ld de, wMoveBuffer
	ld hl, TechnicalMachines
	ld b, 1
	xor a
	ld [wMoveListCounter], a
.loop
	ld a, [hli]
	ld [wMoveNum], a
	push hl
	push bc
	push de
	predef CanLearnTM
	ld a, c
	and a
	pop de
	pop bc
	pop hl
	jr z, .next
	ld a, b
	ld [de], a
	inc de
	ld a, [wMoveNum]
	ld [de], a
	inc de
	push hl
	ld hl, wMoveListCounter
	inc [hl]
	pop hl
.next
	inc b
	ld a, b
	cp NUM_TM_HM + 1
	jr c, .loop
.done
	xor a
	ld [de], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"
