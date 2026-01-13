### Build and launch
1. `sudo apt install fasm&&sudo apt install qemu-system-x86 qemu-utils`
2. `fasm name.asm name.bin`
3. `qemu-system-x86_64 -drive format=raw,file=name.bin`
### Code
```asm
;1 pixel (this is my first BIOS code)
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
mov di,100*320+160
mov al,40
mov[es:di],al
jmp $
times 510-($-$$)db 0
dw 0xAA55
```
```asm
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
```
```asm
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
mov ax,0x2828
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
mov cx,160
yi:
mov[es:di],ax
add di,2
loop yi
pop cx
add bx,20
loop yo
jmp $
times 510-($-$$) db 0
dw 0xAA55
```
```asm
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
mov byte[x],10
mov byte[y],10
call d
jmp $
c0:db 0x38,0x6C,0xC6,0xC6,0xD6,0xD6,0xC6,0xC6,0x6C,0x38
x:db 0
y:db 0
d:mov si,c0
movzx bx,byte[y]
movzx ax,byte[x]
mov cx,320
imul bx,cx
add bx,ax
mov di,bx
mov cx,10
nxtln:
lodsb
push cx
mov cx,7
mov ah,al
nxtpx:
shl ah,1
jnc skp
mov al,0x28
mov[es:di],al
mov al,ah
skp:
inc di
loop nxtpx
add di,320-7
pop cx
loop nxtln
ret
times 510-($-$$) db 0
dw 0xAA55
```
