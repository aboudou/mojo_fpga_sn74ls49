#define PIN_A 1
#define PIN_B 2
#define PIN_C 3
#define PIN_D 4


void setup() {
  pinMode(PIN_A, OUTPUT);
  pinMode(PIN_B, OUTPUT);
  pinMode(PIN_C, OUTPUT);
  pinMode(PIN_D, OUTPUT);

  digitalWrite(PIN_A, HIGH);
  digitalWrite(PIN_B, HIGH);
  digitalWrite(PIN_C, HIGH);
  digitalWrite(PIN_D, HIGH);

  delay(5000);
}

void loop() {
  for (byte i = 0; i < 10; i++) {
    digitalWrite(PIN_A, i & B00000001 ? HIGH : LOW);      
    digitalWrite(PIN_B, i & B00000010 ? HIGH : LOW);      
    digitalWrite(PIN_C, i & B00000100 ? HIGH : LOW);      
    digitalWrite(PIN_D, i & B00001000 ? HIGH : LOW);

    delay(1000);
  }

}
