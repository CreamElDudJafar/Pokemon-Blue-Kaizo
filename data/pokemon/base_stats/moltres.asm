	db DEX_MOLTRES ; pokedex id

	db  95, 100,  90,  90, 125
	;   hp  atk  def  spd  spc

	db FIRE, FLYING ; type
	db 1   ; catch rate
	db 240 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/moltres.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/moltres.pic", 0, 1 ; sprite dimensions
ENDC
	dw MoltresPicFront, MoltresPicBack

	db FIRE_BLAST, SKY_ATTACK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm RAZOR_WIND,   WHIRLWIND,    TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   SWIFT,        SKY_ATTACK,   REST,         \
	     SUBSTITUTE,   FLY
	; end

	db BANK(MoltresPicFront)
