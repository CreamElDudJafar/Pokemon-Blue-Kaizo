; Evos+moves data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, species
;    * db EVOLVE_ITEM, used item, min level (1), species
;    * db EVOLVE_TRADE, min level (1), species
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves

EvosMovesPointerTable:
	table_width 2
	dw RhydonEvosMoves
	dw KangaskhanEvosMoves
	dw NidoranMEvosMoves
	dw ClefairyEvosMoves
	dw SpearowEvosMoves
	dw VoltorbEvosMoves
	dw NidokingEvosMoves
	dw SlowbroEvosMoves
	dw IvysaurEvosMoves
	dw ExeggutorEvosMoves
	dw LickitungEvosMoves
	dw ExeggcuteEvosMoves
	dw GrimerEvosMoves
	dw GengarEvosMoves
	dw NidoranFEvosMoves
	dw NidoqueenEvosMoves
	dw CuboneEvosMoves
	dw RhyhornEvosMoves
	dw LaprasEvosMoves
	dw ArcanineEvosMoves
	dw MewEvosMoves
	dw GyaradosEvosMoves
	dw ShellderEvosMoves
	dw TentacoolEvosMoves
	dw GastlyEvosMoves
	dw ScytherEvosMoves
	dw StaryuEvosMoves
	dw BlastoiseEvosMoves
	dw PinsirEvosMoves
	dw TangelaEvosMoves
	dw MissingNo1FEvosMoves
	dw MissingNo20EvosMoves
	dw GrowlitheEvosMoves
	dw OnixEvosMoves
	dw FearowEvosMoves
	dw PidgeyEvosMoves
	dw SlowpokeEvosMoves
	dw KadabraEvosMoves
	dw GravelerEvosMoves
	dw ChanseyEvosMoves
	dw MachokeEvosMoves
	dw MrMimeEvosMoves
	dw HitmonleeEvosMoves
	dw HitmonchanEvosMoves
	dw ArbokEvosMoves
	dw ParasectEvosMoves
	dw PsyduckEvosMoves
	dw DrowzeeEvosMoves
	dw GolemEvosMoves
	dw MissingNo32EvosMoves
	dw MagmarEvosMoves
	dw MissingNo34EvosMoves
	dw ElectabuzzEvosMoves
	dw MagnetonEvosMoves
	dw KoffingEvosMoves
	dw MissingNo38EvosMoves
	dw MankeyEvosMoves
	dw SeelEvosMoves
	dw DiglettEvosMoves
	dw TaurosEvosMoves
	dw MissingNo3DEvosMoves
	dw MissingNo3EEvosMoves
	dw MissingNo3FEvosMoves
	dw FarfetchdEvosMoves
	dw VenonatEvosMoves
	dw DragoniteEvosMoves
	dw MissingNo43EvosMoves
	dw MissingNo44EvosMoves
	dw MissingNo45EvosMoves
	dw DoduoEvosMoves
	dw PoliwagEvosMoves
	dw JynxEvosMoves
	dw MoltresEvosMoves
	dw ArticunoEvosMoves
	dw ZapdosEvosMoves
	dw DittoEvosMoves
	dw MeowthEvosMoves
	dw KrabbyEvosMoves
	dw MissingNo4FEvosMoves
	dw MissingNo50EvosMoves
	dw MissingNo51EvosMoves
	dw VulpixEvosMoves
	dw NinetalesEvosMoves
	dw PikachuEvosMoves
	dw RaichuEvosMoves
	dw MissingNo56EvosMoves
	dw MissingNo57EvosMoves
	dw DratiniEvosMoves
	dw DragonairEvosMoves
	dw KabutoEvosMoves
	dw KabutopsEvosMoves
	dw HorseaEvosMoves
	dw SeadraEvosMoves
	dw MissingNo5EEvosMoves
	dw MissingNo5FEvosMoves
	dw SandshrewEvosMoves
	dw SandslashEvosMoves
	dw OmanyteEvosMoves
	dw OmastarEvosMoves
	dw JigglypuffEvosMoves
	dw WigglytuffEvosMoves
	dw EeveeEvosMoves
	dw FlareonEvosMoves
	dw JolteonEvosMoves
	dw VaporeonEvosMoves
	dw MachopEvosMoves
	dw ZubatEvosMoves
	dw EkansEvosMoves
	dw ParasEvosMoves
	dw PoliwhirlEvosMoves
	dw PoliwrathEvosMoves
	dw WeedleEvosMoves
	dw KakunaEvosMoves
	dw BeedrillEvosMoves
	dw MissingNo73EvosMoves
	dw DodrioEvosMoves
	dw PrimeapeEvosMoves
	dw DugtrioEvosMoves
	dw VenomothEvosMoves
	dw DewgongEvosMoves
	dw MissingNo79EvosMoves
	dw MissingNo7AEvosMoves
	dw CaterpieEvosMoves
	dw MetapodEvosMoves
	dw ButterfreeEvosMoves
	dw MachampEvosMoves
	dw MissingNo7FEvosMoves
	dw GolduckEvosMoves
	dw HypnoEvosMoves
	dw GolbatEvosMoves
	dw MewtwoEvosMoves
	dw SnorlaxEvosMoves
	dw MagikarpEvosMoves
	dw MissingNo86EvosMoves
	dw MissingNo87EvosMoves
	dw MukEvosMoves
	dw MissingNo8AEvosMoves
	dw KinglerEvosMoves
	dw CloysterEvosMoves
	dw MissingNo8CEvosMoves
	dw ElectrodeEvosMoves
	dw ClefableEvosMoves
	dw WeezingEvosMoves
	dw PersianEvosMoves
	dw MarowakEvosMoves
	dw MissingNo92EvosMoves
	dw HaunterEvosMoves
	dw AbraEvosMoves
	dw AlakazamEvosMoves
	dw PidgeottoEvosMoves
	dw PidgeotEvosMoves
	dw StarmieEvosMoves
	dw BulbasaurEvosMoves
	dw VenusaurEvosMoves
	dw TentacruelEvosMoves
	dw MissingNo9CEvosMoves
	dw GoldeenEvosMoves
	dw SeakingEvosMoves
	dw MissingNo9FEvosMoves
	dw MissingNoA0EvosMoves
	dw MissingNoA1EvosMoves
	dw MissingNoA2EvosMoves
	dw PonytaEvosMoves
	dw RapidashEvosMoves
	dw RattataEvosMoves
	dw RaticateEvosMoves
	dw NidorinoEvosMoves
	dw NidorinaEvosMoves
	dw GeodudeEvosMoves
	dw PorygonEvosMoves
	dw AerodactylEvosMoves
	dw MissingNoACEvosMoves
	dw MagnemiteEvosMoves
	dw MissingNoAEEvosMoves
	dw MissingNoAFEvosMoves
	dw CharmanderEvosMoves
	dw SquirtleEvosMoves
	dw CharmeleonEvosMoves
	dw WartortleEvosMoves
	dw CharizardEvosMoves
	dw MissingNoB5EvosMoves
	dw FossilKabutopsEvosMoves
	dw FossilAerodactylEvosMoves
	dw MonGhostEvosMoves
	dw OddishEvosMoves
	dw GloomEvosMoves
	dw VileplumeEvosMoves
	dw BellsproutEvosMoves
	dw WeepinbellEvosMoves
	dw VictreebelEvosMoves
	assert_table_length NUM_POKEMON_INDEXES

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, ROCK_SLIDE
	db 42, EARTHQUAKE
	db 40, ROCK_SLIDE
	db 48, ROCK_SLIDE
	db 55, ROCK_SLIDE
	db 64, EARTHQUAKE
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 26, EARTHQUAKE
	db 31, BODY_SLAM
	db 36, BODY_SLAM
	db 41, HYPER_BEAM
	db 46, HYPER_BEAM	
	db 0

NidoranMEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINO
	db 0
; Learnset
	db 8,  DOUBLE_KICK
	db 12, DIG
	db 21, DOUBLE_KICK
	db 29, DOUBLE_KICK
	db 36, DOUBLE_KICK
	db 43, DOUBLE_KICK
	db 0

ClefairyEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db 13, SING
	db 18, SING
	db 24, DOUBLE_EDGE
	db 31, METRONOME
	db 39, METRONOME
	db 48, METRONOME
	db 0

SpearowEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, FEAROW
	db 0
; Learnset
	db 9, LEER
	db 15, FURY_ATTACK
	db 22, MIRROR_MOVE
	db 29, DRILL_PECK
	db 36, AGILITY
	db 0

VoltorbEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db 17, SONICBOOM
	db 22, SELFDESTRUCT
	db 29, THUNDERBOLT
	db 36, THUNDER_WAVE
	db 43, EXPLOSION
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8,  THUNDERBOLT
	db 14, THUNDERBOLT
	db 42, EARTHQUAKE
	db 0
	
SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset 
	db 18, PSYCHIC_M
	db 22, SURF
	db 27, PSYCHIC_M
	db 33, PSYCHIC_M
	db 37, AMNESIA
	db 44, AMNESIA
	db 55, PSYCHIC_M
	db 0

IvysaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, VENUSAUR
	db 0
