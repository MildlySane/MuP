    .nolist ; turn list file generation OFF

    .include "m8def.inc"
    .list /* turn it ON again */

    .ORG 0 ; set program origin
    RJMP reset ; on reset, program starts here

    .ORG 0x0002 ;
    RJMP int0_ISR;

reset:
    LDI R16, LOW(RAMEND) ;
    OUT SPL, R16
    LDI R16, HIGH(RAMEND) /* Guess, why it is done ??? */
    OUT SPH, R16
    LDI R16, 0x02 ; make PB1 OUTput
    OUT DDRB, R16; /* fill in here */
    LDI R16, 0x00 ; fill in here
    OUT DDRD, R16 ; make PORTD input
    LDI R16,0x04 ; /* enable internal pull-up resistor. This avoids the high impe */
    OUT PORTD, R16 ; /* -dance state while reading data from external world */
    IN R16, MCUCR ;
    ORI R16, 1<<ISC01 ; why it is Ored?
    OUT MCUCR, R16 ;
    IN R16, GICR ; enable INT0 interrupt
    ORI R16, 1<<INT0 ;
    OUT GICR, R16 ; /* fill in here */
    LDI R16, 0x00 ;
    OUT PORTB, R16 ;
    SEI ; /* what does it do? */
indefiniteloop: RJMP indefiniteloop /* Stay here. Expecting interrupt? */

 /* reset – the main - loop ends here */
int0_ISR: ; INT1 interrupt handler or ISR
    IN R16, SREG ; save status register SREG
    PUSH R16 ; /* Fill in here. save the status register contents into the stack memory. */
    /* StckPntr decremented. StckPntr tracks the lower end of ACTIVE stack. PC is */
    /* PUSHed automatically, by default. No need for explicit instruction */

    LDI R16,0x0a ; blink led 10 times by storing R0 a value of 10 & decrementing
    MOV R0, R16 /* to zero realises the LED blinking 10 times */
back5:
    LDI R16,0x02 ; Turn on LED
    OUT PORTB, R16 /* LED connected to penultimate bit (B1) of PORTB */

delay1:
    LDI R16,0xFF ; delay
back2: 
    LDI R17,0xFF ; /* back2 loop starts.. adds delay */
back1: 
    DEC R17 /* fill in. Innermost delay loop. Each execution cycle is of T_clk */
    BRNE back1 /* branch if not equal – means go on in loop till R* goes 0 */
    DEC R16 /* for each inner loop run, an equal amount of delay in OUTer loop */
    BRNE back2 /* how many clock cycles for ON period? */
    /* Till this time LED is ON. First part of duty cycle ends */
    LDI R16,0x00 ; Turn off LED
    OUT PORTB, R16; /* fill-in here */

delay2:
    LDI R16,0xFF ; delay – OFF period. Second part of duty cycle starts
back3: 
    LDI R17,0xFF
back4: 
    DEC R17
    BRNE back4
    DEC R16
    BRNE back3
    DEC R0 /* Fill in here. Initially R0 = 10. Completes ONE duty cycle */
BRNE back5 ; /* R0-- till 0. 10 times blinking */

    POP R16 ; retrieve status register. The stack’s lower end is incremented
    OUT SREG, R16 /* meaning stckPntr++; In “pop R16” instruction, the topend
    /* stack location’s value is espewed OUT and is stored IN R16 */
    RETI ; go back to main program and set I = 1 (enabling interrupts as the current ISR is executed)

