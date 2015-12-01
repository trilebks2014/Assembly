inchuoi MACRO chuoi 
    MOV AH, 02h ; Xu?ng d�ng tru?c khi in chu?i 
    MOV DL, 13 
    INT 21h 
    MOV DL, 10 
    INT  21h  ; DX ch?a d?a ch?
    LEA  DX, chuoi ; bi?n chu?i c?n in l� tham s?v�o Macro 
    MOV  AH, 09h  
    INT 21h 
ENDM 
DSEG SEGMENT 
 msg1  DB  "Hay nhap chuoi ky tu, ket thuc bang Enter: "
 msg2  DB  "Chuoi dao nguoc la: $�   sokt DW "           
 sokt DW ?
DSEG ENDS 
SSEG SEGMENT STACK 'STACK' 
    DW 256 DUP(?) 
SSEG ENDS 
CSEG SEGMENT 
 ASSUME  CS: CSEG, DS: DSEG, SS: SSEG  
start: 
    MOV AX, DSEG 
    MOV DS, AX 
    inchuoi msg1  
    CALL nhapchuoi 
    inchuoi  msg2  
    CALL daochuoi
    MOV AH, 4Ch 
    INT 21h 
nhapchuoi PROC 
        POP BX 
        XOR CX, CX 
    nhap: 
        MOV AH, 01 
        INT 21h 
        CMP AL, 0Dh ; C� ph?i ph�m Enter kh�ng? 
        JZ stop ; ph?i th� d?ng, kh�ng ph?i th� nh?p ti?p 
        PUSH AX  ; C?t k� t?trong AL v�o ngan x?p 
        INC  CX  ; d?m s?k� t?nh?p 
        JMP  nhap  ; nh?p ti?p k� t?
     stop:  
        MOV  sokt, CX  ; c?t s?k� t? d� nh?p 
        PUSH BX 
        RET 
nhapchuoi ENDP 
daochuoi PROC 
    POP BX 
    MOV CX, sokt 
    intiep: MOV  AH, 02 
    POP DX  ; L?y k� t?trong ngan x?p ra DL d?in 
    INT 21h 
    LOOP intiep 
    PUSH BX 
    RET 
daochuoi ENDP 
CSEG ENDS 
END start 