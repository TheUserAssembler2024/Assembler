use16
org 0x7C00
mov ax,0x0013
int 0x10
mov ax,0xA000
mov es,ax
xor di,di
mov cx,32000
xor ax,ax
rep stosw
mov al,40
mov bx,19
mov cx,15
xo:
push cx
mov di,bx
mov cx,200
xi:
mov[es:di],al
add di,320
loop xi
pop cx
add bx,20
loop xo
mov bx,19
mov cx,10
yo:
push cx
mov di,bx
imul di,320
mov cx,320
yi:
mov[es:di],al
inc di
loop yi
pop cx
add bx,20
loop yo
jmp $
times 510-($-$$) db 0
dw 0xAA55
