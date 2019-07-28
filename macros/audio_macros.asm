
StopAllMusic: MACRO
	ld a, $ff
	call PlaySound
ENDM

Ch1    EQU 0
Ch2    EQU 1
Ch3    EQU 2
Ch4    EQU 3
Ch5    EQU 4
Ch6    EQU 5
Ch7    EQU 6
Ch8    EQU 7

audio_header: MACRO
	db (_NARG - 2) << 6 | \2
	dw \1_\2
	IF _NARG > 2
		db \3
		dw \1_\3
	ENDC
	IF _NARG > 3
		db \4
		dw \1_\4
	ENDC
	IF _NARG > 4
		db \5
		dw \1_\5
	ENDC
ENDM

;format: length [0, 7], pitch change [-7, 7]
pitch_sweep: MACRO
	db $10
	IF \2 > 0
		db (\1 << 4) | \2
	ELSE
		db (\1 << 4) | (%1000 | (\2 * -1))
	ENDC
ENDM

;format: length [0, 15], volume [0, 15], volume change [-7, 7], pitch
square_note: MACRO
	db $20 | \1
	IF \3 < 0
		db (\2 << 4) | (%1000 | (\3 * -1))
	ELSE
		db (\2 << 4) | \3
	ENDC
	dw \4
ENDM

;format: length [0, 15], volume [0, 15], volume change [-7, 7], pitch
noise_note: MACRO
	db $20 | \1
	IF \3 < 0
		db (\2 << 4) | (%1000 | (\3 * -1))
	ELSE
		db (\2 << 4) | \3
	ENDC
	db \4
ENDM

C_ EQU $0
C# EQU $1
D_ EQU $2
D# EQU $3
E_ EQU $4
F_ EQU $5
F# EQU $6
G_ EQU $7
G# EQU $8
A_ EQU $9
A# EQU $A
B_ EQU $B

;format: pitch length (in 16ths)
note: MACRO
	db (\1 << 4) | (\2 - 1)
ENDM

;format: instrument length (in 16ths)
snare1: MACRO
	db $B0 | (\1 - 1)
	db $01
ENDM

snare2: MACRO
	db $B0 | (\1 - 1)
	db $02
ENDM

snare3: MACRO
	db $B0 | (\1 - 1)
	db $03
ENDM

snare4: MACRO
	db $B0 | (\1 - 1)
	db $04
ENDM

snare5: MACRO
	db $B0 | (\1 - 1)
	db $05
ENDM

triangle1: MACRO
	db $B0 | (\1 - 1)
	db $06
ENDM

triangle2: MACRO
	db $B0 | (\1 - 1)
	db $07
ENDM

snare6: MACRO
	db $B0 | (\1 - 1)
	db $08
ENDM

snare7: MACRO
	db $B0 | (\1 - 1)
	db $09
ENDM

snare8: MACRO
	db $B0 | (\1 - 1)
	db $0A
ENDM

snare9: MACRO
	db $B0 | (\1 - 1)
	db $0B
ENDM

cymbal1: MACRO
	db $B0 | (\1 - 1)
	db $0C
ENDM

cymbal2: MACRO
	db $B0 | (\1 - 1)
	db $0D
ENDM

cymbal3: MACRO
	db $B0 | (\1 - 1)
	db $0E
ENDM

mutedsnare1: MACRO
	db $B0 | (\1 - 1)
	db $0F
ENDM

triangle3: MACRO
	db $B0 | (\1 - 1)
	db $10
ENDM

mutedsnare2: MACRO
	db $B0 | (\1 - 1)
	db $11
ENDM

mutedsnare3: MACRO
	db $B0 | (\1 - 1)
	db $12
ENDM

mutedsnare4: MACRO
	db $B0 | (\1 - 1)
	db $13
ENDM

;format: rest length (in 16ths)
rest: MACRO
	db $C0 | (\1 - 1)
ENDM

; format: notetype speed, volume, fade
note_type: MACRO
	db $D0 | \1
	db (\2 << 4) | \3
ENDM

dspeed: MACRO
	db $D0 | \1
ENDM

octave: MACRO
	db $E8 - \1
ENDM

toggle_perfect_pitch: MACRO
	db $E8
ENDM

;format: vibrato delay, rate, depth
vibrato: MACRO
	db $EA
	db \1
	db (\2 << 4) | \3
ENDM

pitch_slide: MACRO
	db $EB
	db \1
	db \2
ENDM

duty_cycle: MACRO
	db $EC
	db \1
ENDM

tempo: MACRO
	db $ED
	db \1 / $100
	db \1 % $100
ENDM

stereo_panning: MACRO
	db $EE
	db \1
ENDM

volume: MACRO
	db $F0
	db (\1 << 4) | \2
ENDM

execute_music: MACRO
	db $F8
ENDM

duty_cycle_pattern: MACRO
	db $FC
	db \1
ENDM

;format: callchannel address
sound_call: MACRO
	db $FD
	dw \1
ENDM

;format: loopchannel count, address
sound_loop: MACRO
	db $FE
	db \1
	dw \2
ENDM

sound_ret: MACRO
	db $FF
ENDM