; Learnset
	db 30, RAZOR_LEAF
	db 31, RAZOR_LEAF
	db 32, RAZOR_LEAF
	db 33, RAZOR_LEAF
	db 38, RAZOR_LEAF
	db 46, RAZOR_LEAF
	db 54, SLEEP_POWDER
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 28, PSYCHIC_M
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7,  BODY_SLAM
	db 15, BODY_SLAM
	db 23, BODY_SLAM
	db 31, EARTHQUAKE
	db 39, HYPER_BEAM
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db 20, SLEEP_POWDER
	db 22, PSYCHIC_M
	db 32, PSYCHIC_M
	db 37, PSYCHIC_M
	db 42, PSYCHIC_M
	db 48, SLEEP_POWDER
	db 0

GrimerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, MUK
	db 0
; Learnset
	db 30, EXPLOSION
	db 33, EXPLOSION
	db 37, EXPLOSION
	db 42, EXPLOSION
	db 48, EXPLOSION
	db 55, ACID_ARMOR
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 29, HYPNOSIS
	db 100, SEISMIC_TOSS
	db 0

NidoranFEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, NIDORINA
	db 0
; Learnset
 	db 8,  DOUBLE_KICK
	db 14, DOUBLE_KICK
	db 21, DOUBLE_KICK
	db 29, DOUBLE_KICK
	db 36, DOUBLE_KICK
	db 43, DOUBLE_KICK
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8,  THUNDERBOLT
	db 14, THUNDERBOLT
	db 42, EARTHQUAKE
	db 0

CuboneEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, MAROWAK
	db 0
; Learnset
	db 9,  HEADBUTT
	db 10, DOUBLE_EDGE
	db 12, ROCK_SLIDE
	db 13, BONEMERANG
	db 46, BONEMERANG
	db 0

RhyhornEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, RHYDON
	db 0
; Learnset
	db 30, ROCK_SLIDE
	db 35, ROCK_SLIDE
	db 40, ROCK_SLIDE
	db 42, EARTHQUAKE
	db 50, ROCK_SLIDE
	db 55, EARTHQUAKE
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db 31, CONFUSE_RAY
	db 34, BODY_SLAM
	db 36, THUNDERBOLT
	db 38, BLIZZARD
	db 40, BLIZZARD
	db 76, SURF
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 2, THUNDER_WAVE
	db 7, SOFTBOILED
	db 10, BODY_SLAM
	db 12, PSYCHIC_M
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, WATERFALL
	db 30, THUNDERBOLT
	db 32, BODY_SLAM
	db 41, BLIZZARD
	db 52, HYDRO_PUMP
	db 0

ShellderEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db 18, SUPERSONIC
	db 23, CLAMP
	db 30, AURORA_BEAM
	db 39, ICE_BEAM
	db 50, ICE_BEAM
	db 0

TentacoolEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db 7,  TOXIC
	db 13, TOXIC
	db 18, TOXIC
	db 22, TOXIC
	db 27, TOXIC
	db 33, TOXIC
	db 40, TOXIC
	db 48, HYDRO_PUMP
	db 0

GastlyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, HAUNTER
	db 0
; Learnset
	db 27, HYPNOSIS
	db 35, HYPNOSIS
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, SLASH
	db 20, SLASH
	db 24, SLASH
	db 29, SLASH
	db 35, SLASH
	db 48, SLASH
	db 0

StaryuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, STARMIE
	db 0
; Learnset
	db 17, WATER_GUN
	db 22, LIGHT_SCREEN
	db 27, BUBBLEBEAM
	db 32, BUBBLEBEAM
	db 37, RECOVER
	db 42, THUNDER_WAVE
	db 47, HYDRO_PUMP
	db 0

BlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8,  HYDRO_PUMP
	db 15, EARTHQUAKE
	db 24, BODY_SLAM
	db 31, BLIZZARD
	db 42, BODY_SLAM
	db 52, HYDRO_PUMP
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, GUILLOTINE
	db 30, SLASH
	db 36, SLASH
	db 43, BODY_SLAM
	db 49, SLASH
	db 54, GUILLOTINE
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
	db 29, STUN_SPORE
	db 32, STUN_SPORE
	db 36, STUN_SPORE
	db 39, SLEEP_POWDER
	db 45, SLEEP_POWDER
	db 49, SLEEP_POWDER
	db 0

MissingNo1FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo20EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
	db 9,  BITE
	db 10, SWIFT
	db 12, DOUBLE_EDGE
	db 14, FLAMETHROWER
	db 50, FIRE_BLAST
	db 0

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, BIND
	db 19, BIND
	db 25, BIND
	db 33, BIND
	db 43, BIND
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9,  DRILL_PECK
	db 15,  DRILL_PECK
	db 25,  DRILL_PECK
	db 34,  DRILL_PECK
	db 43,  DRILL_PECK
	db 0

PidgeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 9, PIDGEOTTO
	db 0
; Learnset
	db 5,   SAND_ATTACK
	db 6,   SWIFT
	db 7,   SAND_ATTACK
	db 28,  SAND_ATTACK
	db 36,  SAND_ATTACK
	db 44,  SAND_ATTACK
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 37, SLOWBRO
	db 0
