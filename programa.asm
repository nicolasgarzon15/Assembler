org 100h ; inicio de programa arquitectura para el formato 8086
include 'emu8086.inc' ;Incluye funciones de libreria emu8086
  DEFINE_PRINT_NUM
  DEFINE_PRINT_NUM_UNS  ;Funciones para imprimir

mov si, 0
mov al, 0

;Convertir primera cadena a numero
 cadAnum:
cmp cad1[si], "$" ;si cadena es vacia sigue
 jz seguir        ;accion de continuar

 mov bl, 10       ;bl=10
 mul bl           ;multiplicar
sub cad1[si], '0' ;restar bytes de memoria
 add al, cad1[si] ;transformar bytes de memoria

 inc si      ;incrementa si contador
loop cadAnum ;se termina el ciclo y vuelve

seguir:
mov aux1, al ;aux1 = al
;Convertir segunda cadena a numero
mov si, 0   ; se vuelven 0 las variables
mov al, 0
cadAnum2:
cmp cad3[si], "$"
 jz seguir2

 mov bl, 10
 mul bl
sub cad3[si], '0'
 add al, cad3[si]

 inc si
loop cadAnum2    ; es el la misma funcion de arriba pero con la cadena 2

seguir2:
mov bl, al    ;bl=al
mov al, aux1  ;al= aux1
;realizar operaciones normalmente teniendo ya los dos numeros decimales
cmp cad2, "-"   ;comparacion de posibles signos de operacion
jz resta
cmp cad2, "+"
jz suma
cmp cad2, "*"
jz multi
cmp cad2, "/"
jz divi
resta:
sub al, bl  ;operacion resta
jmp fin
suma:
add al, bl  ;operacion suma
jmp fin
multi:
mul bl      ;operacion multiplicacion
jmp fin
divi:
div bl      ;operacion division
jmp fin

fin:
mov bx, ax
mov ah,09
lea dx,msg    ; desplazamiento en memoria del mensaje
int 21h
mov ax, bx
call PRINT_NUM ;llama la funcion imprimir
ret
cad1 db "10$"  ;cadenas asociadas para el calculo
cad2 db "-"
cad3 db "2$"
aux1 db ?     ;variables no inicializadas
aux2 dw ?
msg dw "El resultado es: $" ;imprime el resultado
