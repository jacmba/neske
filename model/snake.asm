;===========================================================
; snake.asm
;
; Data model for snake object
;===========================================================

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

CollisionMask:  ;Bit mask to detect collilsions with apple:
                ;7 6 5 4 3 2 1 0
                ;| | | | | | | +-- Right boundary
                ;| | | | | | +---- Upper boundary
                ;| | | | | +------ Left boundary
                ;| | | | +-------- Lower boundary
                ;+ + + +---------- Unused
  .byte %00000000
