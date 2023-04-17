.section .data

.equ RCGC_GPIO_R, 0x400FE608
.equ RCGC_GPIO_PORT_A, 0x01
.equ RCGC_GPIO_PORT_B, 0x02
.equ RCGC_GPIO_PORT_C, 0x04
.equ RCGC_GPIO_PORT_D, 0x08
.equ RCGC_GPIO_PORT_E, 0x10
.equ RCGC_GPIO_PORT_F, 0x20

.equ GPIO_PORT_F_DATA_R, 0x400253FC
.equ GPIO_PORT_F_DEN_R,  0x4002551C
.equ GPIO_PORT_F_DIR_R,  0x40025400
.equ GPIO_PORT_F_PUR_R,  0x40025510

.equ PIN0, 0x01
.equ LED_GREEN, 0x08
.equ LED_BLUE, 0x04
.equ PIN1, 0x02
.equ LED_RED, 0x02
.equ PIN2, 0x04
.equ PIN3, 0x08
.equ PIN4, 0x10
.equ BUTTON, 0x10
.equ PIN5, 0x20
.equ PIN6, 0x40
.equ PIN7, 0x80
.equ ALL_PINS, 0xFF

.section .text
.global main
.align



nicht_betätigt:
//setzt die grüne LED auf an
    LDR r0, =GPIO_PORT_F_DATA_R
    LDR r1, [r0]
    MOV r3, #LED_RED
    BIC r1, r1, r3
    STR r1, [r0]
//setzt die rote LED auf aus
    LDR r0, =GPIO_PORT_F_DATA_R
    LDR r1, [r0]
    MOV r3, #LED_GREEN
    ORR r1, r1, r3
    STR r1, [r0]
    cmp r7, #1
    BEQ setmaximum
    LSR r7, r7, #1

    B delay

betätigt:
// setzt die rote LED auf an
    LDR r0, =GPIO_PORT_F_DATA_R
    LDR r1, [r0]
    MOV r3, #LED_RED
    ORR r1, r1, r3
    STR r1, [r0]
// setzt die grüne LED auf  aus
    LDR r0, =GPIO_PORT_F_DATA_R
    LDR r1, [r0]
    MOV r3, #LED_GREEN
    BIC r1, r1, r3
    STR r1, [r0]
    LDR r5, =0x80000000
    cmp r7, r5
    BEQ setminimum
    LSL r7, r7, #1

    B delay

// delay, das durch subtrahieren und aufrufen der Funktion erzeugt wird
delay:
    LDR r6, =24000
    delay_loop:
        SUB r6, r6, #1
        cmp r6, #0
        BNE delay_loop
    B loop


main:
    LDR R0, =RCGC_GPIO_R
    LDR r1, [r0]
    MOV r3, #PIN5
    ORR r1, r1, r3
    STR r1, [r0]

    // rote LED konfigurieren
    LDR r0, =GPIO_PORT_F_DIR_R
    LDR r1, [r0]
    MOV r3, #LED_RED
    ORR r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_PUR_R
    LDR r1, [r0]
    MOV r3, #LED_RED
    BIC r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_DEN_R
    LDR r1, [r0]
    MOV r3, #LED_RED
    ORR r1, r1, r3
    STR r1, [r0]


    // grüne LED Konfigurieren
    LDR r0, =GPIO_PORT_F_DIR_R
    LDR r1, [r0]
    MOV r3, #LED_GREEN
    ORR r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_PUR_R
    LDR r1, [r0]
    MOV r3, #LED_GREEN
    BIC r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_DEN_R
    LDR r1, [r0]
    MOV r3, #LED_GREEN
    ORR r1, r1, r3
    STR r1, [r0]

    // Button konfigurieren
    LDR r0, =GPIO_PORT_F_DIR_R
    LDR r1, [r0]
    MOV r3, #BUTTON
    BIC r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_PUR_R
    LDR r1, [r0]
    MOV r3, #BUTTON
    ORR r1, r1, r3
    STR r1, [r0]

    LDR r0, =GPIO_PORT_F_DEN_R
    LDR r1, [r0]
    MOV r3, #BUTTON
    ORR r1, r1, r3
    STR r1, [r0]


    ldr r7, =1



loop:
    LDR r0, =GPIO_PORT_F_DATA_R
    LDR r1, [r0]
    LDR r2, =BUTTON
    AND r1, r1, r2
    CMP r1, r2

    BEQ nicht_betätigt
    BNE betätigt
    B delay
    B loop

//setzt r7 auf den maximalen Wert
setmaximum:
    ldr r7, =0x80000000
    B delay

//setzt r7 auf den minimalen Wert
setminimum:
    ldr r7, =1
    B delay


// Funktion mit bl und und dann zurück mit bx
// Switch case mit mehreren Vergleichen und eigenen Sprungmarken