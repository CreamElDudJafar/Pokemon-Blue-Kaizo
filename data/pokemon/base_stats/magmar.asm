	db DEX_MAGMAR ; pokedex id

	db  65,  100,  60,  105,  125
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 200 ; catch rate
	db 167 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/magmar.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/magmar.pic", 0, 1 ; sprite dimensions
ENDC
	dw MagmarPicFront, MagmarPicBack

	db CONFUSE_RAY, THUNDERBOLT, BODY_SLAM, FIRE_BLAST ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   COUNTER,      SEISMIC_TOSS, \
	     RAGE,         PSYCHIC_M,    TELEPORT,     MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         METRONOME,    FIRE_BLAST,   SKULL_BASH,   REST,         \
	     PSYWAVE,      SUBSTITUTE,   STRENGTH
	; end

	db BANK(MagmarPicFront)
