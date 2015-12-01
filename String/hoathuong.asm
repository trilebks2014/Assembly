.MODEL small
.STACK
.DATA
    tb1 DB 'Nhap vao 1 chuoi: $'
    tb2 DB 10,13,'Doi thanh chu thuong: $'
    tb3 DB 10,13,'Doi thanh chu hoa: $'
    s   DB 100,?,101 dup('$')
.CODE
BEGIN:
    MOV AX, @DATA
    MOV DS,AX
    ;xuat chuoi tb1
    MOV AH,09h        
    LEA DX,tb1
    INT 21h
    ;nhap chuoi s
    MOV AH,0AH        
    LEA DX,s
    INT 21h
    ;xuat chuoi tb2
    MOV AH,09h        
    LEA DX,tb2
    INT 21h    
; Goi chuong trinh con in chuoi thuong
    CALL InChuoiThuong                   

; xuat chuoi tb3
    MOV AH,09h        
    LEA DX,tb3
    INT 21h           
; Goi chuong trinh con in chuoi thuong
    CALL InChuoiHoa                       
    
    MOV AH,4ch
    INT 21h
;**************************************    
; Doi thanh chuoi ky tu thuong
    InChuoiThuong PROC
        LEA SI,s+1        
        XOR CX,CX
        MOV CL,[SI]
        INC SI
        LapThuong:
            MOV AH,02h
            MOV DL,[SI]
            CMP DL,'A'
            JB    LT1
            CMP DL,'Z'
            JA    LT1
            ADD DL,32
            LT1: INC SI
                INT 21h
            LOOP LapThuong
        RET
    InChuoiThuong ENDP 
; Doi thanh chuoi ky tu hoa
    InChuoiHoa PROC
        LEA SI,s+1        
        XOR CX,CX
        MOV CL,[SI]
        INC SI
        LapHoa:
            MOV AH,02h
            MOV DL,[SI]
            CMP DL,'a'
            JB    LH1
            CMP DL,'z'
            JA    LH1
            SUB DL,32
            LH1: INC SI
                INT 21h
            LOOP LapHoa
        RET
    InChuoiHoa ENDP 

END BEGIN