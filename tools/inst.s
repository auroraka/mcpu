LI R1 0x11
LI R2 0x22
LI R3 0x33

;    [example code]
;R1串口(屏幕输出)地址
;R2 ASCII值[0x20,0x80)
;NOP
;LI R1 0xBF     ;R1赋值0xBF00
;SLL R1 R1 0x0 
;LI R2 0x20   ;R2赋值0x20
;SW R1 R2 0x0 ;打印
;ADDIU R2 0x1 ;R2=R2+1
;CMPI R2 0x80 ;if R2!=0x80
;BTNEZ 0xFC   ;PC=PC-3
;RET