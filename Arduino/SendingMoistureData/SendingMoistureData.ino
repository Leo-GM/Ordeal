#include "SoftwareSerial.h"

SoftwareSerial bluetooth(10, 11); //10 = RX ; 11 = TX

int moisture;

void setup() {

 Serial.begin(9600);
 bluetooth.begin(9600);

}

void loop() {

 moisture = analogRead(A0);
 
 bluetooth.print(moisture);

  delay(2000);
}