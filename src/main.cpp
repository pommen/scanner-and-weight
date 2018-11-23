#include <Arduino.h>
#include <LiquidCrystal_I2C.h>
#include "HX711.h"
#include <PS2Keyboard.h>
#include <ClickEncoder.h>
#include <TimerOne.h>
#include <EEPROM.h>

#define pinA A2
#define pinB A0
#define pinSw A1 //switch
#define STEPS 4

LiquidCrystal_I2C lcd(0x3F, 20, 4);
PS2Keyboard keyboard;
HX711 scale(8, 9); // parameter "gain" is ommited; the default value 128 is used by the library
ClickEncoder encoder(pinA, pinB, pinSw, STEPS);

String barcodeScanner();
int match(String S);
void eepromStuff();
void timerIsr();
void rotEnc();
void getWeight();
void LCDDefults();
bool loadNextBox();

void test();
void test2();

//Barcode vars:
String barcodeString;
bool incommingBarcode = 0;
unsigned long barcodeTimeSinceLastAvliable = 0;
int done = 3;
const int DataPin = 3;
const int IRQpin = 2;

//Weight vars:
double currentWeight = 0.0000;
double currentWeightOld = 0.0000;
int scaleUpdateTimer = 0;
int scaleUpdateTimerOld = 0;
int16_t oldEncPos, encPos;
uint8_t buttonState;

//prom vars:
int eeAddr = 0;
int eeIndex = 20; //eatch struct thats saved to ee must be maller
String myString;
struct boxToBePacked
{
  char itemID[15];
  float itemWeight;
};
boxToBePacked box = {"1234567890123",
                     0.123};

//Other globals:

int okToPack = 0;
String S;
bool runSwitchAgain = 0;
void setup()
{

  keyboard.begin(DataPin, IRQpin);
  Serial.begin(9600);
  lcd.init(); // initialize the lcd
  lcd.backlight();
  LCDDefults();

  //calScale();
  scale.set_scale(-271790.f); // this value is obtained by calibrating the scale with known weights; see the README for details
  scale.tare(3);
  Timer1.initialize(1000);
  Timer1.attachInterrupt(timerIsr);
  encoder.setAccelerationEnabled(true);
  delay(50);
  EEPROM.get(eeAddr, box);
  delay(50);

  Serial.print(F("Loading EEPROM index: "));
  Serial.println(eeAddr);
  Serial.print(F("box.itemID: "));
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: "));
  Serial.println(box.itemWeight, 3);
  Serial.print(F("siezeof boxbox "));
  Serial.println(sizeof(box));

  Serial.println(F("***Ready***"));
  Serial.println();

  //test2();
  test();
  // eepromStuff();
}

void test()
{
}
void loop()
{
  rotEnc(); //update the encoder
  // test();
  //only update the wieght if we have nothing else to do
  if (millis() - scaleUpdateTimer > 200 && incommingBarcode == 0)
  {
    getWeight();
    scaleUpdateTimer = millis();
  }
  if (!runSwitchAgain)
    S = barcodeScanner();

  if (S.length() > 2 || runSwitchAgain == 1)
  {
    Serial.println(S);
    lcd.setCursor(0, 1);
    lcd.print(S);
    lcd.print("   ");
    okToPack = match(S);

    //  return;
    switch (okToPack)
    {
      /*
This is the rutrn results:

1 Match is good! (both ID and weight)
2 ID match good, weight bad
3 ID match is bad
4 no weight on the scale, or negative weight
  */
    case 1:
      runSwitchAgain = 0;
      lcd.clear();
      lcd.print("ALL GOOD!");
      Serial.println();

      delay(1000);
      LCDDefults();

      break;
    case 2:
      runSwitchAgain = 0;
      lcd.clear();
      lcd.print("BAD WEIGHT!");
      Serial.println();

      delay(1000);
      LCDDefults();
      break;
    case 3: //here we start to loop though the eeprom to find the correct ID
      eeAddr = -20;
      while (okToPack == 3) //3 = no id match
      {

        bool i = loadNextBox();
        if (i == 0) //we we are at max ee addr
        {
          runSwitchAgain = 0;
          Serial.println(F("ItemID not stored"));
          lcd.clear();
          lcd.print("Barcode not stored");
          delay(1500);
          LCDDefults();
          return;
        }
        runSwitchAgain = 1;
        okToPack = match(S);
      }

      runSwitchAgain = 1;
      break;
    case 4:
      runSwitchAgain = 0;
      lcd.clear();
      lcd.print("No weight!");
      Serial.println(F("no weight on the scale, or negative weight!"));
      Serial.print(currentWeight);
      Serial.println(F("Kg"));
      delay(1500);
      LCDDefults();
      break;

    default:
      break;
    }
  }
}

void getWeight()
{

  currentWeight = scale.get_units(5);

  if (currentWeight != currentWeightOld) //only update if needed
  {
    lcd.setCursor(9, 2);
    lcd.print(currentWeight, 3);
    lcd.print("   ");
    currentWeightOld = currentWeight;
  }
}

