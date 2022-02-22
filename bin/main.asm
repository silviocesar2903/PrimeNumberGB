;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _clock
	.globl _puts
	.globl _printf
	.globl _checkPrimeNumber
	.globl _delay
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
;main.c:68: void delay(int number_of_seconds)
;	---------------------------------
; Function delay
; ---------------------------------
_delay::
	add	sp, #-4
;main.c:71: int milli_seconds = 1000 * number_of_seconds;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	inc	sp
	inc	sp
	push	hl
;main.c:74: clock_t start_time = clock();
	call	_clock
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:77: while (clock() < start_time + milli_seconds);
00101$:
	call	_clock
	pop	bc
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	C, 00101$
;main.c:78: }
	add	sp, #4
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:14: int main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-2
;main.c:22: printf("Prime numbers between %d and %d are: \n", n1, n2);
	ld	hl, #0x2710
	push	hl
	ld	hl, #0x0000
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_printf
	add	sp, #6
;main.c:23: delay(1);
	ld	hl, #0x0001
	push	hl
	call	_delay
	add	sp, #2
;main.c:24: while(1)
00108$:
;main.c:26: int c =0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;main.c:27: for (i = n1 + 1; i < n2; ++i) 
	ld	bc, #0x0001
00111$:
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0xa7
	jr	NC, 00106$
;main.c:31: flag = checkPrimeNumber(i);
	push	bc
	push	bc
	call	_checkPrimeNumber
	add	sp, #2
	pop	bc
;main.c:32: if (flag == 1)
	ld	a, e
	dec	a
	or	a, d
	jr	NZ, 00112$
;main.c:34: if(c == 3)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x03
	inc	hl
	or	a, (hl)
	jr	NZ, 00102$
;main.c:36: printf("\t%d\n", i);
	push	bc
	push	bc
	ld	hl, #___str_1
	push	hl
	call	_printf
	add	sp, #4
	pop	bc
;main.c:37: c = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	jr	00112$
00102$:
;main.c:41: printf("\t%d", i);
	push	bc
	push	bc
	ld	hl, #___str_2
	push	hl
	call	_printf
	add	sp, #4
	pop	bc
;main.c:42: c++;
	ldhl	sp,	#0
	inc	(hl)
	jr	NZ, 00145$
	inc	hl
	inc	(hl)
00145$:
00112$:
;main.c:27: for (i = n1 + 1; i < n2; ++i) 
	inc	bc
	jr	00111$
00106$:
;main.c:47: printf("\n\n\n\n");
	ld	hl, #___str_4
	push	hl
	call	_puts
	add	sp, #2
	jr	00108$
;main.c:51: }
	add	sp, #2
	ret
___str_0:
	.ascii "Prime numbers between %d and %d are: "
	.db 0x0a
	.db 0x00
___str_1:
	.db 0x09
	.ascii "%d"
	.db 0x0a
	.db 0x00
___str_2:
	.db 0x09
	.ascii "%d"
	.db 0x00
___str_4:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x00
;main.c:53: int checkPrimeNumber(int n) {
;	---------------------------------
; Function checkPrimeNumber
; ---------------------------------
_checkPrimeNumber::
	add	sp, #-4
;main.c:54: int i, flag = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
	xor	a, a
	inc	hl
;main.c:56: for (i = 2; i <= n / 2; ++i) {
	ld	(hl+), a
	ld	(hl), #0x02
	xor	a, a
	inc	hl
	ld	(hl), a
00105$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, b
	jr	Z, 00109$
	inc	bc
00109$:
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00130$
	bit	7, d
	jr	NZ, 00131$
	cp	a, a
	jr	00131$
00130$:
	bit	7, d
	jr	Z, 00131$
	scf
00131$:
	jr	C, 00103$
;main.c:58: if (n % i == 0) {
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__modsint
	add	sp, #4
	ld	a, d
	or	a, e
	jr	NZ, 00106$
;main.c:59: flag = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;main.c:60: break;
	jr	00103$
00106$:
;main.c:56: for (i = 2; i <= n / 2; ++i) {
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00105$
	inc	hl
	inc	(hl)
	jr	00105$
00103$:
;main.c:64: return flag;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:65: }
	add	sp, #4
	ret
	.area _CODE
	.area _CABS (ABS)
