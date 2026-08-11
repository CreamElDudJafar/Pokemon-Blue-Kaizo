PrepareOakSpeech:
	ld a, [wLetterPrintingDelayFlags]
	push af
	ld a, [wStatusFlags6]
	push af

;;;;;;;;;; PureRGBnote: ADDED: Preserve all options settings when starting a new game
	call BackupOptionsSettings
	ld hl, wPlayerName
	ld bc, wBoxDataEnd - wPlayerName
	xor a
	call FillMemory
	ld hl, wSpriteDataStart
	ld bc, wSpriteDataEnd - wSpriteDataStart
	xor a
	call FillMemory
	call RestoreOptionsSettings
;;;;;;;;;;

	pop af
	ld [wStatusFlags6], a
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld a, [wOptionsInitialized]
	and a
	call z, InitOptions
	; These debug names are used for StartNewGameDebug.
	; TestBattle uses the debug names from DebugMenu.
	; A variant of this process is performed in PrepareTitleScreen.
	ld hl, DebugNewGamePlayerName
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, DebugNewGameRivalName
	ld de, wRivalName
	ld bc, NAME_LENGTH
	jp CopyData

OakSpeech:
	callfar CGBSetCPU1xSpeed
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_Routes2)
	ld c, a
	ld a, MUSIC_ROUTES2
	call PlayMusic
	call ClearScreen
	call LoadTextBoxTilePatterns
	call PrepareOakSpeech
	predef InitPlayerData2
	call RunDefaultPaletteCommand
	ld hl, wNumBoxItems
	ld a, MASTER_BALL
	ld [wCurItem], a
	ld a, 99
	ld [wItemQuantity], a
	call AddItemToInventory
	ld a, HEALING_KIT
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory  ; give HEALING_KIT
	ld a, CANDY_BAG
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory  ; give CANDY_BAG
	ld a, REPELLENT
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory  ; give REPELLENT
	ld a, STATUS_KIT         
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory  ; give STATUS_KIT
	ld a, [wDefaultMap]
	ld [wDestinationMap], a
	call PrepareForSpecialWarp
	xor a
	ldh [hTileAnimations], a
