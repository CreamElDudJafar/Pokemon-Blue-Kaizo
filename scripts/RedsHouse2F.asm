RedsHouse2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, RedsHouse2F_ScriptPointers
	ld a, [wRedsHouse2FCurScript]
	jp CallFunctionInTable

RedsHouse2F_ScriptPointers:
	def_script_pointers
	dw_const RedsHouse2FDefaultScript,         SCRIPT_REDSHOUSE2F_DEFAULT
	dw_const RedsHouse2FNoopScript,            SCRIPT_REDSHOUSE2F_NOOP
	dw_const RedsHouse2FChangeStyleScript,     SCRIPT_REDSHOUSE2F_CHANGE_STYLE

RedsHouse2FDefaultScript:
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, SCRIPT_REDSHOUSE2F_NOOP
	ld [wRedsHouse2FCurScript], a
	ret

RedsHouse2FNoopScript:
	ret

RedsHouse2FChangeStyleScript:
	call GBFadeOutToBlack
	ld a, [wPlayerGender]
	xor 1
	ld [wPlayerGender], a
	call LoadPlayerSpriteGraphics
	call UpdateSprites
	ld c, 12
	call DelayFrames
	call GBFadeInFromBlack
	ld a, SCRIPT_REDSHOUSE2F_NOOP
	ld [wRedsHouse2FCurScript], a
	ld a, TEXT_REDSHOUSE2F_DONE
	ldh [hTextID], a
	jp DisplayTextID

RedsHouse2F_TextPointers:
	def_text_pointers
	dw_const RedsHouse2FWardrobeText,     TEXT_REDSHOUSE2F_WARDROBE
	dw_const RedsHouse2FWardrobeDoneText, TEXT_REDSHOUSE2F_DONE

RedsHouse2FWardrobeText:
	text_asm
	ld hl, .QuestionText
	call PrintText
	call YesNoChoice
	ldh a, [hJoy5]
	bit B_PAD_B, a
	jr nz, .cancel
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .cancel
	ld hl, .LetsGoText
	call PrintText
	ld a, SCRIPT_REDSHOUSE2F_CHANGE_STYLE
	ld [wRedsHouse2FCurScript], a
	jp TextScriptEnd
.cancel
	call DisableWaitingAfterTextDisplay
	jp TextScriptEnd

.QuestionText:
	text_far _RedsHouse2FWardrobeQuestionText
	text_end

.LetsGoText:
	text_far _RedsHouse2FWardrobeLetsGoText
	text_end

RedsHouse2FWardrobeDoneText:
	text_far _RedsHouse2FWardrobeDoneText
	text_end
