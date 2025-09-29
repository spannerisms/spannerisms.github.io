; copy alttp.sfc songlisten.sfc
; asar.exe --pause-mode=never -Dsong="%~n1" --fix-checksum=off songlisten.bat songlisten.sfc
; 
; pause
; exit

math pri on

lorom

incsrc "defines_music.asm"

org $00802F
	LDA.b #$0B : STA.w $2140
--	BRA --


org $1A9EF5
!POINTERS = 0
!SONG = -1 ; to increment it in the header

ActualSong:
.start
pushpc
org ActualSong : incsrc "!song.asm"
pullpc
DumbReIncludeBecauseThePreviousOneWasOnlyToSetARAM:
%songbanksimple(!ARAM)
incsrc "!song.asm"
%endbank()

Songs:
	dw .end-.start, $D000
.start
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw !ARAM
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
.end

print pc

%endtransfer()

check bankcross off