; Learnset
	db 18, CONFUSION
	db 22, CONFUSION
	db 27, CONFUSION
	db 33, CONFUSION
	db 40, AMNESIA
	db 48, PSYCHIC_M
	db 0

KadabraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 100, ALAKAZAM
	db 0
; Learnset
	db 16, PSYBEAM
	db 20, PSYBEAM
	db 27, PSYBEAM
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, SEISMIC_TOSS
	db 0

GravelerEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, GOLEM
	db 0
; Learnset
	db 11, EXPLOSION
	db 16, EXPLOSION
	db 21, EXPLOSION
	db 29, EXPLOSION
	db 36, ROCK_SLIDE
	db 42, EARTHQUAKE
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 24, THUNDERBOLT
	db 25, ICE_BEAM
	db 38, ICE_BEAM
	db 44, THUNDERBOLT
	db 48, SOFTBOILED
	db 54, SOFTBOILED
	db 0

MachokeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 42, MACHAMP
	db 0
; Learnset
	db 20, SUBMISSION
	db 25, SUBMISSION
	db 36, SEISMIC_TOSS
	db 44, SEISMIC_TOSS
	db 52, SUBMISSION
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, THUNDER_WAVE
	db 20, HYPNOSIS
	db 25, THUNDERBOLT
	db 39, PSYCHIC_M
	db 47, PSYCHIC_M
	db 0

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, HI_JUMP_KICK
	db 38, HI_JUMP_KICK
	db 43, HI_JUMP_KICK
	db 48, HI_JUMP_KICK
	db 53, HI_JUMP_KICK
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, SEISMIC_TOSS
	db 38, SEISMIC_TOSS
	db 43, SEISMIC_TOSS
	db 48, SEISMIC_TOSS
	db 53, SEISMIC_TOSS
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, GLARE
	db 17, GLARE
	db 21, FISSURE
	db 36, GLARE
	db 47, GLARE
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, STUN_SPORE
	db 20, STUN_SPORE
	db 30, STUN_SPORE
	db 39, STUN_SPORE
	db 48, STUN_SPORE
	db 0

PsyduckEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, GOLDUCK
	db 0
; Learnset
	db 9,  PSYBEAM
	db 10, WATERFALL
	db 11, SEISMIC_TOSS
	db 12, HYPNOSIS
	db 52, AMNESIA
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, HYPNO
	db 0
; Learnset
	db 12, THUNDER_WAVE
	db 17, TOXIC
	db 24, PSYCHIC_M
	db 29, PSYCHIC_M
	db 32, PSYCHIC_M
	db 37, PSYCHIC_M
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, EXPLOSION
	db 16, EXPLOSION
	db 21, EXPLOSION
	db 29, EXPLOSION
	db 36, EXPLOSION
	db 43, EXPLOSION
	db 0

MissingNo32EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 36, CONFUSE_RAY
	db 39, CONFUSE_RAY
	db 43, CONFUSE_RAY
	db 48, CONFUSE_RAY
	db 52, CONFUSE_RAY
	db 75, SOLARBEAM
	db 0

MissingNo34EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, PSYCHIC_M
	db 37, PSYCHIC_M
	db 42, PSYCHIC_M
	db 49, PSYCHIC_M
	db 54, PSYCHIC_M
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, DOUBLE_EDGE
	db 25, DOUBLE_EDGE
	db 29, DOUBLE_EDGE
	db 38, DOUBLE_EDGE
	db 46, DOUBLE_EDGE
	db 54, DOUBLE_EDGE
	db 0

KoffingEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, WEEZING
	db 0
; Learnset
	db 32, EXPLOSION
	db 37, EXPLOSION
	db 40, EXPLOSION
	db 45, EXPLOSION
	db 48, EXPLOSION
	db 0

MissingNo38EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MankeyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, PRIMEAPE
	db 0
; Learnset
	db 11, SEISMIC_TOSS
	db 12, THRASH
	db 13, SUBMISSION
	db 14, DOUBLE_EDGE
	db 39, THRASH
	db 0

SeelEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DEWGONG
	db 0
; Learnset
	db 30, AURORA_BEAM
	db 35, AURORA_BEAM
	db 40, REST
	db 45, TAKE_DOWN
	db 50, ICE_BEAM
	db 0

DiglettEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, DUGTRIO
	db 0
; Learnset
	db 15, SAND_ATTACK
	db 19, DIG
	db 24, SAND_ATTACK
	db 31, SLASH
	db 40, EARTHQUAKE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, EARTHQUAKE
	db 28, EARTHQUAKE
	db 35, EARTHQUAKE
	db 44, EARTHQUAKE
	db 51, EARTHQUAKE
	db 0

