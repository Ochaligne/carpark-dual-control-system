
/***Variables declaration****************************************/
int arr1[4]={5,6,10,9};               //array to set the numbers for supplying voltage to four coils
int i=0;                                //loop counter for the arrays
int oldstate_C0=0;                      // Change of state variable for Ticket In
int oldstate_C1=0;                      // Change of state variable for Paid
int counter;
int oldstate_sens1=0;                       // Change of state variable for Sens1
int oldstate_sens4=0;                       // Change of state variable for Sens4
int oldstate_help=0;
char txt2[16] = "";
// Variables for traffic lights
#define stop_IN PORTC.B4                          //Lights variables stop in
#define stop_OUT PORTC.B6                         //Lights variables stop out
#define go_IN PORTC.B5                            //Lights variables  go in
#define go_OUT PORTC.B7                            //Lights variables go out
//Variables for sensors
#define sens2 PORTD.B0
#define sens4 PORTD.B1
#define sens3 PORTD.B2
#define sens1 PORTD.B3
#define barrier_open PORTD.B7
#define barrier_closed PORTD.B5
#define Help_In PORTC.B2
#define Help_Out PORTC.B3
// LCD module connections
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
// End LCD module connections

/***Functions declaration for barrier motor operation*****************/
void Motor_down(){
     do {
          if (i>3)
          i=0;
          PORTA = arr1[i];               // sequence {5,6,10,9}
          Delay_ms(10);
          //above configures the time interval of supplying voltage between adjacent coils
          i++;
          }while(barrier_closed !=1);
     }
void Motor_up(){
     do {
        if(i<0)
        i=3;
        PORTA = arr1[i];               // sequence{9,10,6,5}
        Delay_ms(10);               //the shorter of this interval, the faster the motor rotates
        //above configures the time interval of supplying voltage between adjacent coils
        i--;
        }while(barrier_open !=1);
}
/****************************************end of Motor function*******/

void LCD_ticket(){
// Ticket In triggered: Ticket print sequence
      Lcd_Cmd(_LCD_CLEAR);               // Clear display
      Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
      Lcd_Out(1,1,"Printing ticket,");
      }
      
void LCD_drive(){
// Ticket In triggered: Ticket print sequence
      Lcd_Cmd(_LCD_CLEAR);               // Clear display
      Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
      Lcd_Out(2,1,"Drive through");
      }
    
void LCD_exit(){
// Paid triggered: Thank you and goodbye sequence
      Lcd_Cmd(_LCD_CLEAR);               // Clear display
      Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
      Lcd_Out(1,1,"Thank you,");
      Lcd_Out(2,1,"Goodbye");
      }


void LCD_state(){
     Lcd_Cmd(_LCD_CLEAR);               // Clear display
     Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
     IntToStr(counter, txt2);           // conversion integer to string
     Lcd_Out(1,1,"Available spaces:");
     Lcd_Out(2,8,txt2);
     }
         
void LCD_welcome(){
       Lcd_Cmd(_LCD_CLEAR);               // Clear display
       Lcd_Out(1,1,"Welcome to ");
       Lcd_Out(2,1,"CarPark.");
       Delay_ms(1000);
       LCD_state();
       }

void LCD_nospace(){
       Lcd_Cmd(_LCD_CLEAR);               // Clear display
       Lcd_Out(1,1,"Carpark Full");
       Lcd_Out(2,1,"Please Exit");
       Delay_ms(1000);
       LCD_state();
       }
void LCD_help(){
       Lcd_Cmd(_LCD_CLEAR);               // Clear display
       Lcd_Out(1,1,"Help is on ");
       Lcd_Out(2,1,"the way");
       Delay_ms(1000);
       }
/****************************************end of LCD functions********/
/***Functions declaration for Traffic Light operation***************/
void Lights_in(){
      stop_IN = 1;
      go_IN = 0;
      stop_OUT = 0;
      go_OUT = 1;
     }
void Lights_out(){
       stop_IN = 0;
       go_IN = 1;
       stop_OUT = 1;
       go_OUT = 0;
     }
