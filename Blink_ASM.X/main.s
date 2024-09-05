; Configuraciones de bits de configuración del PIC18F4550

; CONFIG1L
  CONFIG  PLLDIV = 1            ; Prescaler del PLL (Sin prescaler (4 MHz))
  CONFIG  CPUDIV = OSC1_PLL2    ; Postscaler del reloj del sistema ([Oscilador Principal: /1][PLL de 96 MHz: /2])
  CONFIG  USBDIV = 1            ; Fuente de reloj USB proviene directamente del oscilador principal sin postscaler

; CONFIG1H
  CONFIG  FOSC = EC_EC          ; Oscilador externo EC, función CLKO en RA6
  CONFIG  FCMEN = OFF           ; Monitor de reloj a prueba de fallos deshabilitado
  CONFIG  IESO = OFF            ; Conmutación del oscilador interno/externo deshabilitada

; CONFIG2L
  CONFIG  PWRT = OFF            ; Temporizador de encendido deshabilitado
  CONFIG  BOR = ON              ; Reinicio por bajo voltaje habilitado
  CONFIG  BORV = 3              ; Voltaje mínimo de reinicio por bajo voltaje 2.05V
  CONFIG  VREGEN = OFF          ; Regulador de voltaje USB deshabilitado

; CONFIG2H
  CONFIG  WDT = OFF             ; Temporizador watchdog deshabilitado
  CONFIG  WDTPS = 32768         ; Postscaler del watchdog 1:32768

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 multiplexado con RC1
  CONFIG  PBADEN = OFF          ; Pines de PORTB configurados como digitales al reset
  CONFIG  LPT1OSC = OFF         ; Temporizador 1 en operación de mayor consumo
  CONFIG  MCLRE = ON            ; Pin MCLR habilitado

; CONFIG4L
  CONFIG  STVREN = ON           ; Desbordamiento/subdesbordamiento de pila provocará reinicio
  CONFIG  LVP = OFF             ; ICSP de un solo suministro deshabilitado
  CONFIG  ICPRT = OFF           ; Puerto de depuración en circuito deshabilitado
  CONFIG  XINST = OFF           ; Conjunto de instrucciones extendido deshabilitado

; CONFIG5L
  CONFIG  CP0 = OFF             ; Protección de código para el bloque 0 deshabilitada
  CONFIG  CP1 = OFF             ; Protección de código para el bloque 1 deshabilitada
  CONFIG  CP2 = OFF             ; Protección de código para el bloque 2 deshabilitada
  CONFIG  CP3 = OFF             ; Protección de código para el bloque 3 deshabilitada

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Protección de escritura para el bloque 0 deshabilitada
  CONFIG  WRT1 = OFF            ; Protección de escritura para el bloque 1 deshabilitada
  CONFIG  WRT2 = OFF            ; Protección de escritura para el bloque 2 deshabilitada
  CONFIG  WRT3 = OFF            ; Protección de escritura para el bloque 3 deshabilitada

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Protección de lectura de tabla para el bloque 0 deshabilitada
  CONFIG  EBTR1 = OFF           ; Protección de lectura de tabla para el bloque 1 deshabilitada
  CONFIG  EBTR2 = OFF           ; Protección de lectura de tabla para el bloque 2 deshabilitada
  CONFIG  EBTR3 = OFF           ; Protección de lectura de tabla para el bloque 3 deshabilitada

; Declaración de secciones de código
#include <xc.inc>

psect barfunc,local,class=CODE,reloc=2 ; PIC18

global _start

_start:

    ; Configurar TRISA como salida (poner el bit 0 de TRISA en 0)
    BANKSEL TRISA       ; Seleccionar el banco de TRISA
    clrf BANKMASK(PORTA)          ; Apagar todos los pines de PORTA
    bcf BANKMASK(TRISA), 0        ; RA0 como salida

blink:
    ; Encender LED (RA0)
    bsf BANKMASK(PORTA), 0        ; Poner RA0 en alto (encender LED)
    call delay

    ; Apagar LED (RA0)
    bcf BANKMASK(PORTA), 0        ; Poner RA0 en bajo (apagar LED)
    call delay

    goto blink                    ; Repetir el bucle

; Subrutina de retardo (ajusta los ciclos según tu necesidad)
delay:
    movlw 0xFF                    ; Carga 255 en WREG (valor máximo)
delay_loop1:
    movwf 0x20                    ; Carga el valor en un registro de trabajo
delay_loop2:
    decfsz 0x20, f                ; Decrementar el registro hasta llegar a 0
    goto delay_loop2              ; Si no es 0, sigue decrementando
    decfsz WREG, f                ; Decrementa WREG
    goto delay_loop1              ; Si no es 0, sigue el ciclo
    return
