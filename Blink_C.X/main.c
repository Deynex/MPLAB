// Configuraci�n de los fusibles
#pragma config FOSC = HSPLL_HS // Oscilador HS con PLL habilitado
#pragma config WDT = OFF       // Desactivar el Watchdog Timer
#pragma config LVP = OFF       // Desactivar la programaci�n de bajo voltaje
#pragma config MCLRE = ON      // Usar pin MCLR como Reset

#include <xc.h>

#define _XTAL_FREQ 48000000 // Frecuencia del oscilador, en este caso 48 MHz

void main(void)
{
    // Configurar el pin RD0 como salida
    TRISD0 = 0; // Configura RD0 (pin D0) como salida

    while (1)
    {
        LATD0 = 1;       // Enciende el LED (nivel alto en el pin RD0)
        __delay_ms(500); // Espera 500 milisegundos

        LATD0 = 0;       // Apaga el LED (nivel bajo en el pin RD0)
        __delay_ms(500); // Espera 500 milisegundos
    }
}