void Lights_stop(){
     stop_IN = 0;
     go_IN = 1;
     stop_OUT = 0;
     go_OUT = 1;
     }
/***Main Function***************************************************/
void main() {
  ANSEL = 0;                                //configure all ports as digital
  ANSELH = 0;

  TRISA = 0;                               //configure PORTA as output
  TRISB = 0;                               //configure PORTB as output
  TRISD = 0x01;                            //configure PORTD as input

  TRISC.B0 = 1;                          //configure RC0 as input
  TRISC.B1 = 1;                          //configure RC1 as input
  TRISD.B7 = 1;                          //configure RD7 as input
  TRISD.B0 = 1;                          //configure RD0 as input
  TRISD.B3 = 1;                          //configure RD3 as input
  TRISD.B2 = 1;                          //configure RD2 as input
  TRISD.B5 = 1;                          //configure RD5 as input
  TRISD.B1 = 1;                          //configure RD1 as input
  
  // Lights bit configurator as outputs
  TRISC.B4 = 0;                          //configure RC4 as output
  TRISC.B5 = 0;                          //configure RC5 as output
  TRISC.B6 = 0;                          //configure RC6 as output
  TRISC.B7 = 0;                          //configure RC7 as output
  // Initialise Lights All RED no GREEN
  stop_IN = 0;
  go_IN = 1;
  stop_OUT = 0;
  go_OUT = 1;
  
  PORTA = 0x00;                              //initialise PORTA
  PORTB = 0x00;                              //initialise PORTB
  C1ON_bit = 0;                                  // Disable comparators
  C2ON_bit = 0;

  // LCD initialisation
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  LCD_welcome();
  counter = EEPROM_Read(0x60);
do{
//Ticket In triggered call Motor_up
      if(Button(&PORTC,0,1,0)) {
          oldstate_C0 = 1;
          }
      if(oldstate_C0 && Button(&PORTC,0,1,1)&& counter !=0 && barrier_closed !=0){
          oldstate_C0 = 0;
          LCD_ticket();
          Motor_up();
          Lights_in();
          LCD_drive();
          }
      else if (counter==0){
          Lcd_Cmd(_LCD_CLEAR);               // Clear display
          Lcd_Out(1,1,"Carpark Full");
          Lcd_Out(2,1,"Please Exit");
          Delay_ms(200);
          LCD_state();
          }
// If Sens 1,2,3 or 4 triggered then Lights all red.
   if(sens1 || sens2 || sens3 || sens4){
          Lights_stop();
          }
//Paid triggered call Mortor_up
      if(Button(&PORTC,1,1,0)) {
          oldstate_C1 = 1;
          }
      if(oldstate_C1 && Button(&PORTC,1,1,1) && barrier_closed!=0){
          oldstate_C1 = 0;
          LCD_exit();
          Motor_up();
          Lights_out();
          LCD_drive();
          }

//SENS1 triggered call Motor_down and substract 1 to counter
      if(sens1){
         oldstate_sens1 = 1;
         }
      if(oldstate_sens1 && sens1==0){
         oldstate_sens1 = 0;
         counter = counter - 1;
         Delay_ms(20);
         Motor_down();
         LCD_state();
         Delay_ms(1000);
         LCD_welcome();
         }
//SENS4 triggered call Motor_down and add 1 to counter
      if(sens4){
         oldstate_sens4 = 1;
         }
      if(oldstate_sens4 && sens4==0 && barrier_closed !=1){
         oldstate_sens4 =0;
         counter = counter + 1;
         Delay_ms(20);
         Motor_down();
         LCD_state();
         Delay_ms(1000);
         LCD_welcome();
         }
//Help In and Out
      if(Help_In){
         oldstate_help = 1;
         }
      if(Help_In==0 && oldstate_help){
         oldstate_help = 0;
         LCD_help();
         }

      if(Help_Out){
         oldstate_help = 1;
         }
      if(Help_Out==0 && oldstate_help){
         oldstate_help = 0;
         LCD_help();
         }
EEPROM_Write(0x60,counter);
Delay_Ms(20);
}while(1);

}
