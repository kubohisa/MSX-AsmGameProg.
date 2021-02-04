/*
	SOS SWORD PLAYER. ver.0.00.
	From.kubohisa.
*/


			MSXDOS
	
			call SOS_WIDTH
			jp APPLI

_SOS_HOT:	
			ld c,00h
			call 0005h
			jp	0000h

_SOS_POUSE:
			ld c,01h
			call 0005h
			cp 20h
			jr nz,_SOS_POUSE
			ret

_SOS_BELL:	
			CALLBIOS 00c0h
			ret
			
_SOS_WIDTH:
			ld a,40
			ld [0xf3ae],a
			
			ld a,0h
			CALLBIOS CHGMOD
			ret

//

SOS_COLD:	jp SOS_HOT
SOS_HOT:	jp _SOS_HOT

SOS_PAUSE:	jp _SOS_POUSE
SOS_BELL:	jp _SOS_BELL

SOS_WIDTH:	jp _SOS_WIDTH

//

APPLI:		
			call SOS_BELL
			call SOS_PAUSE
			jp SOS_COLD
