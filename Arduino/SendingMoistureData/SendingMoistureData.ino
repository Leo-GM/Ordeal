#include "SoftwareSerial.h"

SoftwareSerial bluetooth(10, 11); //10 = RX ; 11 = TX

int moisture = 0;
int vezesMedida = 0;
int dadosUmidade[15];
int interactions;



void setup() {

 Serial.begin(9600);
 bluetooth.begin(9600);

}

void loop() {
  moisture = 0;

for (vezesMedida=0; vezesMedida<15; vezesMedida++){
  int medida = analogRead(A0);
  dadosUmidade[vezesMedida] = medida;
  delay(1000);
}

for (interactions = 0; interactions<15; interactions++){
  moisture = moisture + dadosUmidade[interactions];
}

  moisture = moisture/15;

 bluetooth.print(moisture);

 delay(3000);

}