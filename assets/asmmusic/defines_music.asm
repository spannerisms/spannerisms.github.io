!PART_END = $00
!tie = $C8
!rest = $C9
!4 = $48
!8 = $24
!8d = $36
!8t = $18
!16 = $12
!16d = $1B
!16t = $0C
!32 = $09
!32t = $06
!4d = $6C
!4t = $30
!n = $7F ; normal note strength duration, attack
!instr = $E0
!pan = $E1
	!panL = $14
	!pan0 = $0A
	!panR = $00
!pan_slide = $E2
!vibrato = $E3
!vibrato_off = $E4
!master_volume = $E5
!master_volume_slide = $E6
!tempo = $E7
!tempo_slide = $E8
!global_transpose = $E9
!transpose = $EA
!tremolo = $EB
!tremolo_off = $EC
!volume = $ED
!volume_slide = $EE
!callpart = $EF
!vibrato_level = $F0
!slide_to = $F1 ; Delay, Duration, Change
!slide_from = $F2 ; Delay, Duration, Change
!slide_off = $F3
!echo_set = $F5
!tune = $F4
!echo_off = $F6
!echo_props = $F7
!echo_slide = $F8
!slide_once = $F9 ; Delay, Duration, Target
!setpbase = $FA

!perc00 = $CA
!perc01 = $CB
!perc02 = $CC
!perc03 = $CD
!perc04 = $CE
!perc05 = $CF
!perc06 = $D0
!perc07 = $D1
!perc08 = $D2
!perc09 = $D3
!perc0A = $D4
!perc0B = $D5
!perc0C = $D6
!perc0D = $D7
!perc0E = $D8
!perc0F = $D9
!perc10 = $DA
!perc11 = $DB
!perc12 = $DC
!perc13 = $DD
!perc14 = $DE
!perc15 = $DF

; instruments
!RAIN = $01
!TIMPANI = $02
!SQUARE = $03
!SAW = $04
!CLINK = $05
!WOBBLE = $06
!COMPSAW = $07
!TWEET = $08
!STRINGSA = $09
!STRINGSB = $0A
!TROMBONE = $0B
!CYMBAL = $0C
!OCARINA = $0D
!CHIMES = $0E
!HARP = $0F
!SPLASH = $10
!TRUMPET = $11
!HORN = $12
!SNAREA = $13
!SNAREB = $14
!CHOIR = $15
!FLUTE = $16
!OOF = $17
!GUITAR = $18
!PIANO = !GUITAR

; Percussion notes, use with !perc, !PERC_BASE
!PERC_BASE = 1
RAN = $CA ; rain
TMP = $CB ; timpani
CMB = $D5 ; cymbal
SPL = $D9 ; splash
SNR = $DC ; snare
SNR2 = $DD ; snare 2

function bpm(m) = 36864*m/60000
;===================================================================================================
;---------------------------------------------------------------------------------------------------
; Macros
;---------------------------------------------------------------------------------------------------
;===================================================================================================
!ARAM = $D000
!ENDBANK = $0000
!SONG = 0
!SEGMENT = 0
!TRACK = 0
!OFFSET = "0-.start+!ARAM"
!TITLE = "SONG"
!POINTERS = 1
!BANKSIZE = 0
!clear0 = 0
!clear1 = 0
!clear2 = 0
!clear3 = 0
!clear4 = 0
!clear5 = 0
!clear6 = 0
!clear7 = 0

;===================================================================================================
; Song bank macros
;===================================================================================================
macro songbank(songcount)
	%songbankcust(<songcount>, $D000)
endmacro

macro songbankaux()
	%songbanksimple($2B00)
endmacro

macro songbankarb(songcount, ARAM)
	%songbankcust(<songcount>, <ARAM>)
endmacro

macro songbanksimple(ARAM)
	!ARAM = <ARAM>

	%calcsongbanksize()
	.header
		dw !BANKSIZE, <ARAM>
	.start
endmacro

macro calcsongbanksize()
	!BANKSIZE = (.end-$8000+$8000*((.end>>16)-(.start>>16))+((.start+$10000)&$FF0000)-.start)&$007FFF
endmacro

macro endbank()
	.end
	print "Song bank size: $", hex(!BANKSIZE)
endmacro

macro endtransfer()
	dw !ENDBANK, $0800
endmacro

;===================================================================================================
; Song macros
;===================================================================================================
macro song(stitle, segments, loopat)
	!SONG #= !SONG+1

	!SEGMENT = -1 ; to increment it in the header
	!TITLE = <stitle>
	!<stitle>_APU = ..segmentpointers+!OFFSET

	.<stitle>

	reset bytes

	..segmentpointers
		fillword $0000 : fill <segments>*2
		dw $00FF, ..segmentpointers+<loopat>*2+!OFFSET

endmacro

