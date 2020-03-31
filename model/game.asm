;===========================================================
; game.asm
;
; Data for game workflow handling
;===========================================================

GameCounter .byte $00 ;Counter for speed control
GameSpeed .byte $0A ;Cycles needed to update game

Temp .byte $00 ;Temporary data address