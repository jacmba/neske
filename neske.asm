;=================================================================
;
; Snake game
;
; Jacinto Mba Cantero <github.com/jacmba>
; 2020
;
;=================================================================


  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000

Reset:
  sei
  cld

MainLoop:
  jmp MainLoop

Nmi:
  rti

  .bank 1
  .org $FFFA
  .dw Nmi, Reset, 0
