;=====================================================================
; snake.asm
;
; Data model for snake object
;=====================================================================

PosX: ;Horizontal position
  .byte $80
PosY: ;Vertical position
  .byte $80
Size: ;Current snake's tail size
  .byte $00
Direction: ;Movement direction [1-4]: Right, Up, Left, Down
  .byte $01
Speed: ;Movement speed in pixel units
  .byte $01
