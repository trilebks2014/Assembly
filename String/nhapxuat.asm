

data segment        
    tb1 db "Hay nhap vao mot chuoi ky tu:  $" 
    tb2 db 13, 10,"chuoi vua nhap la:  $"
    str db 200,?,200 dup(?)
ends
stack segment
    dw 128 dub(?)
ends
code segment
    mov ax,data
    mov ds,ax 
    
    lea dx,tb1
    mov ah,09h
    int 21h 
    
    mov ah,0Ah
    lea dx,str
    int 21h 
    
    lea DX,tb2
    mov ah,09h
    int 21h 
    
    lea bx,str
    mov al,{bx+01h}
    mov ah,00h
    add bx,ax
    mov [bx+2],"$"
    mov ah,09h
    lea dx,str+2
    int 21h
ends