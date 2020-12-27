
_Motor_down:

;Carpark.c,43 :: 		void Motor_down(){
;Carpark.c,44 :: 		do {
L_Motor_down0:
;Carpark.c,45 :: 		if (i>3)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Motor_down59
	MOVF       _i+0, 0
	SUBLW      3
L__Motor_down59:
	BTFSC      STATUS+0, 0
	GOTO       L_Motor_down3
;Carpark.c,46 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
L_Motor_down3:
;Carpark.c,47 :: 		PORTA = arr1[i];               // sequence {5,6,10,9}
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Carpark.c,48 :: 		Delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_Motor_down4:
	DECFSZ     R13+0, 1
	GOTO       L_Motor_down4
	DECFSZ     R12+0, 1
	GOTO       L_Motor_down4
	NOP
;Carpark.c,50 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Carpark.c,51 :: 		}while(barrier_closed !=1);
	BTFSS      PORTD+0, 5
	GOTO       L_Motor_down0
;Carpark.c,52 :: 		}
L_end_Motor_down:
	RETURN
; end of _Motor_down

_Motor_up:

;Carpark.c,53 :: 		void Motor_up(){
;Carpark.c,54 :: 		do {
L_Motor_up5:
;Carpark.c,55 :: 		if(i<0)
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Motor_up61
	MOVLW      0
	SUBWF      _i+0, 0
L__Motor_up61:
	BTFSC      STATUS+0, 0
	GOTO       L_Motor_up8
;Carpark.c,56 :: 		i=3;
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_Motor_up8:
;Carpark.c,57 :: 		PORTA = arr1[i];               // sequence{9,10,6,5}
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Carpark.c,58 :: 		Delay_ms(10);               //the shorter of this interval, the faster the motor rotates
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_Motor_up9:
	DECFSZ     R13+0, 1
	GOTO       L_Motor_up9
	DECFSZ     R12+0, 1
	GOTO       L_Motor_up9
	NOP
;Carpark.c,60 :: 		i--;
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Carpark.c,61 :: 		}while(barrier_open !=1);
	BTFSS      PORTD+0, 7
	GOTO       L_Motor_up5
;Carpark.c,62 :: 		}
L_end_Motor_up:
	RETURN
; end of _Motor_up

_LCD_ticket:

;Carpark.c,65 :: 		void LCD_ticket(){
;Carpark.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,69 :: 		Lcd_Out(1,1,"Printing ticket,");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,70 :: 		}
L_end_LCD_ticket:
	RETURN
; end of _LCD_ticket

_LCD_drive:

;Carpark.c,72 :: 		void LCD_drive(){
;Carpark.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,76 :: 		Lcd_Out(2,1,"Drive through");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,77 :: 		}
L_end_LCD_drive:
	RETURN
; end of _LCD_drive

_LCD_exit:

;Carpark.c,79 :: 		void LCD_exit(){
;Carpark.c,81 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,82 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,83 :: 		Lcd_Out(1,1,"Thank you,");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,84 :: 		Lcd_Out(2,1,"Goodbye");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,85 :: 		}
L_end_LCD_exit:
	RETURN
; end of _LCD_exit

_LCD_state:

