!ARAM = $4000
!SAMPLE = 0

macro add_sample(name, loop)
	!sample_<name> #= !SAMPLE
	incbin "<name>.brr"
	!sample_<name>_start #= !ARAM
	!sample_<name>_loop #= !ARAM+<loop>
	pushpc
		org .samples_table+(!SAMPLE*4)
			dw !sample_<name>_start, !sample_<name>_loop
	pullpc
	!ARAM #= !ARAM+filesize("<name>.brr")

	!SAMPLE #= !SAMPLE+1
endmacro

macro repeat_sample(name)
	pushpc
		org .samples_table+(!SAMPLE*4)
			dw !sample_<name>_start, !sample_<name>_loop
	pullpc
	!SAMPLE #= !SAMPLE+1
endmacro

!INSTRUMENT = 0
macro add_instrument(name, sample, ad, sr, gain, pitch)
	!instr_<name> #= !INSTRUMENT

	db <sample>
	db <ad>, <sr>
	db <gain>
	db (<pitch>)>>8, <pitch>

	!INSTRUMENT #= !INSTRUMENT+1

endmacro

;=================================================================
org $198000
SongBank_samplepointers:
	%songbanksimple($3C00)
		fillword $0000 : 28*4 ; add room for X samples
	%endbank()

SongBank_samples:
	%songbanksimple($4000)
		%add_sample("unknown", $12)
		%add_sample("rain", $1B)
		%add_sample("timpani", $BA3)
		%add_sample("square", $1B)
		%add_sample("saw", $1B)
		%add_sample("clink", $1B)
		%add_sample("doublesawA", $2D)
		%add_sample("doublesawB", $12)
		%add_sample("tweet", $57C)
		%add_sample("strings", $58E)
		%repeat_sample("strings")
		%add_sample("trombone", $3F0)
		%add_sample("cymbal", $D92)
		%add_sample("ocarina", $195)
		%add_sample("chime", $75)
		%add_sample("harp", $1CB)
		%add_sample("splash", $7BC)
		%add_sample("trumpet", $6ED)
		%add_sample("horn", $6C9)
		%add_sample("snare", $D2F)
		%repeat_sample("snare")
		%add_sample("choir", $52B)
		%add_sample("flute", $21C)
		%add_sample("OOF", $240)
		%add_sample("guitar", $735)
	%endbank()

SongBank_instruments:
	%songbanksimple($3D00)
		%add_instrument("unknown", !sample_unknown,\
						$FF, $E0, $B8, $0470)

		%add_instrument("rain", !sample_rain,\
						$FF, $E0, $B8, $0790)

		%add_instrument("timpani", !sample_timpani,\
						$FF, $E0, $B8, $0C90)

		%add_instrument("square", !sample_square,\
						$FF, $E0, $B8, $0400)

		%add_instrument("saw", !sample_saw,\
						$FF, $E0, $B8, $0400)

		%add_instrument("clink", !sample_clink,\
						$FF, $E0, $B8, $0470)

		%add_instrument("doublesawA", !sample_doublesawA,\
						$FF, $E0, $B8, $0470)

		%add_instrument("doublesawB", !sample_doublesawB,\
						$FF, $E0, $B8, $07A0)

		%add_instrument("tweet", !sample_tweet,\
						$FF, $E0, $B8, $07A0)

		%add_instrument("stringsA", !sample_strings,\
						$8F, $E9, $B8, $01E0)

		%add_instrument("stringsB", !sample_strings+1,\
						$8A, $E9, $B8, $01E0)

		%add_instrument("trombone", !sample_trombone,\
						$FF, $E0, $B8, $0300)

		%add_instrument("cymbal", !sample_cymbal,\
						$FF, $E0, $B8, $03A0)

		%add_instrument("ocarina", !sample_ocarina,\
						$FF, $E0, $B8, $0100)

		%add_instrument("chimes", !sample_chime,\
						$FF, $EF, $B8, $0EA0)

		%add_instrument("harp", !sample_harp,\
						$FF, $EF, $B8, $0600)

		%add_instrument("splash", !sample_splash,\
						$FF, $E0, $B8, $03D0)

		%add_instrument("trumpet", !sample_trumpet,\
						$8F, $E0, $B8, $0300)

		%add_instrument("horn", !sample_horn,\
						$8F, $E0, $B8, $06F0)

		%add_instrument("snare", !sample_snare,\
						$FD, $E0, $B8, $07A0)

		%add_instrument("snare2", !sample_snare+1,\
						$FF, $E0, $B8, $07A0)

		%add_instrument("choir", !sample_choir,\
						$FF, $E0, $B8, $03D0)

		%add_instrument("flute", !sample_flute,\
						$8F, $E0, $B8, $0300)

		%add_instrument("OOF", !sample_OOF,\
						$FF, $E0, $B8, $02C0)

		%add_instrument("guitar", !sample_guitar,\
						$FE, $8F, $B8, $06F0)

		padbyte $FF : pad $19FBCA
	%endbank()