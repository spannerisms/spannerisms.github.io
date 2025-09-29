; :loop
; type nul >"%~n1".bin
; asar.exe --pause-mode=never -Dsong="%~n1" --fix-checksum=off song.bat "%~n1".bin
; shift
; 
; if "%~1" == "" goto done
; goto loop
; 
; :done
; pause
; exit

;@ math pri on
norom
incsrc "defines_music.asm"

org $000000
	!POINTERS = 0
	!SONG = -1 ; to increment it in the header
Song:
	.start
	incsrc "!song.asm"