;Carpark.c,88 :: 		void LCD_state(){
;Carpark.c,89 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,90 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,91 :: 		IntToStr(counter, txt2);           // conversion integer to string
	MOVF       _counter+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _counter+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt2+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Carpark.c,92 :: 		Lcd_Out(1,1,"Available spaces:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,93 :: 		Lcd_Out(2,8,txt2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,94 :: 		}
L_end_LCD_state:
	RETURN
; end of _LCD_state

_LCD_welcome:

;Carpark.c,96 :: 		void LCD_welcome(){
;Carpark.c,97 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,98 :: 		Lcd_Out(1,1,"Welcome to ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,99 :: 		Lcd_Out(2,1,"CarPark.");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,100 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_LCD_welcome10:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_welcome10
	DECFSZ     R12+0, 1
	GOTO       L_LCD_welcome10
	DECFSZ     R11+0, 1
	GOTO       L_LCD_welcome10
	NOP
	NOP
;Carpark.c,101 :: 		LCD_state();
	CALL       _LCD_state+0
;Carpark.c,102 :: 		}
L_end_LCD_welcome:
	RETURN
; end of _LCD_welcome

_LCD_nospace:

;Carpark.c,104 :: 		void LCD_nospace(){
;Carpark.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,106 :: 		Lcd_Out(1,1,"Carpark Full");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,107 :: 		Lcd_Out(2,1,"Please Exit");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,108 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_LCD_nospace11:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_nospace11
	DECFSZ     R12+0, 1
	GOTO       L_LCD_nospace11
	DECFSZ     R11+0, 1
	GOTO       L_LCD_nospace11
	NOP
	NOP
;Carpark.c,109 :: 		LCD_state();
	CALL       _LCD_state+0
;Carpark.c,110 :: 		}
L_end_LCD_nospace:
	RETURN
; end of _LCD_nospace

_LCD_help:

;Carpark.c,111 :: 		void LCD_help(){
;Carpark.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,113 :: 		Lcd_Out(1,1,"Help is on ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,114 :: 		Lcd_Out(2,1,"the way");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,115 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_LCD_help12:
	DECFSZ     R13+0, 1
	GOTO       L_LCD_help12
	DECFSZ     R12+0, 1
	GOTO       L_LCD_help12
	DECFSZ     R11+0, 1
	GOTO       L_LCD_help12
	NOP
	NOP
;Carpark.c,116 :: 		}
L_end_LCD_help:
	RETURN
; end of _LCD_help

_Lights_in:

;Carpark.c,119 :: 		void Lights_in(){
;Carpark.c,120 :: 		stop_IN = 1;
	BSF        PORTC+0, 4
;Carpark.c,121 :: 		go_IN = 0;
	BCF        PORTC+0, 5
;Carpark.c,122 :: 		stop_OUT = 0;
	BCF        PORTC+0, 6
;Carpark.c,123 :: 		go_OUT = 1;
	BSF        PORTC+0, 7
;Carpark.c,124 :: 		}
L_end_Lights_in:
	RETURN
; end of _Lights_in

_Lights_out:

;Carpark.c,125 :: 		void Lights_out(){
;Carpark.c,126 :: 		stop_IN = 0;
	BCF        PORTC+0, 4
;Carpark.c,127 :: 		go_IN = 1;
	BSF        PORTC+0, 5
;Carpark.c,128 :: 		stop_OUT = 1;
	BSF        PORTC+0, 6
;Carpark.c,129 :: 		go_OUT = 0;
	BCF        PORTC+0, 7
;Carpark.c,130 :: 		}
L_end_Lights_out:
	RETURN
; end of _Lights_out

_Lights_stop:

;Carpark.c,131 :: 		void Lights_stop(){
;Carpark.c,132 :: 		stop_IN = 0;
	BCF        PORTC+0, 4
;Carpark.c,133 :: 		go_IN = 1;
	BSF        PORTC+0, 5
;Carpark.c,134 :: 		stop_OUT = 0;
	BCF        PORTC+0, 6
;Carpark.c,135 :: 		go_OUT = 1;
	BSF        PORTC+0, 7
;Carpark.c,136 :: 		}
L_end_Lights_stop:
	RETURN
; end of _Lights_stop

_main:

;Carpark.c,138 :: 		void main() {
;Carpark.c,139 :: 		ANSEL = 0;                                //configure all ports as digital
	CLRF       ANSEL+0
;Carpark.c,140 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Carpark.c,142 :: 		TRISA = 0;                               //configure PORTA as output
	CLRF       TRISA+0
;Carpark.c,143 :: 		TRISB = 0;                               //configure PORTB as output
	CLRF       TRISB+0
;Carpark.c,144 :: 		TRISD = 0x01;                            //configure PORTD as input
	MOVLW      1
	MOVWF      TRISD+0
;Carpark.c,146 :: 		TRISC.B0 = 1;                          //configure RC0 as input
	BSF        TRISC+0, 0
;Carpark.c,147 :: 		TRISC.B1 = 1;                          //configure RC1 as input
	BSF        TRISC+0, 1
;Carpark.c,148 :: 		TRISD.B7 = 1;                          //configure RD7 as input
	BSF        TRISD+0, 7
;Carpark.c,149 :: 		TRISD.B0 = 1;                          //configure RD0 as input
	BSF        TRISD+0, 0
;Carpark.c,150 :: 		TRISD.B3 = 1;                          //configure RD3 as input
	BSF        TRISD+0, 3
;Carpark.c,151 :: 		TRISD.B2 = 1;                          //configure RD2 as input
	BSF        TRISD+0, 2
;Carpark.c,152 :: 		TRISD.B5 = 1;                          //configure RD5 as input
	BSF        TRISD+0, 5
;Carpark.c,153 :: 		TRISD.B1 = 1;                          //configure RD1 as input
	BSF        TRISD+0, 1
;Carpark.c,156 :: 		TRISC.B4 = 0;                          //configure RC4 as output
	BCF        TRISC+0, 4
;Carpark.c,157 :: 		TRISC.B5 = 0;                          //configure RC5 as output
	BCF        TRISC+0, 5
;Carpark.c,158 :: 		TRISC.B6 = 0;                          //configure RC6 as output
	BCF        TRISC+0, 6
;Carpark.c,159 :: 		TRISC.B7 = 0;                          //configure RC7 as output
	BCF        TRISC+0, 7
;Carpark.c,161 :: 		stop_IN = 0;
	BCF        PORTC+0, 4
;Carpark.c,162 :: 		go_IN = 1;
	BSF        PORTC+0, 5
;Carpark.c,163 :: 		stop_OUT = 0;
	BCF        PORTC+0, 6
;Carpark.c,164 :: 		go_OUT = 1;
	BSF        PORTC+0, 7
;Carpark.c,166 :: 		PORTA = 0x00;                              //initialise PORTA
	CLRF       PORTA+0
;Carpark.c,167 :: 		PORTB = 0x00;                              //initialise PORTB
	CLRF       PORTB+0
;Carpark.c,168 :: 		C1ON_bit = 0;                                  // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Carpark.c,169 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Carpark.c,172 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Carpark.c,173 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,174 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,175 :: 		LCD_welcome();
	CALL       _LCD_welcome+0
;Carpark.c,176 :: 		counter = EEPROM_Read(0x60);
	MOVLW      96
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _counter+0
	CLRF       _counter+1
;Carpark.c,177 :: 		do{
L_main13:
;Carpark.c,179 :: 		if(Button(&PORTC,0,1,0)) {
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main16
;Carpark.c,180 :: 		oldstate_C0 = 1;
	MOVLW      1
	MOVWF      _oldstate_C0+0
	MOVLW      0
	MOVWF      _oldstate_C0+1
;Carpark.c,181 :: 		}
L_main16:
;Carpark.c,182 :: 		if(oldstate_C0 && Button(&PORTC,0,1,1)&& counter !=0 && barrier_closed !=0){
	MOVF       _oldstate_C0+0, 0
	IORWF      _oldstate_C0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      0
	XORWF      _counter+0, 0
L__main73:
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	BTFSS      PORTD+0, 5
	GOTO       L_main19
L__main57:
;Carpark.c,183 :: 		oldstate_C0 = 0;
	CLRF       _oldstate_C0+0
	CLRF       _oldstate_C0+1
;Carpark.c,184 :: 		LCD_ticket();
	CALL       _LCD_ticket+0
;Carpark.c,185 :: 		Motor_up();
	CALL       _Motor_up+0
;Carpark.c,186 :: 		Lights_in();
	CALL       _Lights_in+0
;Carpark.c,187 :: 		LCD_drive();
	CALL       _LCD_drive+0
;Carpark.c,188 :: 		}
	GOTO       L_main20
L_main19:
;Carpark.c,189 :: 		else if (counter==0){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      0
	XORWF      _counter+0, 0
L__main74:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;Carpark.c,190 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Carpark.c,191 :: 		Lcd_Out(1,1,"Carpark Full");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,192 :: 		Lcd_Out(2,1,"Please Exit");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_Carpark+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Carpark.c,193 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
;Carpark.c,194 :: 		LCD_state();
	CALL       _LCD_state+0
;Carpark.c,195 :: 		}
L_main21:
L_main20:
;Carpark.c,197 :: 		if(sens1 || sens2 || sens3 || sens4){
	BTFSC      PORTD+0, 3
	GOTO       L__main56
	BTFSC      PORTD+0, 0
	GOTO       L__main56
	BTFSC      PORTD+0, 2
	GOTO       L__main56
	BTFSC      PORTD+0, 1
	GOTO       L__main56
	GOTO       L_main25
L__main56:
;Carpark.c,198 :: 		Lights_stop();
	CALL       _Lights_stop+0
;Carpark.c,199 :: 		}
L_main25:
;Carpark.c,201 :: 		if(Button(&PORTC,1,1,0)) {
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
;Carpark.c,202 :: 		oldstate_C1 = 1;
	MOVLW      1
	MOVWF      _oldstate_C1+0
	MOVLW      0
	MOVWF      _oldstate_C1+1
;Carpark.c,203 :: 		}
L_main26:
;Carpark.c,204 :: 		if(oldstate_C1 && Button(&PORTC,1,1,1) && barrier_closed!=0){
	MOVF       _oldstate_C1+0, 0
	IORWF      _oldstate_C1+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	BTFSS      PORTD+0, 5
	GOTO       L_main29
L__main55:
;Carpark.c,205 :: 		oldstate_C1 = 0;
	CLRF       _oldstate_C1+0
	CLRF       _oldstate_C1+1
;Carpark.c,206 :: 		LCD_exit();
	CALL       _LCD_exit+0
;Carpark.c,207 :: 		Motor_up();
	CALL       _Motor_up+0
;Carpark.c,208 :: 		Lights_out();
	CALL       _Lights_out+0
;Carpark.c,209 :: 		LCD_drive();
	CALL       _LCD_drive+0
;Carpark.c,210 :: 		}
L_main29:
;Carpark.c,213 :: 		if(sens1){
	BTFSS      PORTD+0, 3
	GOTO       L_main30
;Carpark.c,214 :: 		oldstate_sens1 = 1;
	MOVLW      1
	MOVWF      _oldstate_sens1+0
	MOVLW      0
	MOVWF      _oldstate_sens1+1
;Carpark.c,215 :: 		}
L_main30:
;Carpark.c,216 :: 		if(oldstate_sens1 && sens1==0){
	MOVF       _oldstate_sens1+0, 0
	IORWF      _oldstate_sens1+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	BTFSC      PORTD+0, 3
	GOTO       L_main33
L__main54:
;Carpark.c,217 :: 		oldstate_sens1 = 0;
	CLRF       _oldstate_sens1+0
	CLRF       _oldstate_sens1+1
;Carpark.c,218 :: 		counter = counter - 1;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;Carpark.c,219 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	NOP
	NOP
;Carpark.c,220 :: 		Motor_down();
	CALL       _Motor_down+0
;Carpark.c,221 :: 		LCD_state();
	CALL       _LCD_state+0
;Carpark.c,222 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;Carpark.c,223 :: 		LCD_welcome();
	CALL       _LCD_welcome+0
;Carpark.c,224 :: 		}
L_main33:
;Carpark.c,226 :: 		if(sens4){
	BTFSS      PORTD+0, 1
	GOTO       L_main36
;Carpark.c,227 :: 		oldstate_sens4 = 1;
	MOVLW      1
	MOVWF      _oldstate_sens4+0
	MOVLW      0
	MOVWF      _oldstate_sens4+1
;Carpark.c,228 :: 		}
L_main36:
;Carpark.c,229 :: 		if(oldstate_sens4 && sens4==0 && barrier_closed !=1){
	MOVF       _oldstate_sens4+0, 0
	IORWF      _oldstate_sens4+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	BTFSC      PORTD+0, 1
	GOTO       L_main39
	BTFSC      PORTD+0, 5
	GOTO       L_main39
L__main53:
;Carpark.c,230 :: 		oldstate_sens4 =0;
	CLRF       _oldstate_sens4+0
	CLRF       _oldstate_sens4+1
;Carpark.c,231 :: 		counter = counter + 1;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Carpark.c,232 :: 		Delay_ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
	NOP
;Carpark.c,233 :: 		Motor_down();
	CALL       _Motor_down+0
;Carpark.c,234 :: 		LCD_state();
	CALL       _LCD_state+0
;Carpark.c,235 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;Carpark.c,236 :: 		LCD_welcome();
	CALL       _LCD_welcome+0
;Carpark.c,237 :: 		}
L_main39:
;Carpark.c,239 :: 		if(Help_In){
	BTFSS      PORTC+0, 2
	GOTO       L_main42
;Carpark.c,240 :: 		oldstate_help = 1;
	MOVLW      1
	MOVWF      _oldstate_help+0
	MOVLW      0
	MOVWF      _oldstate_help+1
;Carpark.c,241 :: 		}
L_main42:
;Carpark.c,242 :: 		if(Help_In==0 && oldstate_help){
	BTFSC      PORTC+0, 2
	GOTO       L_main45
	MOVF       _oldstate_help+0, 0
	IORWF      _oldstate_help+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
L__main52:
;Carpark.c,243 :: 		oldstate_help = 0;
	CLRF       _oldstate_help+0
	CLRF       _oldstate_help+1
;Carpark.c,244 :: 		LCD_help();
	CALL       _LCD_help+0
;Carpark.c,245 :: 		}
L_main45:
;Carpark.c,247 :: 		if(Help_Out){
	BTFSS      PORTC+0, 3
	GOTO       L_main46
;Carpark.c,248 :: 		oldstate_help = 1;
	MOVLW      1
	MOVWF      _oldstate_help+0
	MOVLW      0
	MOVWF      _oldstate_help+1
;Carpark.c,249 :: 		}
L_main46:
;Carpark.c,250 :: 		if(Help_Out==0 && oldstate_help){
	BTFSC      PORTC+0, 3
	GOTO       L_main49
	MOVF       _oldstate_help+0, 0
	IORWF      _oldstate_help+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main49
L__main51:
;Carpark.c,251 :: 		oldstate_help = 0;
	CLRF       _oldstate_help+0
	CLRF       _oldstate_help+1
;Carpark.c,252 :: 		LCD_help();
	CALL       _LCD_help+0
;Carpark.c,253 :: 		}
L_main49:
;Carpark.c,254 :: 		EEPROM_Write(0x60,counter);
	MOVLW      96
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _counter+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Carpark.c,255 :: 		Delay_Ms(20);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main50:
	DECFSZ     R13+0, 1
	GOTO       L_main50
	DECFSZ     R12+0, 1
	GOTO       L_main50
	NOP
	NOP
;Carpark.c,256 :: 		}while(1);
	GOTO       L_main13
;Carpark.c,258 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
