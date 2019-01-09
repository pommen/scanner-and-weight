#include <Arduino.h>
#include <LiquidCrystal_I2C.h>
#include "HX711.h"
#include <PS2Keyboard.h>
#include <ClickEncoder.h>
#include <TimerOne.h>
#include <EEPROM.h>

//#define DEBUG  //use this for serial debugging

#define pinA 7
#define pinB 8
#define pinSw 6 //switch
#define STEPS 4

LiquidCrystal_I2C lcd(0x3F, 20, 4);
PS2Keyboard keyboard;
HX711 scale(4, 5); // parameter "gain" is ommited; the default value 128 is used by the library
ClickEncoder encoder(pinA, pinB, pinSw, STEPS);

String barcodeScanner();
int match(String S);
void timerIsr();
void rotEnc();
void getWeight();
void LCDDefults();
bool loadNextBox();
void eraseEEPROM();
void EEPROMauto();
void EEPROMmanual();
void lights(int color);
void test();

//Pins:

const int red = 9;
const int blue = 10;
const int yellow = 11;
const int green = 12;
const int buzzer = 13;

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

void eepromStuff();

void setup()
{

  keyboard.begin(DataPin, IRQpin);

  Serial.begin(9600);
#if defined(DEBUG)

  Serial.print("Debugging enabled");

#endif // debug

  lcd.init(); // initialize the lcd
  lcd.backlight();
  LCDDefults();
  pinMode(red, OUTPUT);
  pinMode(blue, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(yellow, OUTPUT);
  pinMode(buzzer, OUTPUT);

  //calScale();
  scale.set_scale(-271790.f); // this value is obtained by calibrating the scale with known weights; see the README for details
  scale.tare(3);
  Timer1.initialize(1000);
  Timer1.attachInterrupt(timerIsr);
  encoder.setAccelerationEnabled(true);

  delay(50);
  EEPROM.get(eeAddr, box);
  delay(50);
#if defined(DEBUG)

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
#endif // debug

  //test2();
  //test();
  // eepromStuff();
}

void test()
{
#if defined(DEBUG)
  while (1 == 1)
  {

    for (size_t i = 1; i < 6; i++)
    {
      lights(i);
      delay(1000);
      lights(0);
      delay(1000);
    }
  }
#endif // debug
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

    if (eeAddr < 0)
      eeAddr = 0;
#if defined(DEBUG)
    Serial.println(S);
#endif // debug
    lcd.setCursor(0, 1);
    lcd.print(S);
    lcd.print("   ");
    okToPack = match(S);

    //  return;
    switch (okToPack)
    {
      /*
This is the return results:

1 Match is good! (both ID and weight)
2 ID match good, weight bad
3 ID match is bad
4 no weight on the scale, or negative weight
  */

      /* 
    lights() function truth table:
     1.red
  2.blue
  3.yellow
  4.green
  5.buzzer */

    case 1:
      runSwitchAgain = 0;
      lcd.clear();
      lcd.print("ALL GOOD!");
      Serial.println();
      lights(4);
      delay(700);
      lights(0);
      LCDDefults();

      break;
    case 2:
      runSwitchAgain = 0;
      lcd.clear();
      lcd.print("BAD WEIGHT!");
      Serial.println();
      lights(1);
      lights(5);
      delay(700);
      lights(0);

      delay(500);
      lights(1);
      lights(5);
      delay(700);
      lights(0);
      LCDDefults();
      break;

    case 3: //here we start to loop though the eeprom to find the correct ID
      eeAddr = -20;
      while (okToPack == 3) //3 = no id match
      {

        bool i = loadNextBox();
        if (i == 0) //we we are at max eeprom addr
        {
          runSwitchAgain = 0;
#if defined(DEBUG)
          Serial.println(F("ItemID not stored"));
#endif // debug
          lcd.clear();
          lcd.print("Barcode not stored");
          lights(3);
          delay(1500);
          lights(0);
          delay(500);
          lights(3);
          delay(1500);
          lights(0);
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
#if defined(DEBUG)
      Serial.println(F("no weight on the scale, or negative weight!"));
      Serial.print(currentWeight);
      Serial.println(F("Kg"));
#endif // debug
      lights(1);
      lights(5);
      delay(1500);
      lights(0);
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
   // keyboard.clear();
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
#if defined(DEBUG)
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
  Serial.print(F("Zero factor: "));        //This can be used to remove the need to tare the scale. Useful in permanent scale projects.
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
#endif // debug
}

void rotEnc()
{
  encPos += encoder.getValue();

  if (encPos != oldEncPos)
  {
    oldEncPos = encPos;
#if defined(DEBUG)
    Serial.print(F("Encoder Value: "));
    Serial.println(encPos);
#endif // debug
  }

  buttonState = encoder.getButton();

  if (buttonState != 0)
  {
#if defined(DEBUG)
    Serial.print(F("Button: "));
    Serial.println(buttonState);
#endif // debug
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
This is the return results:

1 Match is good! (both ID and weight)
2 ID mtach good, weight bad
3 ID match is bad
4 no weight on the scale, or negative weight
  */
  if (currentWeight < 0.012)
  {
    result = 4;
    return result;
  }

  //Does the itemID match?
  /*   Serial.print(F("eeaddr: "));
  Serial.println(eeAddr);
  Serial.print(F("box.itemID: "));
  Serial.print(box.itemID);
  Serial.print(F(" with seize: "));
  Serial.println(sizeof(box.itemID));

  Serial.print(F("toBeMatched: "));
  Serial.print(toBeMatched);
  Serial.print(F(" with seize: "));
  Serial.println(sizeof(toBeMatched)); */
  if (strcmp(toBeMatched, box.itemID) == 0)
  //if (toBeMatched == box.itemID)
  {
#if defined(DEBUG)
    Serial.println(F("We have a ID match"));
#endif // debug
    //Does the weight match?
    /*     Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight, 3);
    Serial.print(F("currentWeight: "));
    Serial.println(currentWeight, 3);
    Serial.print(F("box.itemWeight - currentWeight: ")); */
    float diff = box.itemWeight - currentWeight;
    Serial.println(diff, 3);
    if (diff < 0.012 && diff > -0.012)
    {
#if defined(DEBUG)
      Serial.println(F("we got a weight match"));
      Serial.println(F("All good!"));
      Serial.println();
#endif // debug

      result = 1;
    }
    else
    {
      result = 2;
#if defined(DEBUG)
      Serial.println(F("BAD weight match!"));
#endif // debug
    }
  }
  else
  {
#if defined(DEBUG)
    Serial.println(F("BAD ID match!"));
    Serial.println();
#endif // debug
    result = 3;
  }
  Serial.println();
  return result;
}

void LCDDefults()
{
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Packing: ");
  lcd.setCursor(0, 2);
  lcd.print("Weight: ");
}
void eraseEEPROM()
{
  lcd.clear();
  lcd.print("CLEARING EEPROM");
  for (unsigned int i = 0; i < EEPROM.length(); i++)
  {
    EEPROM.write(i, 0);
  }
#if defined(DEBUG)
  Serial.println(F("Done with eeprom clear"));
#endif // debug
  LCDDefults();
}

bool loadNextBox()
{
  if (eeAddr < 0)
  {
    eeAddr = 0;
  }
  else
    eeAddr = eeAddr + eeIndex;

  if (eeAddr > 490) //we reatched the max eeaddr
  {
    eeAddr = 0;
    return 0;
  }
  delay(1);
  EEPROM.get(eeAddr, box);
  delay(1);
#if defined(DEBUG)
   Serial.print(F("Loading EEPROM index: ");
  Serial.println(eeAddr);
  Serial.print(F("box.itemID: ");
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: ");
  Serial.println(box.itemWeight, 3);
  Serial.println();
#endif // debug

  return 1;
}
void eepromStuff()
{
#if defined(DEBUG)
  Serial.println(F("*****EEPROM stuff!*****"));
#endif // debug
  // char toBeMatched[15];
  // bool maxeeprom = 0;
  //What to do here:

  //1. check if we have the barcode already. If yes: Update if no see 2.
  //2. place id (barcode string) on first avalible EEadress. if all occypied: see 3.
  //3. let user decide witch program to overwrite.

  String Stemp = barcodeScanner(); //borde få "no" som svar.
  lcd.clear();
  lcd.print("Manage programs");
  lcd.setCursor(1, 1);
  lcd.print(" Auto   add/update");
  lcd.setCursor(1, 2);
  lcd.print(" Manual add/update");
  lcd.setCursor(1, 3);
  lcd.print(" Erase all");
  encPos = 1;
  lcd.setCursor(0, 1);
  lcd.print("*");
  while (buttonState != 5)
  {
    buttonState = encoder.getButton();
    encPos += encoder.getValue();
    if (encPos < 1)
      encPos = 1;
    if (encPos > 3)
      encPos = 3;
    switch (encPos)
    {
    case 1:
      lcd.setCursor(0, 2);
      lcd.print(F(" "));
      lcd.setCursor(0, 3);
      lcd.print(F(" "));
      lcd.setCursor(0, 1);
      lcd.print(F("*"));
      break;
    case 2:
      lcd.setCursor(0, 1);
      lcd.print(F(" "));
      lcd.setCursor(0, 3);
      lcd.print(F(" "));
      lcd.setCursor(0, 2);
      lcd.print(F("*"));
      break;
    case 3:
      lcd.setCursor(0, 1);
      lcd.print(F(" "));
      lcd.setCursor(0, 2);
      lcd.print(F(" "));
      lcd.setCursor(0, 3);
      lcd.print(F("*"));
      break;
    default:
      break;
    }
  }

  switch (encPos)
  {
  case 1:
    EEPROMauto();
    break;

  case 2:
    EEPROMmanual();
    break;

  case 3:
    eraseEEPROM();
    break;
  }
  while (buttonState != 0) //while not clicked
  {
    buttonState = encoder.getButton();
  }
  LCDDefults();
}

void EEPROMauto()
{
#if defined(DEBUG)
  Serial.println(F("*****EEPROMauto!*****"));
#endif // debug

  bool maxeeprom = 0;
  char toBeMatched[15];
  String Stemp = barcodeScanner(); //borde få "no" som svar.

  lcd.clear();
  lcd.print(F("Put weight and scan"));
#if defined(DEBUG)
  Serial.println(F("Waiting for scan"));
#endif // debug

  while (Stemp == "no")
  {
    // Serial.println(Stemp.length());
    Stemp = barcodeScanner();
  }
  getWeight();
#if defined(DEBUG)
  Serial.println(F("Got: "));
  Serial.print(F("barcode: "));
  Serial.println(Stemp);
  Serial.print(F("Weight: "));
  Serial.println(currentWeight);
#endif // debug

  lcd.clear();
  lcd.print(F(" Got barcode:"));
  lcd.setCursor(0, 1);
  lcd.print(Stemp);
  Stemp.toCharArray(toBeMatched, Stemp.length());
  lcd.setCursor(0, 2);
  lcd.print(F("Searching for match"));

  int itemIDStoredState = 0;
  int itemIDStored = 0;
  //See if we have stored the box before
  //This is the return results:

  //1 Match is good! (both ID and weight) //not here
  //2 ID match good, weight bad
  //3 ID match is bad
  //4 no weight on the scale, or negative weight
  getWeight();
  while (itemIDStored == 0)
  {
    itemIDStoredState = match(Stemp);
    if (itemIDStoredState == 1 || itemIDStoredState == 2)
    {
      itemIDStored = 2;
      break;
    }

    int runonce = 0;
    while (itemIDStoredState == 3) //3 = no id match
    {

      if (itemIDStoredState == 4)
      {
        lcd.clear();
        lcd.print(F("No Weight on scale"));
        delay(3000);
        return;
      }

      if (runonce == 0)
      {
        eeAddr = -20;
        runonce = 1;
      }
      bool i = loadNextBox();
      if (i == 0) //we we are at max eeprom addr
      {
        runSwitchAgain = 0;
        Serial.println(F("ItemID not stored!"));
        itemIDStored = 1;
        break;
      }
      itemIDStoredState = match(Stemp);
    }
    Serial.println(itemIDStoredState);
  }

  //itemIDStored :
  //1 no id in eeprom.
  //2 found ee adress to update
  //********************************************
  Serial.println(F(""));
  Serial.print(F("itemIDStored: "));
  Serial.println(itemIDStored);
  Serial.println(F(""));

  switch (itemIDStored)
  {
  case 1: //find unused adress
  {
    eeAddr = -20; //så vi börjar på ee index 0.
    int isAlphaNumer = 1;
    while (isAlphaNumer)
    {
      maxeeprom = loadNextBox();

      char thisChar = box.itemID[0];
      // analyze what was sent:
      if (isAlphaNumeric(thisChar))
      {
#if defined(DEBUG)
        Serial.print(F("boxID: "));
        Serial.println(box.itemID);
        Serial.println("it's alphanumeric");
#endif // debug
        isAlphaNumer = 1;
      }
      else
      {
        isAlphaNumer = 0;
        break;
      }

      if (maxeeprom == 0)
      {
#if defined(DEBUG)
        Serial.println("max eeprom ");
#endif // debug
        delay(100);
        lcd.clear();
        lcd.print("No free program");
        delay(2000);
        EEPROMmanual();
        return;
        break;
      }
    }
#if defined(DEBUG)
    Serial.print("boxID: ");
    Serial.println(box.itemID);
    Serial.println(sizeof(box.itemID));

    Serial.print("eeaddr: ");
    Serial.println(eeAddr);
#endif // debug
    Stemp.toCharArray(box.itemID, Stemp.length());

    box.itemWeight = currentWeight;
    delay(5);
    EEPROM.put(eeAddr, box);
#if defined(DEBUG)
    Serial.print(F("Writing to eeprom at index:"));
    Serial.println(eeAddr);

    Serial.print(F("box.itemID: "));
    Serial.println(box.itemID);
    Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight, 3);
    Serial.println();

    Serial.println(F("Reading from eeprom"));
#endif // debug
    EEPROM.get(eeAddr, box);
#if defined(DEBUG)
    Serial.print(F("box.itemID: "));
    Serial.println(box.itemID);
    Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight, 3);
#endif // debug

    if (strcmp(toBeMatched, box.itemID) != 0)
    // if (Stemp != box.itemID)
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
#if defined(DEBUG)
      Serial.println(F("Eeprom looks good"));
#endif // debug
    }
#if defined(DEBUG)
    Serial.print(F("seize:"));
    Serial.println(sizeof(box));

    Serial.println(F("*****EEPROM done*****"));
#endif // debug
    delay(1000);
    lcd.clear();

    LCDDefults();
    return;
  }
  case 2:
#if defined(DEBUG)
    Serial.println();
    Serial.print("Updating address: ");
    Serial.println(eeAddr);
#endif // debug

    Stemp.toCharArray(box.itemID, Stemp.length());

    box.itemWeight = currentWeight;
    delay(5);
    EEPROM.put(eeAddr, box);
#if defined(DEBUG)
    Serial.print(F("Writing to eeprom at index:"));
    Serial.println(eeAddr);

    Serial.print(F("box.itemID: "));
    Serial.println(box.itemID);
    Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight);
    Serial.println();

    Serial.println(F("Reading from eeprom"));
#endif // debug
    EEPROM.get(eeAddr, box);
#if defined(DEBUG)
    Serial.print(F("box.itemID: "));
    Serial.println(box.itemID);
    Serial.print(F("box.itemWeight: "));
    Serial.println(box.itemWeight);
#endif // debug

    if (strcmp(toBeMatched, box.itemID) == 0)
    // if (Stemp != box.itemID)
    {
#if defined(DEBUG)
      Serial.println(F("ID stored OK"));
#endif // debug
    }
    else
#if defined(DEBUG)
      Serial.println(F("ID not stored"));
#endif // debug

    if (currentWeight != box.itemWeight)
    {
#if defined(DEBUG)
      Serial.println(F("Weight not stored"));
#endif // debug
    }
    else
    {

      lcd.clear();
      lcd.print("EEPROM write ok");
#if defined(DEBUG)
      Serial.println(F("Eeprom looks good"));
#endif // debug
      delay(1500);
    }
#if defined(DEBUG)
    Serial.print(F("seize:"));
    Serial.println(sizeof(box));

    Serial.println(F("*****EEPROM done*****"));
#endif // debug
    lcd.clear();

    LCDDefults();
    return;
  }
}

void EEPROMmanual()
{
  int oldEEaddr = eeAddr;
#if defined(DEBUG)
  Serial.println(F("*****EEPROMmanual!*****"));
#endif // debug

  // bool maxeeprom = 0;
  char toBeMatched[15];
  String Stemp = barcodeScanner(); //borde få "no" som svar.

  lcd.print("Choose program: ");
  lcd.print(eeAddr / 10);
  lcd.setCursor(0, 3);
  lcd.print("Click to proceed");
  int oldEncPos = 0;
  lcd.setCursor(0, 1);
  lcd.print("ID: ");
  lcd.setCursor(0, 2);
  lcd.print("Kg: ");
  oldEncPos = encPos - 1;
  bool NeedtoUpdateMenu = 0;
  while (buttonState != 0) //while not clicked
  {
    buttonState = encoder.getButton();
  }

  while (buttonState != 5) //while not clicked
  {
    buttonState = encoder.getButton();
    if (buttonState != 0)
    {
#if defined(DEBUG)
      Serial.print(F("Button: "));
      Serial.println(buttonState);
#endif // debug
    }
    encPos += encoder.getValue();
    if (encPos < -1)
      encPos = -1;
    if (encPos > 40)
      encPos = 40;

    if (encPos != oldEncPos)
    {
      eeAddr = encPos * eeIndex;
      if (encPos == -1)
      {
        lcd.clear();
        lcd.print("Exit menu");

        NeedtoUpdateMenu = 1;
      }
      else if (NeedtoUpdateMenu)
      {
        NeedtoUpdateMenu = 0;
        lcd.clear();
        lcd.print("Choose program: ");
        lcd.print(eeAddr / 10);
        lcd.setCursor(0, 3);
        lcd.print("Click to proceed");
        lcd.setCursor(0, 1);
        lcd.print("ID: ");
        lcd.setCursor(0, 2);
        lcd.print("Kg: ");
      }
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
      lcd.print(box.itemWeight, 3);
#if defined(DEBUG)
      Serial.print(F("eeaddr: : "));
      Serial.println(eeAddr);
      Serial.print(F("box.itemID: "));
      Serial.println(box.itemID);
      Serial.print(F("box.itemWeight: "));
      Serial.println(box.itemWeight);
#endif // debug
      delay(50);
    }
  }
  if (encPos == -1)
  {
    #if defined(DEBUG)
    Serial.println(F("Exit menu"));
#endif // debug

    eeAddr = oldEEaddr;
    LCDDefults();
    return;
  }
  Stemp = barcodeScanner(); //borde få "no" som svar.

  lcd.clear();
  lcd.print("Put weight and scan");
  #if defined(DEBUG)
  Serial.println(F("Waiting for scan"));
#endif // debug

  while (Stemp == "no")
  {
    // Serial.println(Stemp.length());
    Stemp = barcodeScanner();
  }
  getWeight();
  #if defined(DEBUG)
  Serial.println(F("Got: "));

  Serial.print(F("barcode: "));
  Serial.println(Stemp);
  Serial.print(F("Weight: "));
  Serial.println(currentWeight);
#endif // debug

  lcd.clear();
  lcd.print(" Got barcode:");
  lcd.setCursor(0, 1);
  lcd.print(Stemp);
  Stemp.toCharArray(toBeMatched, Stemp.length());
  Stemp.toCharArray(box.itemID, Stemp.length());
  lcd.setCursor(0, 2);

  box.itemWeight = currentWeight;
  delay(5);
  EEPROM.put(eeAddr, box);
#if defined(DEBUG)
  Serial.print(F("Writing to eeprom at index:"));
  Serial.println(eeAddr);
#endif // debug
  EEPROM.get(eeAddr, box);
#if defined(DEBUG)
  Serial.print(F("box.itemID: "));
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: "));
  Serial.println(box.itemWeight);
  Serial.println();

  Serial.println(F("Reading from eeprom"));
#endif // debug
  EEPROM.get(eeAddr, box);
  #if defined(DEBUG)
  Serial.print(F("box.itemID: "));
  Serial.println(box.itemID);
  Serial.print(F("box.itemWeight: "));
  Serial.println(box.itemWeight);
#endif // debug

  if (strcmp(toBeMatched, box.itemID) != 0)
  // if (Stemp != box.itemID)
  {
    #if defined(DEBUG)
    Serial.println(F("ID not stored"));
#endif // debug
  }
  else

      if (currentWeight != box.itemWeight)
  {
    #if defined(DEBUG)
    Serial.println(F("Weight not stored"));
#endif // debug
  }
  else
  {

    lcd.clear();
    lcd.print("EEPROM write ok");
    #if defined(DEBUG)
    Serial.println(F("Eeprom looks good"));
#endif // debug
    delay(1500);
  }
  #if defined(DEBUG)
  Serial.print(F("seize:"));
  Serial.println(sizeof(box));

  Serial.println(F("*****EEPROM done*****"));
#endif // debug
  lcd.clear();

  LCDDefults();
  return;
}

void lights(int color)
{

  /*  1.red
  2.blue
  3.yellow
  4.green
  5.buzzer */
  int state = color;
  switch (state)
  {
  case 1:
    digitalWrite(red, HIGH);

    break;
  case 2:
    digitalWrite(blue, HIGH);
    break;
  case 3:
    digitalWrite(yellow, HIGH);
    break;
  case 4:
    digitalWrite(green, HIGH);
    break;
  case 5:
    digitalWrite(buzzer, HIGH);
    break;

  case 0:
    digitalWrite(red, LOW);
    digitalWrite(blue, LOW);
    digitalWrite(yellow, LOW);
    digitalWrite(green, LOW);
    digitalWrite(buzzer, LOW);
    break;

  default:

    break;
  }
}