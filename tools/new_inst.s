NOP
LI R1 1
LI R2 2
MOVE R1 R2
NEG R3 R1
LI R4 85
SLL R4 R4 0
SW R4 R1 0
SW R4 R2 1
SW R4 R3 2
CMPI R1 8
BTEQZ 8
NOP
LI R2 4
SRL R1 R2 1
SW R4 R1 3
SW R4 R2 4
LI R1 1
SLLV R1 R2
SW R4 R2 5
JR R7
NOP