### What is this
- My old assembly code
- Here is the first code I wrote to understand how to write in Asm
- This is training and junk code, I plan to write normal things for UEFI
- My training history
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
;Pixel grid (this is where I learned to think through cycles and arithmetic)
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
;Optimizing horizontal lines across words
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
mov cx,160;Edit: optimization allows you to do things 2 times faster
yi:
mov[es:di],ax;Edit: I'm now 2 pixels at a time
add di,2;Edit: we write two pixels at once, so we advance the pointer by two bytes each step
loop yi
pop cx
add bx,20
loop yo
jmp $
times 510-($-$$) db 0
dw 0xAA55
```
```asm
;The "0" character from the VGA ROM (font 10h, but I get the bitmaps and shit at 13h)
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
### Results
- This was training on BIOS, I mastered the basics (and I understand that there is SIMD and `rep movsd` with double words and many more possibilities), and when I figure out how to compile code for UEFI (including PE headers and other structures), I will start writing normal code for UEFI instead of the archaic BIOS.
### What I have mastered, what I plan to master, what I do not plan to master
```diff asm
- Windows	skip	
! Linux		maybe	
+ BIOS		legacy	
! UEFI		pending	
```
![](https://raw.githubusercontent.com/TheUserAssembler2024/Assembler/main/shit/0.svg)