; Gender Menu
	ld hl, BoyGirlText  ; added to the same file as the other oak text
	call PrintText     ; show this text
	call BoyGirlChoice ; added routine at the end of this file
	ld a, [wCurrentMenuItem]
	ld [wPlayerGender], a ; store player's gender. 00 for boy, 01 for girl
	call ClearScreen ; clear the screen before resuming normal intro	
	ld a, [wStatusFlags6]
	bit BIT_DEBUG_MODE, a
	jp nz, .skipSpeech
	ld de, ProfOakPic
	lb bc, BANK(ProfOakPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeechText1
	call PrintText
	call GBFadeOutToWhite
	call ClearScreen
	ld a, NIDORINO
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetMonHeader
	hlcoord 6, 4
	call LoadFlippedFrontSpriteByMonIndex	
	ld a, %11100100
	ld [rBGP], a
	call UpdateCGBPal_BGP	
	push af
	push bc
	push hl
	push de
	ld d, CONVERT_BGP
	ld e, 0
	callfar TransferMonPal 
	pop de
	pop hl
	pop bc
	pop af	
	call MovePicLeft_NoPalUpdate
	ld hl, OakSpeechText2
	call PrintText
	call GBFadeOutToWhite
	call ClearScreen
	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $00
	ld a, [wPlayerGender]
	and a
	jr z, .NotGreen1
	ld de, GreenPicFront
	lb bc, BANK(GreenPicFront), $00
.NotGreen1:
	call IntroDisplayPicCenteredOrUpperRight
	call MovePicLeft
	ld hl, IntroducePlayerText
	call PrintText
	call ChoosePlayerName
	call GBFadeOutToWhite
	call ClearScreen
	ld de, Rival1Pic
	lb bc, BANK(Rival1Pic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, IntroduceRivalText
	call PrintText
	call ChooseRivalName
.skipSpeech
	call GBFadeOutToWhite
	call ClearScreen
	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $00
	ld a, [wPlayerGender]
	and a
	jr z, .NotGreen2
	ld de, GreenPicFront
	lb bc, BANK(GreenPicFront), $00
.NotGreen2:
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
	ld a, [wStatusFlags3]
	and a ; ???
	jr nz, .next
	ld hl, OakSpeechText3
	call PrintText
.next
	ldh a, [hLoadedROMBank]
	push af
	ld a, SFX_SHRINK
	call PlaySound
	pop af
; bug: switching ROM Bank should not happen outside of Home Bank
; This code does nothing, as PlaySound does all necessary Bank switch
; It looks like a leftover from an early development stage
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	ld c, 4
	call DelayFrames
	ld de, RedSprite
	ld hl, vSprites
	lb bc, BANK(RedSprite), $0C
	ld a, [wPlayerGender]
	and a
	jr z, .NotGreen3
	ld de, GreenSprite
	lb bc, BANK(GreenSprite), $0C
.NotGreen3:
	ld hl, vSprites
	call CopyVideoData
	ld de, ShrinkPic1
	lb bc, BANK(ShrinkPic1), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld c, 4
	call DelayFrames
	ld de, ShrinkPic2
	lb bc, BANK(ShrinkPic2), $00
	call IntroDisplayPicCenteredOrUpperRight
	call ResetPlayerSpriteData
	ldh a, [hLoadedROMBank]
	push af
	ld a, BANK(Music_PalletTown)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	ld a, 10
	ld [wAudioFadeOutControl], a
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	pop af
; bug: switching ROM Bank should not happen outside of Home Bank
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	ld c, 20
	call DelayFrames
	hlcoord 6, 5
	ld b, 7
	ld c, 7
	call ClearScreenArea
	call LoadTextBoxTilePatterns
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	ld c, 50
	call DelayFrames
	call GBFadeOutToWhite
	jp ClearScreen

OakSpeechText1:
	text_far _OakSpeechText1
	text_end

OakSpeechText2:
	text_far _OakSpeechText2A
	; BUG: The cry played does not match the sprite displayed.
	sound_cry_nidorina
	text_far _OakSpeechText2B
	text_end

IntroducePlayerText:
	text_far _IntroducePlayerText
	text_end

IntroduceRivalText:
	text_far _IntroduceRivalText
	text_end

OakSpeechText3:
	text_far _OakSpeechText3
	text_end

BoyGirlText:
    	text_far _BoyGirlText
    	text_end

FadeInIntroPic:
	ld hl, IntroFadePalettes
	ld b, 6
.next
	ld a, [hli]
	ldh [rBGP], a
	call UpdateCGBPal_BGP
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .next
	ret

IntroFadePalettes:
	dc 1, 1, 1, 0
	dc 2, 2, 2, 0
	dc 3, 3, 3, 0
	dc 3, 3, 2, 0
	dc 3, 3, 1, 0
	dc 3, 2, 1, 0

MovePicLeft:
	ld a, %11100100
	ldh [rBGP], a
	call UpdateCGBPal_BGP
MovePicLeft_NoPalUpdate:
	ld a, 119
	ldh [rWX], a
	call DelayFrame
.next
	call DelayFrame
	ldh a, [rWX]
	sub 8
	cp $FF
	ret z
	ldh [rWX], a
	jr .next

DisplayPicCenteredOrUpperRight:
	call GetPredefRegisters
IntroDisplayPicCenteredOrUpperRight:
; b = bank
; de = address of compressed pic
; c: 0 = centred, non-zero = upper-right
	push bc
	ld a, b
	call UncompressSpriteFromDE
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, 2 * SPRITEBUFFERSIZE
	call CopyData
	ld de, vFrontPic
	call InterlaceMergeSpriteBuffers
	pop bc
	ld a, c
	and a
	hlcoord 15, 1
	jr nz, .next
	hlcoord 6, 4
.next
	xor a
	ldh [hStartTileID], a
	predef_jump CopyUncompressedPicToTilemap


BackupOptionsSettings:
	ld de, wBuffer
	ld hl, BackupList
	jr DoOptionsBackup

RestoreOptionsSettings:
	ld de, wBuffer
	ld hl, BackupList
	call DoOptionsRestore
	ld hl, wStatusFlags6
	res BIT_ALWAYS_ON_BIKE, [hl]
	ret

DoOptionsBackup:
	ld b, [hl]
	inc hl
.loopBackup
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	ld [de], a
	pop hl
	inc hl
	inc hl
	inc de
	dec b
	jr nz, .loopBackup
	ret

DoOptionsRestore:
	ld b, [hl]
	inc hl
.loopRestore
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [de]
	ld [hl], a
	pop hl
	inc hl
	inc hl
	inc de
	dec b
	jr nz, .loopRestore
	ret

BackupList:
	db 3
	dw wOptions2
	dw wOptions
	dw wOptionsInitialized

CopyOptionsToSRAM::
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	ld a, BMODE_ADVANCED
	ld [rBMODE], a
	ASSERT BANK(sPlayerName) == BMODE_ADVANCED
	ld [rRAMB], a

	ld a, [wOptions2]
	ld [sOptions2], a
	ld a, [wOptions]
	ld [sOptions], a
	ld a, [wOptionsInitialized]
	ld [sOptionsInitialized], a

	xor a
	ld [rBMODE], a
	ld [rRAMG], a
	ret

CopyOptionsFromSRAM::
	ld a, [wOptionsInitialized]
	and a
	ret nz ; don't overwrite title-menu changes with old SRAM again

	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	ld a, BMODE_ADVANCED
	ld [rBMODE], a
	ASSERT BANK(sPlayerName) == BMODE_ADVANCED
	ld [rRAMB], a

	call CheckSaveFileExists
	jr c, .loadOptions

	; No normal save yet: load options only when our SRAM marker is valid.
	ld a, [sOptionsInitialized]
	cp OPTIONS_INITIALIZED_VALUE
	jr nz, .doneLoad

.loadOptions
	ld a, [sOptions2]
	ld [wOptions2], a

	ld a, [sOptions]
	ld [wOptions], a

	ld a, OPTIONS_INITIALIZED_VALUE
	ld [wOptionsInitialized], a

.doneLoad
	xor a
	ld [rBMODE], a
	ld [rRAMG], a
	ret

; displays boy/girl choice
BoyGirlChoice::
	call SaveScreenTilesToBuffer1
	call InitBoyGirlTextBoxParameters
	jr DisplayBoyGirlChoice

InitBoyGirlTextBoxParameters::
   	ld a, $1 ; loads the value for the unused North/West choice, that was changed to say Boy/Girl
	ld [wTwoOptionMenuID], a
	hlcoord 6, 5 
	ld bc, $607
	ret
	
DisplayBoyGirlChoice::
	ld a, $14
	ld [wTextBoxID], a
	call DisplayTextBoxID
	jp LoadScreenTilesFromBuffer1