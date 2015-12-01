.model small
.stack 100h 
.data
    msg1 db "Nhap vao 1 chuoi: $"
    msg2 db 10,13,"Chuoi nghich dao la: $"
.code
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, msg1
    int 21h
    
    mov cx,0
  nhap:
    mov ah,1
    int 21h
    cmp al,13
    je thongbaoxuat
    xor ah,ah
    push ax
    inc cx
    jmp nhap
  thongbaoxuat:
    mov ah,9
    lea dx, msg2
    int 21h
  xuat:
    pop ax
    mov dl,al
    mov ah,2
    int 21h
    loop xuat
    
    mov ah,4ch
    int 21h  
  end