MissingNo3DEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo3EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo3FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, SLASH
	db 15, SLASH
	db 23, SLASH
	db 31, SLASH
	db 39, AGILITY
	db 0

VenonatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, VENOMOTH
	db 0
; Learnset
	db 24, STUN_SPORE
	db 27, STUN_SPORE
	db 30, STUN_SPORE
	db 35, PSYBEAM
	db 38, SLEEP_POWDER
	db 43, PSYCHIC_M
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, THUNDER_WAVE
	db 35, THUNDER_WAVE
	db 45, THUNDER_WAVE
	db 60, THUNDER_WAVE
	db 0

MissingNo43EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo44EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo45EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DoduoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 31, DODRIO
	db 0
; Learnset
	db 20, TAKE_DOWN
	db 24, TAKE_DOWN
	db 30, DRILL_PECK
	db 36, TRI_ATTACK
	db 40, TRI_ATTACK
	db 44, AGILITY
	db 0

PoliwagEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 14, POLIWHIRL
	db 0
; Learnset
	db 10, BODY_SLAM
	db 11, BODY_SLAM
	db 25, BODY_SLAM
	db 31, BODY_SLAM
	db 38, BODY_SLAM
	db 45, HYDRO_PUMP
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, LOVELY_KISS
	db 23, LOVELY_KISS
	db 31, LOVELY_KISS
	db 39, LOVELY_KISS
	db 47, LOVELY_KISS
	db 58, LOVELY_KISS
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, FIRE_BLAST
	db 55, SKY_ATTACK
	db 60, SOLARBEAM
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, BLIZZARD
	db 55, BLIZZARD
	db 60, BLIZZARD
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, DRILL_PECK
	db 55, DRILL_PECK
	db 60, THUNDERBOLT
	db 0

DittoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MeowthEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 28, PERSIAN
	db 0
; Learnset
	db 12, BITE
	db 17, PAY_DAY
	db 24, BITE
	db 47, SLASH
	db 58, HYPNOSIS
	db 0

KrabbyEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, KINGLER
	db 0
; Learnset
	db 10, CRABHAMMER
	db 14, BODY_SLAM
	db 30, BODY_SLAM
	db 35, BODY_SLAM
	db 40, BODY_SLAM
	db 0

MissingNo4FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo50EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo51EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

VulpixEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, NINETALES
	db 0
; Learnset
	db 10, CONFUSE_RAY
	db 11, DOUBLE_EDGE
	db 16, FLAMETHROWER
	db 35, FLAMETHROWER
	db 42, FLAMETHROWER
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PikachuEvosMoves:
; Evolutions
	db EVOLVE_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db 9,  HEADBUTT
	db 16, THUNDERPUNCH
	db 20, THUNDERBOLT
	db 30, THUNDERBOLT
	db 43, THUNDER
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo56EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo57EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DratiniEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 30, DRAGONAIR
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, THUNDER_WAVE
	db 21, HEADBUTT
	db 22, DOUBLE_EDGE
	db 30, HYPER_BEAM
	db 0

DragonairEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 55, DRAGONITE
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, THUNDER_WAVE
	db 35, THUNDER_WAVE
	db 45, BLIZZARD
	db 55, HYPER_BEAM
	db 0

KabutoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, KABUTOPS
	db 0
; Learnset
	db 34, ABSORB
	db 39, SLASH
	db 44, LEER
	db 49, HYDRO_PUMP
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, SLASH
	db 39, SLASH
	db 46, SLASH
	db 53, HYDRO_PUMP
	db 0

HorseaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 32, SEADRA
	db 0
; Learnset
	db 19, SMOKESCREEN
	db 24, SMOKESCREEN
	db 30, SMOKESCREEN
	db 37, SMOKESCREEN
	db 45, HYDRO_PUMP
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, DRAGON_RAGE
	db 24, TOXIC
	db 30, HYDRO_PUMP
	db 41, SMOKESCREEN
	db 52, HYDRO_PUMP
	db 0

MissingNo5EEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo5FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

SandshrewEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, SANDSLASH
	db 0
; Learnset
	db 10, SAND_ATTACK
	db 16, DIG
	db 24, SLASH
	db 31, SLASH
	db 38, EARTHQUAKE
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; LearnsetS
	db 10, SAND_ATTACK
	db 17, SLASH
	db 27, ROCK_SLIDE
	db 40, EARTHQUAKE
	db 47, BODY_SLAM
	db 0

OmanyteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 40, OMASTAR
	db 0
; Learnset
	db 34, HORN_ATTACK
	db 39, LEER
	db 46, SPIKE_CANNON
	db 53, HYDRO_PUMP
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, SEISMIC_TOSS
	db 39, SEISMIC_TOSS
	db 44, SEISMIC_TOSS
	db 49, HYDRO_PUMP
	db 0

JigglypuffEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, WIGGLYTUFF
	db 0
