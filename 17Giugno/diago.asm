;/*Scrivere una programma in Assembly che, dato un intero k (a 15bit) e una matrice quadrata M di interi a 16bit, 
;stampi su video "Vero" se la diagonale principale di M contiene almeno un' occorrenza di k, e stampi “Falso” altrmenti. 
;Segue un esempio
;ESEMPIO - Sia k=3 e si consideri la matrice in figura
; 21 | 5 | 3 | 12
;  4 | 3 | 14| 11
; 32 | 2 | 5 | 56
;  4 | 11| 14| 3
;Il programma stamperà "Vero" poiché la diagonale principale di M contiene due occorrenze di k*/

section .data
    M dw 21,5,3,12,4,3,14,11,32,2,5,56,4,11,14,3 ;/*MATRICE = BASE + (INDICE * SCALA) + SPIAZZAMENTO = <regbase> + <regindice> * 1,2,4,8 + <offset>*/
    dim equ $-M
    n equ 4
    k equ 3
    V db "Vero",10
    dim_true equ $-V
    F db "Falso",10
    dim_false equ $-F

section .text
    global _start
    _start:
        mov eax, 0 ; /*Righe*/
        mov ebx, 0 ; /*Colonne*/
        mov esi, n
        shl esi, 1 ;/* 16 bit */
    scan_row:
        mov dx, [eax+ebx*2+M]
        cmp dx,k
        je vero
        jmp change_row
    change_row:
        add eax, esi
        inc ebx
        cmp eax, dim
        jne scan_row
    falso:
        mov edx, dim_false
        mov ecx, F
        mov ebx, 1
        mov eax, 4
        int 0x80
        jmp fine
    vero:
        mov edx, dim_true
        mov ecx, V
        mov ebx, 1
        mov eax, 4
        int 0x80
    fine:
        mov ebx, 0
        mov eax, 1
        int 0x80 
