TrainerAIPointers:
	table_width 3
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI  ; youngster
	dbw 3, GenericAI ; bugcatcher
	dbw 5, AgathaAI ; lass
	dbw 5, LoreleiAI ; sailor
	dbw 5, LoreleiAI ; jr trainer m
	dbw 5, LoreleiAI ; jr trainer f
	dbw 5, Rival3AI ; pokemanic
	dbw 5, CooltrainerFAI ; supernerd
	dbw 5, AgathaAI ; hiker
	dbw 3, JugglerAI ; biker
	dbw 5, Rival3AI ; burglar
	dbw 5, AgathaAI ; engineer
	dbw 3, JugglerAI ; unused juggler
	dbw 5, CooltrainerFAI ; fisher
	dbw 3, GenericAI ; swimmer
	dbw 5, Rival3AI ; cueball
	dbw 5, AgathaAI ; gambler
	dbw 5, CooltrainerFAI  ; beauty
	dbw 5, CooltrainerFAI ; psychic
	dbw 5, LoreleiAI ; rocker
	dbw 5, CooltrainerFAI ; juggler
	dbw 5, Rival3AI ; tamer
	dbw 3, GenericAI ; birdkeeper
	dbw 5, Rival3AI ; blackbelt
	dbw 3, AgathaAI  ; rival1
	dbw 255, BrockAI ; oak
	dbw 1, GenericAI ; chief
	dbw 5, CooltrainerFAI ; scientist
	dbw 5,  Rival3AI ; giovanni
	dbw 5, CooltrainerFAI ; rocket
	dbw 5, Rival3AI ; cooltrainerm
	dbw 5, CooltrainerFAI ; cooltrainerf
	dbw 5, Rival3AI ; bruno
	dbw 5, BrockAI ; brock
	dbw 5, LoreleiAI ; misty
	dbw 5, Rival3AI ; surge
	dbw 255, BrockAI ; erika
	dbw 255, BrockAI; koga
	dbw 255, BrockAI ; blaine
	dbw 255, BrockAI ; sabrina
	dbw 3, Rival3AI ; Gentleman
	dbw 5, CooltrainerFAI ; rival2
	dbw 255, BrockAI ; rival3
	dbw 255, BrockAI ; lorelei
	dbw 5, Rival3AI ; Channeler
	dbw 255, BrockAI ; agatha
	dbw 255, BrockAI ; lance
	assert_table_length NUM_TRAINERS
