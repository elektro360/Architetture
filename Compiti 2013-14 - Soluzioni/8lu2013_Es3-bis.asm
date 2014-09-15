;/*Scrivere una programma in Assembly che, data una matrice quadrata
;M di interi a 32 bit, stampi su video “Vero”
;se la diagonale principale di M coincide con la diagonale 
;secondaria capovolta e stampi “Falso” altrimenti. 
;Segue un esempio:
; 2 | 15 | 3 | 31 |
; 4 | 5  | 16| 11 |
; 7 | 5  | 16| 56 |
; 2 | 21 | 4 | 31 |
;Il programma stamperà "Vero"*/

section .data
    M dd 2,15,3,31,4,5,16,11,7,5,16,56,2,21,4,31
    M_dim equ $-M
    n equ 4
    V db "Vero",10
    V_dim equ $-V
    F db "Falso",10
    F_dim equ $-F

section .text
    global _start
    _start:
        mov eax, 0 ; /*Righe Prima diagonale*/
        mov ebx, 0 ; /*Colonne Prima diagonale*/
        mov ecx, n ; /*Righe Seconda diagonale*/
        mov edx, 0 ; /*Colonne Seconda diagonale*/
        mov esi, n
        shl esi, 2 ;/*32 bit*/
    scan_row:
        mov edi, [eax+ebx*4+M] ;/*Prima diagonale*/
        mov ebp, [ecx+edx*4+M] ;/*Seconda diagonale*/
        cmp edi, ebp ;/* Se gli elementi sono diversi stampa falso */
        jne falso
    change_row:
        add eax, esi
        sub ecx, esi
        inc ebx
        inc edx
        cmp eax, M_dim
        jne scan_row
    vero:
        mov edx, V_dim
        mov ecx, V
        mov ebx, 1
        mov eax, 4
        int 0x80
        jmp fine         
    falso:
        mov edx, F_dim
        mov ecx, F
        mov ebx, 1
        mov eax, 4
        int 0x80
    fine:
        mov ebx, 0
        mov eax, 1
        int 0x80 
