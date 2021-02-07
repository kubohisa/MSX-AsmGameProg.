/*
	MSXでゲームを作るやつの仮組（デバッグしてないメモ）
	From.kubohisa.
*/

/*
	BIOS呼び出し
*/

BIOS:
;			ld ix,呼び出すBIOS番地

CALSLT	 	equ 001CH
EXPTBL	 	equ 0FCC1H

			ld iy,[EXPTBL-1]
            call CALSLT
			ret

/*
	BDOSアドレス
*/

;BDOS		EQU 0F37Dh
BDOS		EQU 00005h

/*
	VDP連続書き込み
*/

VDPIR:
;			ld hl,
;			ld b,

RDVDP   	EQU     0006H
WRVDP   	EQU     0007H
			
			push af
			ld a,[WRVDP]
			ld c,a
			pop af
			
			ld c,a
			out [c],a
			
			otir
			nop					;wait
			
			ret
			
/*
	タイマー割り込み
*/		
TIMER60:

HTIMI		EQU		0FD9Fh

			jp 0000h	;Set ADRS.
htimiorg:	db 0xc9, 0xc9, 0xc9, 0xc9, 0xc9, 0xc9

TIMER60INIT:
			di

			ld		hl, HTIMI
			ld		de, htimiorg
			ld		bc, 5
			ldir

			ld		hl, htiminew
			ld		de, HTIMI
			ld		bc, 3
			ldir

			ei
			ret

htiminew:
			jp		TIMER60

/*
	乱数発生ルーチン
*/

random8bit:

INTCNT		EQU		0FCA2H			

			;適当乱数
			ld a,[INTCNT]	;System Timer.
			RRC a
			ld b,a
			ld a,[RNDSEED]
			RLC a
			RLC a
			xor b
			dec a
			
			;a==0 ならタイマーの数値
			or a
			jr nz,RNDSAVE
			ld a,[INTCNT]
			
RNDSAVE:	ld [RNDSEED],a
			
			ret	

RNDSEED:	db	42
