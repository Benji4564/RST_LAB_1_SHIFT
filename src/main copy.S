.section .data
.equ 
.equ RCGC_GPIO_R, 0x400FE000 ; direktive ~Konstante,  kommt aus dem Datenblatt
.equ RCGC_GPIO_PORT_A, 0x01
.equ RCGC_GPIO_PORT_B, 0x02
.equ RCGC_GPIO_PORT_C, 0x04
.equ RCGC_GPIO_PORT_D, 0x08
.equ RCGC_GPIO_PORT_E, 0x10
.equ RCGC_GPIO_PORT_F, 0x20
.equ GPIO_PORT_F_DIR_R, 0x400025400
.equ GPIO_PORT_F_DATA, 0x400025400; anderer Wert

.equ PIN0, 0x01
.equ PIN1, 0x02
.equ PIN2, 0x04
.equ PIN3, 0x08
.equ PIN4, 0x10
.equ PIN5, 0x20
.equ PIN6, 0x40
.equ PIN7, 0x80
.equ ALL_PINS, 0xFF

.section .text
.global main
.align

main:   
    LDR r0, =RCGC_GPIO_R; in das r0 den Inhalt us RCG..laden. in r0 steht die Adresse
    LDR r1, [r0]; eckige Klammern=Inhalt von r0
    MOV r3, #PIN5; Combiler mag Konstante #PIN5 nicht
    ORR r2, r1, r3; speicher in r2 bitweises "oder" von r1 und r3
    STR r1, [r0]; speicher dem Inhalt von r1 in r0 

    LDR r0, =GPIO_PORT_F_DIR_R; in das r0 den Inhalt us RCG..laden. in r0 steht die Adresse
    LDR r1, [r0]; eckige Klammern=Inhalt von r0
    MOV r3, #PIN1; Combiler mag Konstante #PIN5 nicht
    ORR r2, r1, r3; speicher in r2 bitweises "oder" von r1 und r3
    STR r1, [r0]; speicher dem Inhalt von r1 in r0 ^


    LDR r0, =GPIO_PORT_F_DATA; in das r0 den Inhalt us RCG..laden. in r0 steht die Adresse
    LDR r1, [r0]; eckige Klammern=Inhalt von r0
    MOV r3, #PIN1; Combiler mag Konstante #PIN5 nicht
    ORR r2, r1, r3; speicher in r2 bitweises "oder" von r1 und r3
    STR r1, [r0]; speicher dem Inhalt von r1 in r0


    BEQ ziel; zum Ziel springen wenn ein flag gesetzt wurde

    BIC; Wieder einen Wert auf 0 setzen








ziel:



;code here schreiben
.end
