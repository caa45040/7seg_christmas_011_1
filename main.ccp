#include <Arduino.h>

#define sdi1 PA8
#define sck1 PA12
#define latch1 PA0
#define DW   digitalWrite
#define in7 PB7

char seg[32][8] = {
 { 1,1,1,1,1,1,1,1 }, //0 @ -> ' '
 { 0,0,0,0,0,1,0,1 }, //1 A  o
 { 1,1,0,0,0,0,0,1 }, //2 B     　combined use "6"
 { 0,1,0,1,0,0,1,1 }, //3 C
 { 1,0,1,0,0,0,0,1 }, //4 D
 { 0,1,0,0,0,0,1,1 }, //5 E  o
 { 0,1,0,0,0,1,1,1 }, //6 F
 { 0,1,0,1,0,0,0,1 }, //7 G
 
 { 1,0,0,0,0,1,0,1 }, //8 H  o
 { 1,0,1,1,1,1,0,1 }, //9 I    　combined use "1"
 { 1,0,1,1,0,0,0,1 }, //10 J
 { 0,1,0,0,0,1,0,1 }, //11 K 
 { 1,1,0,1,0,0,1,1 }, //12 L  o
 { 0,1,1,1,0,1,0,1 }, //13 M
 { 0,0,0,1,0,1,0,1 }, //14 N  o
 { 0,0,0,1,0,0,0,1 }, //15 O  o　combined use "0"
 
 { 0,0,0,0,0,1,1,1 }, //16 P
 { 0,0,0,0,1,1,0,1 }, //17 Q　combined use "9"
 { 1,1,1,0,0,1,1,1 }, //18 R
 { 0,1,0,0,1,0,0,1 }, //19 S　combined use "5"
 { 1,1,0,0,0,0,1,1 }, //20 T
 { 1,0,0,1,0,0,0,1 }, //21 U
 { 1,1,1,1,0,0,0,1 }, //22 V
 { 1,0,0,1,1,0,1,1 }, //23 W  o
 { 1,1,0,0,1,1,0,1 }, //24 X
 
 { 1,0,0,0,1,0,0,1 }, //25 Y
 { 0,0,1,0,0,0,1,1 }, //26 Z　combined use "2"
 { 0,0,1,0,1,0,0,1 }, //27 [  --> "3"
 { 1,0,0,0,1,1,0,1 }, //28 \  --> "4"
 { 0,0,0,1,1,1,0,1 }, //29 ]  --> "7"
 { 0,0,0,0,0,0,0,1 }, //26 ^  --> "8"
 { 1,1,1,1,1,0,1,1 }  //31 _
};

void setup() {

    pinMode(sdi1,OUTPUT);
    pinMode(sck1,OUTPUT);
    pinMode(in7,INPUT_PULLUP);

    DW(sdi1,0);
    for(int i=0;i<10;i++){
        DW(sck1,1);
        delay(15);
        DW(sck1,0);
        delay(15);
    }

    pinMode(latch1,OUTPUT);
    delay(15);
    DW(latch1,0);
    delay(15);
    DW(latch1,1);
    delay(15);
    DW(latch1,0);
    delay(15);
}

int a;
int b;
int c;
int d;
//int e;
int f;

void loop() {

    DW(latch1,1);delay(500);DW(latch1,0);delay(500);
    DW(latch1,1);delay(500);DW(latch1,0);delay(500);
    DW(latch1,1);delay(500);DW(latch1,0);delay(500);

    //int i = 0;
    int s = 3;

    DW(sdi1,!(seg[s][7]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][3]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][2]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][4]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][5]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][6]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][1]));DW(sck1,1);DW(sck1,0);
    DW(sdi1,!(seg[s][0]));DW(sck1,1);DW(sck1,0);
    DW(latch1,1);DW(latch1,0);



    while(1) {

        while( digitalRead(in7) == 1 ) {}
        delay(35);
        a=!(digitalRead(in7));
        delay(35);
        b=!(digitalRead(in7));
        delay(35);
        c=!(digitalRead(in7));
        delay(35);
        d=!(digitalRead(in7));
        delay(35);

        //e=!(digitalRead(in7)); // 5 bit
        delay(35);
        f=!(digitalRead(in7));   // 6 bit
        delay(35);

        s=f*16+d*8+c*4+b*2+a;
        
        DW(sdi1,!(seg[s][7]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][3]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][2]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][4]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][5]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][6]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][1]));DW(sck1,1);DW(sck1,0);
        DW(sdi1,!(seg[s][0]));DW(sck1,1);DW(sck1,0);
        DW(latch1,1);DW(latch1,0);

        //delay(1000);

    } //while

}