; This macro also adds a song's pointer to the list
macro addsong(stitle, segments, loopat)
	%song(<stitle>, <segments>, <loopat>

	%addsongpointer(segmentpointers+!OFFSET)
endmacro

macro repeatsong(song)
	!SONG #= !SONG+1

	%addsongpointer(<song>)
endmacro

macro endsong()
	!SONGP #= !SONG+1

	print "	Song $", hex(!SONGP, 2), " - !TITLE is ", bytes, " bytes (dec) at $", hex(!{!{TITLE}_APU})
endmacro

macro silentsong()
	!SONG #= !SONG+1
	%addsongpointer($0000)
endmacro

macro skipsong()
	!SONG #= !SONG+1
endmacro

macro addsongpointer(addr)
	pushpc
		org .songpointers+(!SONG*2)
				dw <addr>
	pullpc
	print "	Song $", hex(!SONG,2), " points to $", hex(<addr>)
endmacro

;===================================================================================================
; Segment macros
;===================================================================================================
macro segment(stitle)
	%addsegpointer(..segment<stitle>+!OFFSET)
	!TRACK = -1 ; to increment it in the header
	..segment!SEGMENT
	..segment<stitle>
	...trackpointers
		fillword $0000 : fill 16
endmacro

macro repeatsegment(stitle)
	%addsegpointer(..segment<stitle>+!OFFSET)
endmacro

macro addsegpointer(addr)
	!SEGMENT #= !SEGMENT+1
	pushpc
		org ..segmentpointers+(!SEGMENT*2) : dw <addr>
	pullpc
endmacro

;===================================================================================================
; Track macros
;===================================================================================================
macro track(ttitle)
	%addtrackpointer(...track<ttitle>+!OFFSET)

	...track!TRACK
	...track<ttitle>
endmacro

macro repeattrack(track)
	%addtrackpointer(...track<track>+!OFFSET)
endmacro

macro repeattrackfromseg(seg, track)
	%addtrackpointer(..segment<seg>_track<track>+!OFFSET)
endmacro

macro silenttrack()
	%addtrackpointer($0000)
endmacro

macro addtrackpointer(addr)
	!TRACK #= !TRACK+1
	pushpc
		org ...trackpointers+(!TRACK*2) : dw <addr>
	pullpc
endmacro

;===================================================================================================
; Other commands
;===================================================================================================
macro part(ptitle)
	#..part<ptitle>
endmacro

macro playpart(ptitle, n)
	db !callpart
	dw ..part<ptitle>+!OFFSET
	db <n>
endmacro


;======================================================================
; notes
;======================================================================

R = $C9

C1	= $80
Cs1	= $81
Df1	= $81
D1	= $82
Ds1	= $83
Ef1	= $83
E1	= $84
Ff1	= $84
Es1	= $85
F1	= $85
Fs1	= $86
Gf1	= $86
G1	= $87
Gs1	= $88
Af1	= $88
A1	= $89
As1	= $8A
Bf1	= $8A
B1	= $8B
Cf2	= $8B
Bs1	= $8C

C2	= $8C
Cs2	= $8D
Df2	= $8D
D2	= $8E
Ds2	= $8F
Ef2	= $8F
E2	= $90
Ff2	= $90
Es2	= $91
F2	= $91
Fs2	= $92
Gf2	= $92
G2	= $93
Gs2	= $94
Af2	= $94
A2	= $95
As2	= $96
Bf2	= $96
B2	= $97
Cf3	= $97
Bs2	= $98

C3	= $98
Cs3	= $99
Df3	= $99
D3	= $9A
Ds3	= $9B
Ef3	= $9B
E3	= $9C
Ff3	= $9C
Es3	= $9D
F3	= $9D
Fs3	= $9E
Gf3	= $9E
G3	= $9F
Gs3	= $A0
Af3	= $A0
A3	= $A1
As3	= $A2
Bf3	= $A2
B3	= $A3
Cf4	= $A3
Bs3	= $A4

C4	= $A4
Cs4	= $A5
Df4	= $A5
D4	= $A6
Ds4	= $A7
Ef4	= $A7
E4	= $A8
Ff4	= $A8
Es4	= $A9
F4	= $A9
Fs4	= $AA
Gf4	= $AA
G4	= $AB
Gs4	= $AC
Af4	= $AC
A4	= $AD
As4	= $AE
Bf4	= $AE
B4	= $AF
Cf5	= $AF
Bs4	= $B0

C5	= $B0
Cs5	= $B1
Df5	= $B1
D5	= $B2
Ds5	= $B3
Ef5	= $B3
E5	= $B4
Ff5	= $B4
Es5	= $B5
F5	= $B5
Fs5	= $B6
Gf5	= $B6
G5	= $B7
Gs5	= $B8
Af5	= $B8
A5	= $B9
As5	= $BA
Bf5	= $BA
B5	= $BB
Cf6	= $BB
Bs5	= $BC

C6	= $BC
Cs6	= $BD
Df6	= $BD
D6	= $BE
Ds6	= $BF
Ef6	= $BF
E6	= $C0
Ff6	= $C0
Es6	= $C1
F6	= $C1
Fs6	= $C2
Gf6	= $C2
G6	= $C3
Gs6	= $C4
Af6	= $C4
A6	= $C5
As6	= $C6
Bf6	= $C6
B6	= $C7
Cf7	= $C7
