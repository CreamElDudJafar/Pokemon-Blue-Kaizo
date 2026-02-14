	db DEX_KOFFING ; pokedex id

	db  40,  65,  95,  35,  60
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 255 ; catch rate
	db 114 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/koffing.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/koffing.pic", 0, 1 ; sprite dimensions
ENDC
	dw KoffingPicFront, KoffingPicBack

	db SMOKESCREEN, SLUDGE, EXPLOSION, TOXIC ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        RAGE,         THUNDERBOLT,  THUNDER,      MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, FIRE_BLAST,   REST,         \
	     EXPLOSION,    SUBSTITUTE
	; end

	db BANK(KoffingPicFront)