String barcodeScanner()
{
  if (keyboard.available())
  {
    done = 0;
    barcodeTimeSinceLastAvliable = millis();
    incommingBarcode = 1;
    char c = keyboard.read();
    barcodeString += c;
  }

  if (millis() - barcodeTimeSinceLastAvliable > 100 && done == 0)
  {
    done = 1;
    keyboard.clear();
  }

  if (done == 1)
  {
    String returnString = "";
    done = 3;
    returnString = (barcodeString + " ");
    barcodeString = "";
    incommingBarcode = 0;
    return returnString;
  }
  else
    return "no";
}

void calScale()
{
  //Change this calibration factor as per your load cell once it is found you many need to vary it in thousands
  float calibration_factor = -271790; //-106600 worked for my 40Kg max scale setup

  Serial.println(F("HX711 Calibration"));
  Serial.println(F("Remove all weight from scale"));
  Serial.println(F("After readings begin, place known weight on scale"));
  Serial.println(F("Press a,s,d,f to increase calibration factor by 10,100,1000,10000 respectively"));
  Serial.println(F("Press z,x,c,v to decrease calibration factor by 10,100,1000,10000 respectively"));
  Serial.println(F("Press t for tare"));
  scale.set_scale();
  scale.tare(); //Reset the scale to 0

  long zero_factor = scale.read_average(); //Get a baseline reading
  Serial.print(F("Zero factor: "));           //This can be used to remove the need to tare the scale. Useful in permanent scale projects.
  Serial.println(zero_factor);

  //=============================================================================================
  //                         LOOP
  //=============================================================================================
  while (true)
  {

    scale.set_scale(calibration_factor); //Adjust to this calibration factor

    Serial.print(F("Reading: "));
    Serial.print(scale.get_units(), 3);
    Serial.print(F(" kg")); //Change this to kg and re-adjust the calibration factor if you follow SI units like a sane person
    Serial.print(F(" calibration_factor: "));
    Serial.print(calibration_factor);
    Serial.println();

    if (Serial.available())
    {
      char temp = Serial.read();
      if (temp == '+' || temp == 'a')
        calibration_factor += 10;
      else if (temp == '-' || temp == 'z')
        calibration_factor -= 10;
      else if (temp == 's')
        calibration_factor += 100;
      else if (temp == 'x')
        calibration_factor -= 100;
      else if (temp == 'd')
        calibration_factor += 1000;
      else if (temp == 'c')
        calibration_factor -= 1000;
      else if (temp == 'f')
        calibration_factor += 10000;
      else if (temp == 'v')
        calibration_factor -= 10000;
      else if (temp == 't')
        scale.tare(); //Reset the scale to zero
    }
  }
}

void rotEnc()
{
  encPos += encoder.getValue();

  if (encPos != oldEncPos)
  {
    oldEncPos = encPos;
    Serial.print(F("Encoder Value: "));
    Serial.println(encPos);
  }

  buttonState = encoder.getButton();

  if (buttonState != 0)
  {
    Serial.print(F("Button: "));
    Serial.println(buttonState);
    switch (buttonState)
    {
    case ClickEncoder::Open: //0
      break;

    case ClickEncoder::Closed: //1
      break;

    case ClickEncoder::Pressed: //2
      break;

    case ClickEncoder::Held: //3
      break;

    case ClickEncoder::Released: //4
      break;

    case ClickEncoder::Clicked: //5
      scale.tare();

      break;

    case ClickEncoder::DoubleClicked: //6
      eepromStuff();
      break;
    }
  }
}

void timerIsr()
{
  encoder.service();
}

int match(String S)
{
  int result = 0;
  char toBeMatched[15];
  S.toCharArray(toBeMatched, S.length());
  /*
This is the rutrn results:

1 Match is good! (both ID and weight)
2 ID mtach good, weight bad
3 ID match is bad
4 no weight on the scale, or negative weight
  */
  if (currentWeight < 0.1)
  {
    result = 4;
    return result;
  }

  //Does the itemID match?
  Serial.print(F("eeaddr: "));
      Serial.println(eeAddr);
  Serial.print(F("box.itemID: "));
  Serial.print(box.itemID);
  Serial.print(F(" with seize: "));
  Serial.println(sizeof(box.itemID));

  Serial.print(F("toBeMatched: "));
  Serial.print(toBeMatched);
  Serial.print(F(" with seize: "));
  Serial.println(sizeof(toBeMatched));
  if (strcmp(toBeMatched, box.itemID) == 0)
  //if (toBeMatched == box.itemID)
  {
    Serial.println(F("We have a ID match"));
    //Does the weight match?
    Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight, 3);
    Serial.print(F("currentWeight: "));
    Serial.println(currentWeight, 3);
    Serial.print(F("box.itemWeight - currentWeight: "));
    float diff = box.itemWeight - currentWeight;
    Serial.println(diff, 3);
    if (diff < 0.012 && diff > -0.012)
    {
      Serial.println(F("we got a weight match"));
      result = 1;
    }
    else
    {
      result = 2;
      Serial.println(F("BAD weight match!"));
    }
  }
  else
  {
    Serial.println(F("BAD ID match!"));
    Serial.println();
    result = 3;
  }

  return result;
}