; Learnset
	db 9, DOUBLE_EDGE
	db 14, DOUBLE_EDGE
	db 19, DOUBLE_EDGE
	db 24, DOUBLE_EDGE
	db 29, DOUBLE_EDGE
	db 34, BODY_SLAM
	db 39, DOUBLE_EDGE
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

EeveeEvosMoves:
; Evolutions
	db EVOLVE_ITEM, FIRE_STONE, 1, FLAREON
	db EVOLVE_ITEM, THUNDER_STONE, 1, JOLTEON
	db EVOLVE_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
	db 20, DOUBLE_EDGE
	db 22, SAND_ATTACK
	db 37, SAND_ATTACK
	db 45, SAND_ATTACK
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 27, FIRE_BLAST
	db 31, FIRE_BLAST
	db 37, FIRE_BLAST
	db 40, FIRE_BLAST
	db 42, FIRE_BLAST
	db 44, FIRE_BLAST
	db 48, FIRE_BLAST
	db 73, SOLARBEAM
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 27, BODY_SLAM
	db 31, BODY_SLAM
	db 37, BODY_SLAM
	db 40, BODY_SLAM
	db 42, BODY_SLAM
	db 44, BODY_SLAM
	db 48, BODY_SLAM
	db 54, THUNDERBOLT
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 27, BLIZZARD
	db 31, WATERFALL
	db 37, WATERFALL
	db 40, WATERFALL
	db 44, HYDRO_PUMP
	db 47, HYDRO_PUMP
	db 48, HYDRO_PUMP
	db 54, HYDRO_PUMP
	db 0

MachopEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 22, MACHOKE
	db 0
; Learnset
	db 20, LOW_KICK
	db 25, LOW_KICK
	db 32, SEISMIC_TOSS
	db 39, SEISMIC_TOSS
	db 46, SUBMISSION
	db 0

ZubatEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, GOLBAT
	db 0
; Learnset
	db 10, CONFUSE_RAY
	db 15, CONFUSE_RAY
	db 16, HYPNOSIS
	db 28, CONFUSE_RAY
	db 58, HYPNOSIS
	db 0

EkansEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, ARBOK
	db 0
; Learnset
	db 10,  WRAP
	db 15, EARTHQUAKE
	db 16, ROCK_SLIDE
	db 17, BODY_SLAM
	db 18, GLARE
	db 0

ParasEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 24, PARASECT
	db 0
; Learnset
	db 13, STUN_SPORE
	db 20, STUN_SPORE
	db 27, SPORE
	db 34, SPORE
	db 41, SPORE
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EVOLVE_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db 14, SUBMISSION
	db 15, SEISMIC_TOSS
	db 26, BODY_SLAM
	db 33, HYDRO_PUMP
	db 41, HYDRO_PUMP
	db 49, HYDRO_PUMP
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, BLIZZARD
	db 40, HYDRO_PUMP
	db 0

WeedleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, KAKUNA
	db 0
; Learnset
	db 0

KakunaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 10, BEEDRILL
	db 0
; Learnset
	db 0

BeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, TWINEEDLE
	db 16, TWINEEDLE
	db 20, TWINEEDLE
	db 25, TWINEEDLE
	db 30, PIN_MISSILE
	db 35, TWINEEDLE
	db 0

MissingNo73EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, DRILL_PECK
	db 24, DRILL_PECK
	db 30, DRILL_PECK
	db 39, DRILL_PECK
	db 45, DRILL_PECK
	db 51, DRILL_PECK
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, SEISMIC_TOSS
	db 21, SEISMIC_TOSS
	db 27, SEISMIC_TOSS
	db 37, SEISMIC_TOSS
	db 46, HI_JUMP_KICK
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, DIG
	db 19, DIG
	db 24, DIG
	db 35, SLASH
	db 39, EARTHQUAKE
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db 24, STUN_SPORE
	db 27, STUN_SPORE
	db 30, STUN_SPORE
	db 38, STUN_SPORE
	db 43, SLEEP_POWDER
	db 50, PSYCHIC_M
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, WATERFALL
	db 35, WATERFALL
	db 44, WATERFALL
	db 49, HYDRO_PUMP
	db 50, REST
        db 0

MissingNo79EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo7AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

CaterpieEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 7, METAPOD
	db 0
; Learnset
	db 0

MetapodEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 10, BUTTERFREE
	db 0
; Learnset
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, PSYBEAM
	db 15, STUN_SPORE
	db 16, STUN_SPORE
	db 17, STUN_SPORE
	db 21, STUN_SPORE
	db 26, STUN_SPORE
	db 32, SLEEP_POWDER
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, SUBMISSION
	db 25, SUBMISSION
	db 36, SUBMISSION
	db 44, SUBMISSION
	db 52, HI_JUMP_KICK
	db 0

