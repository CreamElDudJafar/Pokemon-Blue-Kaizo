	db DEX_ZAPDOS ; pokedex id

	db  90,  90,  85, 100, 125
	;   hp  atk  def  spd  spc

	db ELECTRIC, FLYING ; type
	db 1   ; catch rate
	db 240 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/zapdos.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/zapdos.pic", 0, 1 ; sprite dimensions
ENDC
	dw ZapdosPicFront, ZapdosPicBack

	db THUNDER_WAVE, DRILL_PECK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm RAZOR_WIND,   WHIRLWIND,    TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         THUNDERBOLT,  THUNDER,      MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         SWIFT,        SKY_ATTACK,   \
	     REST,         THUNDER_WAVE, SUBSTITUTE,   FLY,          FLASH
	; end

	db BANK(ZapdosPicFront)