void eepromStuff()
{

  String Stemp = barcodeScanner();
  Serial.println(F("*****EEPROM stuff!*****"));
  while (buttonState != 0)
  {
    buttonState = encoder.getButton();
  }

  delay(100);
  lcd.clear();
  lcd.print("Choose program: ");
  lcd.print(eeAddr / 10);
  lcd.setCursor(0, 3);
  lcd.print("Click when done");
  int oldEncPos = 0;
  lcd.setCursor(0, 1);
  lcd.print("ID: ");
  lcd.setCursor(0, 2);
  lcd.print("Kg: ");
  oldEncPos = encPos - 1;
  while (buttonState != 5) //wwhile not clicked
  {
    buttonState = encoder.getButton();
    if (buttonState != 0)
    {
      Serial.print(F("Button: "));
      Serial.println(buttonState);
    }
    encPos += encoder.getValue();
    if (encPos < 0)
      encPos = 0;
    if (encPos > 40)
      encPos = 40;

    if (encPos != oldEncPos)
    {
      eeAddr = encPos * eeIndex;
      lcd.setCursor(17, 0);
      lcd.print(" ");
      lcd.setCursor(16, 0);
      lcd.print(eeAddr / eeIndex);
      oldEncPos = encPos;
      EEPROM.get(eeAddr, box);
      delay(7);
      lcd.setCursor(4, 1);
      lcd.print("               ");
      lcd.setCursor(4, 1);
      lcd.print(box.itemID);
      lcd.setCursor(4, 2);
      lcd.print("               ");
      lcd.setCursor(4, 2);
      lcd.print(box.itemWeight,3);
      Serial.print(F("eeaddr: : "));
      Serial.println(eeAddr);
      Serial.print(F("box.itemID: "));
      Serial.println(box.itemID);
      Serial.print(F("box.itemWeight: "));
      Serial.println(box.itemWeight);
      delay(50);
    }
  }

  lcd.clear();
  lcd.print("Put weight and scan");
  Serial.println(F("Waiting for scan"));

  while (Stemp != "no")
  {
    //Serial.println(Stemp.length());
    Stemp = barcodeScanner();
  }
  Stemp = barcodeScanner();
  Serial.print(F("Stemp before scan: "));
  Serial.println(Stemp);

  while (Stemp == "no")
  {
    // Serial.println(Stemp.length());
    Stemp = barcodeScanner();
  }
  getWeight();
  Serial.println(F("*Got: "));

  Serial.print(F("barcode: "));
  Serial.println(Stemp);
  Serial.print(F("Weight: "));
  Serial.println(currentWeight);

  lcd.clear();
  lcd.print(" Got barcode:");
  lcd.setCursor(0, 1);
  lcd.print(Stemp);

  Stemp.toCharArray(box.itemID, Stemp.length());

  box.itemWeight = currentWeight;
  delay(5);
  EEPROM.put(eeAddr, box);

  Serial.print(F("Writing to eeprom at index:"));
  Serial.println(eeAddr);

  Serial.print(F("box.itemID: "));
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: "));
  Serial.println(box.itemWeight);
  Serial.println();

  delay(200);

  Serial.println(F("Reading from eeprom"));
  EEPROM.get(eeAddr, box);
  Serial.print(F("box.itemID: "));
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: "));
  Serial.println(box.itemWeight);
  delay(100);
  if (Stemp != box.itemID)
  {
    Serial.println(F("ID not stored"));
  }
  else

      if (currentWeight != box.itemWeight)
  {
    Serial.println(F("Weight not stored"));
  }
  else
  {

    lcd.clear();
    lcd.print("update ok");
    Serial.println(F("Eeprom looks good"));
  }
  Serial.print(F("seize:"));
  Serial.println(sizeof(box));

  Serial.println(F("*****EEPROM done*****"));
  delay(1000);
  lcd.clear();

  LCDDefults();
}

void LCDDefults()
{
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Packing: ");
  lcd.setCursor(0, 2);
  lcd.print("Weight: ");
}
void test2()
{
  for (int i = 0; i < EEPROM.length(); i++)
  {
    EEPROM.write(i, 0);
  }
  Serial.println(F("Done with eeprom clear"));
  while (true)
  {
  }

  Serial.println(F("done clearing EErpom!"));
  while (true)
  {
  }
}

bool loadNextBox()
{
  eeAddr = eeAddr + eeIndex;

  if (eeAddr > 490) //we reatched the max eeaddr
  {
    eeAddr = 0;
    return 0;
  }
  delay(1);
  EEPROM.get(eeAddr, box);
  delay(1);
  /*  Serial.print(F("Loading EEPROM index: ");
  Serial.println(eeAddr);
  Serial.print(F("box.itemID: ");
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: ");
  Serial.println(box.itemWeight, 3);
  Serial.println(); */

  return 1;
}