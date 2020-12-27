#line 1 "//napier-mail.napier.ac.uk/students/School of Engineering and the Built Environment/User Data/40292302/ELE09104 - EE Applications/Coursework/Coursework Micro NEW/Coursework Micro NEW/Carpark.c"


int arr1[4]={5,6,10,9};
int i=0;
int oldstate_C0=0;
int oldstate_C1=0;
int counter;
int oldstate_sens1=0;
int oldstate_sens4=0;
int oldstate_help=0;
char txt2[16] = "";
#line 27 "//napier-mail.napier.ac.uk/students/School of Engineering and the Built Environment/User Data/40292302/ELE09104 - EE Applications/Coursework/Coursework Micro NEW/Coursework Micro NEW/Carpark.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;



void Motor_down(){
 do {
 if (i>3)
 i=0;
 PORTA = arr1[i];
 Delay_ms(10);

 i++;
 }while( PORTD.B5  !=1);
 }
void Motor_up(){
 do {
 if(i<0)
 i=3;
 PORTA = arr1[i];
 Delay_ms(10);

 i--;
 }while( PORTD.B7  !=1);
}


void LCD_ticket(){

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Printing ticket,");
 }

void LCD_drive(){

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(2,1,"Drive through");
 }

void LCD_exit(){

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Thank you,");
 Lcd_Out(2,1,"Goodbye");
 }


void LCD_state(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 IntToStr(counter, txt2);
 Lcd_Out(1,1,"Available spaces:");
 Lcd_Out(2,8,txt2);
 }

void LCD_welcome(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Welcome to ");
 Lcd_Out(2,1,"CarPark.");
 Delay_ms(1000);
 LCD_state();
 }

void LCD_nospace(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Carpark Full");
 Lcd_Out(2,1,"Please Exit");
 Delay_ms(1000);
 LCD_state();
 }
void LCD_help(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Help is on ");
 Lcd_Out(2,1,"the way");
 Delay_ms(1000);
 }


void Lights_in(){
  PORTC.B4  = 1;
  PORTC.B5  = 0;
  PORTC.B6  = 0;
  PORTC.B7  = 1;
 }
void Lights_out(){
  PORTC.B4  = 0;
  PORTC.B5  = 1;
  PORTC.B6  = 1;
  PORTC.B7  = 0;
 }
void Lights_stop(){
  PORTC.B4  = 0;
  PORTC.B5  = 1;
  PORTC.B6  = 0;
  PORTC.B7  = 1;
 }

void main() {
 ANSEL = 0;
 ANSELH = 0;

 TRISA = 0;
 TRISB = 0;
 TRISD = 0x01;

 TRISC.B0 = 1;
 TRISC.B1 = 1;
 TRISD.B7 = 1;
 TRISD.B0 = 1;
 TRISD.B3 = 1;
 TRISD.B2 = 1;
 TRISD.B5 = 1;
 TRISD.B1 = 1;


 TRISC.B4 = 0;
 TRISC.B5 = 0;
 TRISC.B6 = 0;
 TRISC.B7 = 0;

  PORTC.B4  = 0;
  PORTC.B5  = 1;
  PORTC.B6  = 0;
  PORTC.B7  = 1;

 PORTA = 0x00;
 PORTB = 0x00;
 C1ON_bit = 0;
 C2ON_bit = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 LCD_welcome();
 counter = EEPROM_Read(0x60);
do{

 if(Button(&PORTC,0,1,0)) {
 oldstate_C0 = 1;
 }
 if(oldstate_C0 && Button(&PORTC,0,1,1)&& counter !=0 &&  PORTD.B5  !=0){
 oldstate_C0 = 0;
 LCD_ticket();
 Motor_up();
 Lights_in();
 LCD_drive();
 }
 else if (counter==0){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Carpark Full");
 Lcd_Out(2,1,"Please Exit");
 Delay_ms(200);
 LCD_state();
 }

 if( PORTD.B3  ||  PORTD.B0  ||  PORTD.B2  ||  PORTD.B1 ){
 Lights_stop();
 }

 if(Button(&PORTC,1,1,0)) {
 oldstate_C1 = 1;
 }
 if(oldstate_C1 && Button(&PORTC,1,1,1) &&  PORTD.B5 !=0){
 oldstate_C1 = 0;
 LCD_exit();
 Motor_up();
 Lights_out();
 LCD_drive();
 }


 if( PORTD.B3 ){
 oldstate_sens1 = 1;
 }
 if(oldstate_sens1 &&  PORTD.B3 ==0){
 oldstate_sens1 = 0;
 counter = counter - 1;
 Delay_ms(20);
 Motor_down();
 LCD_state();
 Delay_ms(1000);
 LCD_welcome();
 }

 if( PORTD.B1 ){
 oldstate_sens4 = 1;
 }
 if(oldstate_sens4 &&  PORTD.B1 ==0 &&  PORTD.B5  !=1){
 oldstate_sens4 =0;
 counter = counter + 1;
 Delay_ms(20);
 Motor_down();
 LCD_state();
 Delay_ms(1000);
 LCD_welcome();
 }

 if( PORTC.B2 ){
 oldstate_help = 1;
 }
 if( PORTC.B2 ==0 && oldstate_help){
 oldstate_help = 0;
 LCD_help();
 }

 if( PORTC.B3 ){
 oldstate_help = 1;
 }
 if( PORTC.B3 ==0 && oldstate_help){
 oldstate_help = 0;
 LCD_help();
 }
EEPROM_Write(0x60,counter);
Delay_Ms(20);
}while(1);

}