MissingNo7FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
	db 28, PSYCHIC_M
	db 31, PSYCHIC_M
	db 39, PSYCHIC_M
	db 48, HYDRO_PUMP
	db 59, HYPNOSIS
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, HYPNOSIS
	db 17, HYPNOSIS
	db 24, HYPNOSIS
	db 33, HYPNOSIS
	db 37, HYPNOSIS
	db 43, PSYCHIC_M
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, CONFUSE_RAY
	db 15, CONFUSE_RAY
	db 21, CONFUSE_RAY
	db 32, CONFUSE_RAY
	db 60, HYPNOSIS
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 63, PSYCHIC_M
	db 66, PSYCHIC_M
	db 70, PSYCHIC_M
	db 75, PSYCHIC_M
	db 81, PSYCHIC_M
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, BODY_SLAM
	db 41, EARTHQUAKE
	db 45, HYPER_BEAM
	db 88, LOVELY_KISS
	db 0

MagikarpEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, GYARADOS
	db 0
; Learnset
	db 15, TACKLE
	db 0

MissingNo86EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNo87EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, SLUDGE
	db 33, SLUDGE
	db 37, SLUDGE
	db 45, SLUDGE
	db 53, SLUDGE
	db 60, SLUDGE
	db 0

MissingNo8AEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, CRABHAMMER
	db 25, CRABHAMMER
	db 34, CRABHAMMER
	db 42, CRABHAMMER
	db 49, CRABHAMMER
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
	db 50, EXPLOSION
	db 0

MissingNo8CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, EXPLOSION
	db 22, EXPLOSION
	db 29, EXPLOSION
	db 40, EXPLOSION
	db 50, EXPLOSION
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 32, SLUDGE
	db 39, SLUDGE
	db 43, SLUDGE
	db 49, EXPLOSION
	db 53, THUNDERBOLT
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, SLASH
	db 17, SLASH
	db 24, SLASH
	db 51, SLASH
	db 63, HYPNOSIS
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, BONEMERANG
	db 33, BONEMERANG
	db 41, BONEMERANG
	db 48, BONEMERANG
	db 55, BONEMERANG
	db 0

MissingNo92EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

HaunterEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 55, GENGAR
	db 0
; Learnset
	db 29, HYPNOSIS
	db 56, PSYCHIC_M
	db 0

AbraEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, KADABRA
	db 0
; Learnset
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, RECOVER
	db 20, RECOVER
	db 27, RECOVER
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, RECOVER
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, PIDGEOT
	db 0
; Learnset
	db 5,  SAND_ATTACK
	db 12,  SAND_ATTACK
	db 21,  SAND_ATTACK
	db 31,  SAND_ATTACK
	db 40,  SAND_ATTACK
	db 49, MIRROR_MOVE
	db 0

PidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db  5, SAND_ATTACK
	db 12, RAZOR_WIND
	db 21, RAZOR_WIND
	db 31, RAZOR_WIND
	db 44, QUICK_ATTACK
	db 54, RAZOR_WIND
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

BulbasaurEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, IVYSAUR
	db 0
; Learnset
	db 7,  ABSORB
	db 10, HEADBUTT
	db 20, POISONPOWDER
	db 22, RAZOR_LEAF
	db 22, DOUBLE_EDGE
	db 41, SLEEP_POWDER
	db 48, SLEEP_POWDER
	db 0

VenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7,  RAZOR_LEAF
	db 13, RAZOR_LEAF
	db 22, RAZOR_LEAF
	db 30, RAZOR_LEAF
	db 43, RAZOR_LEAF
	db 55, SLEEP_POWDER
	db 65, RAZOR_LEAF
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7,  WRAP
	db 13, WRAP
	db 18, WRAP
	db 22, WRAP
	db 27, WRAP
	db 35, WRAP
	db 43, WRAP
	db 50, BLIZZARD
	db 0

MissingNo9CEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

GoldeenEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 33, SEAKING
	db 0
; Learnset
	db 19, WATERFALL
	db 24, WATERFALL
	db 30, WATERFALL
	db 37, WATERFALL
	db 45, HORN_DRILL
	db 48, AGILITY
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, BUBBLEBEAM
	db 24, BUBBLEBEAM
	db 30, BUBBLEBEAM
	db 39, WATERFALL
	db 48, HORN_DRILL
	db 54, AGILITY
	db 0

MissingNo9FEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA0EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA1EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoA2EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PonytaEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 26, RAPIDASH
	db 0
; Learnset
	db 16, FLAMETHROWER
	db 18, DOUBLE_EDGE
	db 24, HYPNOSIS
	db 39, HYPNOSIS
	db 43, HYPNOSIS
	db 48, HYPNOSIS
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 74, HYPNOSIS
	db 75, HYPNOSIS
	db 76, HYPNOSIS
	db 77, HYPNOSIS
	db 78, HYPNOSIS
	db 79, HYPNOSIS
	db 0

RattataEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, RATICATE
	db 0
; Learnset
	db 7,  QUICK_ATTACK
	db 14, HYPER_FANG
	db 23, FOCUS_ENERGY
	db 34, SUPER_FANG
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, SUPER_FANG
	db 14, SUPER_FANG
	db 27, SUPER_FANG
	db 41, SUPER_FANG
	db 0

NidorinoEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOKING
	db 0
; Learnset
	db 8,  DOUBLE_KICK
	db 14, DIG
	db 23, DOUBLE_KICK
	db 32, DOUBLE_KICK
	db 41, DOUBLE_KICK
	db 50, DOUBLE_KICK	
	db 0

NidorinaEvosMoves:
; Evolutions
	db EVOLVE_ITEM, MOON_STONE, 1, NIDOQUEEN
	db 0
; Learnset
	db 8,  DOUBLE_KICK
	db 14, DIG
	db 23, DOUBLE_KICK
	db 32, DOUBLE_KICK
	db 41, DOUBLE_KICK
	db 50, DOUBLE_KICK
	db 0

GeodudeEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 25, GRAVELER
	db 0
	; Learnset
	db 11, SELFDESTRUCT
	db 16, SELFDESTRUCT
	db 21, ROCK_SLIDE
	db 26, DIG
	db 31, EARTHQUAKE
	db 36, EXPLOSION
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 22, BLIZZARD
	db 24, RECOVER
	db 28, THUNDERBOLT
	db 32, THUNDER_WAVE
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, RAZOR_WIND
	db 38, EARTHQUAKE
	db 45, ROCK_SLIDE
	db 101, SKY_ATTACK
	db 0

MissingNoACEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 20, MAGNETON
	db 0
; Learnset
	db 21, THUNDERBOLT
	db 25, THUNDERBOLT
	db 29, THUNDERBOLT
	db 35, THUNDERBOLT
	db 41, THUNDERBOLT
	db 47, THUNDERBOLT
	db 0

MissingNoAEEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MissingNoAFEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

CharmanderEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, CHARMELEON
	db 0
; Learnset
	db 9,  BITE
	db 10, HEADBUTT
	db 16, FIRE_PUNCH
	db 30, SLASH
	db 38, FLAMETHROWER
	db 46, FLAMETHROWER
	db 0

SquirtleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, WARTORTLE
	db 0
; Learnset
	db 8,  BITE
	db 13, HEADBUTT
	db 16, BUBBLEBEAM
	db 28, WATERFALL
	db 35, SKULL_BASH
	db 42, HYDRO_PUMP
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db 9,  SLASH
	db 15, SLASH
	db 24, SLASH
	db 33, SLASH
	db 42, FLAMETHROWER
	db 56, FLAMETHROWER
	db 0

WartortleEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db 8,  WATERFALL
	db 15, WATERFALL
	db 24, DIG
	db 31, DIG
	db 39, DIG
	db 47, HYDRO_PUMP
	db 0

CharizardEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9,  SLASH
	db 15, SLASH
	db 24, SLASH
	db 55, FLAMETHROWER
	db 69, FIRE_BLAST
	db 70, SLASH
	db 0

MissingNoB5EvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FossilKabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FossilAerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MonGhostEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

OddishEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, GLOOM
	db 0
; Learnset
	db 14, SLEEP_POWDER
	db 15, RAZOR_LEAF
	db 19, SLEEP_POWDER
	db 24, ACID
	db 33, PETAL_DANCE
	db 46, SOLARBEAM
	db 0

GloomEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db 16, PETAL_DANCE
	db 17, PETAL_DANCE
	db 19, SLEEP_POWDER
	db 28, STUN_SPORE
	db 38, STUN_SPORE
	db 52, PETAL_DANCE
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, STUN_SPORE
	db 17, SLEEP_POWDER
	db 19, PETAL_DANCE
	db 0

BellsproutEvosMoves:
; Evolutions
	db EVOLVE_LEVEL, 16, WEEPINBELL
	db 0
; Learnset
	db 10, MEGA_DRAIN
	db 11, SLEEP_POWDER
	db 16, BODY_SLAM
	db 21, SLEEP_POWDER
	db 26, STUN_SPORE
	db 33, RAZOR_LEAF
	db 42, SLAM
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EVOLVE_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db 16, RAZOR_LEAF
	db 17, STUN_SPORE
	db 18, STUN_SPORE
	db 23, STUN_SPORE
	db 29, STUN_SPORE
	db 38, RAZOR_LEAF
	db 49, SLEEP_POWDER
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, RAZOR_LEAF
	db 15, RAZOR_LEAF
	db 100, LOVELY_KISS
	db 0
