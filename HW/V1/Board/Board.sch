EESchema Schematic File Version 4
LIBS:Board-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Digitalscale at packing"
Date "2018-11-18"
Rev "1"
Comp ""
Comment1 "by:PR"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L dk_DC-DC-Converters:V7805-1000 U1
U 1 1 5BF1750D
P 3350 1600
F 0 "U1" H 3350 1987 60  0000 C CNN
F 1 "V7805-1000" H 3350 1881 60  0000 C CNN
F 2 "digikey-footprints:3-SIP_Module_V7805-1000" H 3550 1800 60  0001 L CNN
F 3 "https://www.cui.com/product/resource/digikeypdf/v78xx-1000.pdf" H 3550 1900 60  0001 L CNN
F 4 "102-1715-ND" H 3550 2000 60  0001 L CNN "Digi-Key_PN"
F 5 "V7805-1000" H 3550 2100 60  0001 L CNN "MPN"
F 6 "Power Supplies - Board Mount" H 3550 2200 60  0001 L CNN "Category"
F 7 "DC DC Converters" H 3550 2300 60  0001 L CNN "Family"
F 8 "https://www.cui.com/product/resource/digikeypdf/v78xx-1000.pdf" H 3550 2400 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/cui-inc/V7805-1000/102-1715-ND/1828608" H 3550 2500 60  0001 L CNN "DK_Detail_Page"
F 10 "DC DC CONVERTER 5V 5W" H 3550 2600 60  0001 L CNN "Description"
F 11 "CUI Inc." H 3550 2700 60  0001 L CNN "Manufacturer"
F 12 "Active" H 3550 2800 60  0001 L CNN "Status"
	1    3350 1600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack J1
U 1 1 5BF175EA
P 1650 1600
F 0 "J1" H 1705 1925 50  0000 C CNN
F 1 "Barrel_Jack" H 1705 1834 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 1700 1560 50  0001 C CNN
F 3 "~" H 1700 1560 50  0001 C CNN
	1    1650 1600
	1    0    0    -1  
$EndComp
$Comp
L MCU_Module:Arduino_Nano_v2.x A1
U 1 1 5BF176CE
P 5900 3350
F 0 "A1" H 5900 2264 50  0000 C CNN
F 1 "Arduino_Nano_v2.x" H 5900 2173 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 6050 2400 50  0001 L CNN
F 3 "https://www.arduino.cc/en/uploads/Main/ArduinoNanoManual23.pdf" H 5900 2350 50  0001 C CNN
	1    5900 3350
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J6
U 1 1 5BF178F4
P 10150 4650
F 0 "J6" H 10100 4300 50  0000 L CNN
F 1 "toScale" V 10250 4450 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_bornier-4_P5.08mm" H 10150 4650 50  0001 C CNN
F 3 "~" H 10150 4650 50  0001 C CNN
	1    10150 4650
	1    0    0    -1  
$EndComp
$Comp
L Peters:HX711_Module U3
U 1 1 5BF191D3
P 9450 4750
F 0 "U3" H 9450 5175 50  0000 C CNN
F 1 "HX711_Module" H 9450 5084 50  0000 C CNN
F 2 "Libs:HX711_Module" H 9500 4950 50  0001 C CNN
F 3 "" H 9500 4950 50  0001 C CNN
	1    9450 4750
	1    0    0    -1  
$EndComp
$Comp
L power:+24V #PWR0101
U 1 1 5BF192ED
P 2400 1450
F 0 "#PWR0101" H 2400 1300 50  0001 C CNN
F 1 "+24V" H 2415 1623 50  0000 C CNN
F 2 "" H 2400 1450 50  0001 C CNN
F 3 "" H 2400 1450 50  0001 C CNN
	1    2400 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5BF19330
P 2400 1850
F 0 "#PWR0102" H 2400 1600 50  0001 C CNN
F 1 "GND" H 2405 1677 50  0000 C CNN
F 2 "" H 2400 1850 50  0001 C CNN
F 3 "" H 2400 1850 50  0001 C CNN
	1    2400 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 5BF19373
P 3850 1450
F 0 "#PWR0103" H 3850 1300 50  0001 C CNN
F 1 "+5V" H 3865 1623 50  0000 C CNN
F 2 "" H 3850 1450 50  0001 C CNN
F 3 "" H 3850 1450 50  0001 C CNN
	1    3850 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 1500 2400 1500
Wire Wire Line
	2400 1500 2400 1450
Connection ~ 2400 1500
$Comp
L power:GND #PWR0104
U 1 1 5BF194C9
P 3350 1950
F 0 "#PWR0104" H 3350 1700 50  0001 C CNN
F 1 "GND" H 3355 1777 50  0000 C CNN
F 2 "" H 3350 1950 50  0001 C CNN
F 3 "" H 3350 1950 50  0001 C CNN
	1    3350 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1950 3350 1900
Wire Wire Line
	3750 1500 3850 1500
Wire Wire Line
	3850 1500 3850 1450
$Comp
L Device:C_Small C1
U 1 1 5BF1956D
P 2750 1650
F 0 "C1" H 2842 1696 50  0000 L CNN
F 1 "10uF/50V" V 2600 1400 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_6.3x5.3" H 2750 1650 50  0001 C CNN
F 3 "~" H 2750 1650 50  0001 C CNN
	1    2750 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1700 2400 1850
Wire Wire Line
	2400 1500 2750 1500
Wire Wire Line
	2750 1550 2750 1500
Connection ~ 2750 1500
Wire Wire Line
	2750 1500 2950 1500
$Comp
L power:GND #PWR0105
U 1 1 5BF1983D
P 2750 1850
F 0 "#PWR0105" H 2750 1600 50  0001 C CNN
F 1 "GND" H 2755 1677 50  0000 C CNN
F 2 "" H 2750 1850 50  0001 C CNN
F 3 "" H 2750 1850 50  0001 C CNN
	1    2750 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 1850 2750 1750
$Comp
L Device:C_Small C3
U 1 1 5BF19902
P 3850 1650
F 0 "C3" H 3942 1696 50  0000 L CNN
F 1 "22uF/16V" V 3700 1400 50  0000 L CNN
F 2 "Capacitor_SMD:CP_Elec_6.3x5.3" H 3850 1650 50  0001 C CNN
F 3 "~" H 3850 1650 50  0001 C CNN
	1    3850 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5BF1994C
P 3850 1950
F 0 "#PWR0106" H 3850 1700 50  0001 C CNN
F 1 "GND" H 3855 1777 50  0000 C CNN
F 2 "" H 3850 1950 50  0001 C CNN
F 3 "" H 3850 1950 50  0001 C CNN
	1    3850 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 1950 3850 1750
Wire Wire Line
	3850 1550 3850 1500
Connection ~ 3850 1500
$Comp
L power:+5V #PWR0107
U 1 1 5BF19BD2
P 9100 2800
F 0 "#PWR0107" H 9100 2650 50  0001 C CNN
F 1 "+5V" V 9115 2928 50  0000 L CNN
F 2 "" H 9100 2800 50  0001 C CNN
F 3 "" H 9100 2800 50  0001 C CNN
	1    9100 2800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5BF19BED
P 9350 3250
F 0 "#PWR0108" H 9350 3000 50  0001 C CNN
F 1 "GND" H 9355 3077 50  0000 C CNN
F 2 "" H 9350 3250 50  0001 C CNN
F 3 "" H 9350 3250 50  0001 C CNN
	1    9350 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3200 9350 3200
Wire Wire Line
	9350 3200 9350 3250
Wire Wire Line
	9400 2800 9100 2800
$Comp
L Device:C_Small C5
U 1 1 5BF1A0B2
P 10200 2500
F 0 "C5" H 10108 2454 50  0000 R CNN
F 1 "100n" H 10108 2545 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 10200 2500 50  0001 C CNN
F 3 "~" H 10200 2500 50  0001 C CNN
	1    10200 2500
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0109
U 1 1 5BF1A16B
P 10200 2400
F 0 "#PWR0109" H 10200 2250 50  0001 C CNN
F 1 "+5V" H 10215 2573 50  0000 C CNN
F 2 "" H 10200 2400 50  0001 C CNN
F 3 "" H 10200 2400 50  0001 C CNN
	1    10200 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5BF1A191
P 10200 2600
F 0 "#PWR0110" H 10200 2350 50  0001 C CNN
F 1 "GND" H 10205 2427 50  0000 C CNN
F 2 "" H 10200 2600 50  0001 C CNN
F 3 "" H 10200 2600 50  0001 C CNN
	1    10200 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 5BF1A510
P 6450 2100
F 0 "C4" H 6358 2054 50  0000 R CNN
F 1 "100n" H 6358 2145 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 6450 2100 50  0001 C CNN
F 3 "~" H 6450 2100 50  0001 C CNN
	1    6450 2100
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 5BF1A516
P 6450 2000
F 0 "#PWR0111" H 6450 1850 50  0001 C CNN
F 1 "+5V" H 6465 2173 50  0000 C CNN
F 2 "" H 6450 2000 50  0001 C CNN
F 3 "" H 6450 2000 50  0001 C CNN
	1    6450 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 5BF1A51C
P 6450 2200
F 0 "#PWR0112" H 6450 1950 50  0001 C CNN
F 1 "GND" H 6455 2027 50  0000 C CNN
F 2 "" H 6450 2200 50  0001 C CNN
F 3 "" H 6450 2200 50  0001 C CNN
	1    6450 2200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0113
U 1 1 5BF1A5EF
P 6100 2350
F 0 "#PWR0113" H 6100 2200 50  0001 C CNN
F 1 "+5V" H 6115 2523 50  0000 C CNN
F 2 "" H 6100 2350 50  0001 C CNN
F 3 "" H 6100 2350 50  0001 C CNN
	1    6100 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 5BF1A60E
P 6000 4350
F 0 "#PWR0114" H 6000 4100 50  0001 C CNN
F 1 "GND" H 6005 4177 50  0000 C CNN
F 2 "" H 6000 4350 50  0001 C CNN
F 3 "" H 6000 4350 50  0001 C CNN
	1    6000 4350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5BF1A62D
P 5900 4350
F 0 "#PWR0115" H 5900 4100 50  0001 C CNN
F 1 "GND" H 5905 4177 50  0000 C CNN
F 2 "" H 5900 4350 50  0001 C CNN
F 3 "" H 5900 4350 50  0001 C CNN
	1    5900 4350
	1    0    0    -1  
$EndComp
Text GLabel 9050 4850 0    50   Input ~ 0
scaleCLK
Text GLabel 9050 4750 0    50   Input ~ 0
scaleDATA
Text Notes 9200 2200 0    50   ~ 0
To barcode scanner. \nPS2 interface
Text GLabel 5400 3250 0    50   Input ~ 0
scaleCLK
Text GLabel 5400 3150 0    50   Input ~ 0
scaleDATA
Wire Wire Line
	5400 2950 5300 2950
Wire Wire Line
	5400 3050 5300 3050
Wire Wire Line
	9950 4550 9850 4550
Wire Wire Line
	9950 4650 9850 4650
Wire Wire Line
	9950 4750 9850 4750
Wire Wire Line
	9950 4850 9850 4850
$Comp
L power:+5V #PWR0116
U 1 1 5BF1B326
P 9050 4950
F 0 "#PWR0116" H 9050 4800 50  0001 C CNN
F 1 "+5V" H 9065 5123 50  0000 C CNN
F 2 "" H 9050 4950 50  0001 C CNN
F 3 "" H 9050 4950 50  0001 C CNN
	1    9050 4950
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5BF1B36D
P 9050 4650
F 0 "#PWR0117" H 9050 4400 50  0001 C CNN
F 1 "GND" H 9055 4477 50  0000 C CNN
F 2 "" H 9050 4650 50  0001 C CNN
F 3 "" H 9050 4650 50  0001 C CNN
	1    9050 4650
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C7
U 1 1 5BF1B4FA
P 10400 4750
F 0 "C7" H 10308 4704 50  0000 R CNN
F 1 "100n" H 10308 4795 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 10400 4750 50  0001 C CNN
F 3 "~" H 10400 4750 50  0001 C CNN
	1    10400 4750
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0118
U 1 1 5BF1B500
P 10400 4650
F 0 "#PWR0118" H 10400 4500 50  0001 C CNN
F 1 "+5V" H 10415 4823 50  0000 C CNN
F 2 "" H 10400 4650 50  0001 C CNN
F 3 "" H 10400 4650 50  0001 C CNN
	1    10400 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 5BF1B506
P 10400 4850
F 0 "#PWR0119" H 10400 4600 50  0001 C CNN
F 1 "GND" H 10405 4677 50  0000 C CNN
F 2 "" H 10400 4850 50  0001 C CNN
F 3 "" H 10400 4850 50  0001 C CNN
	1    10400 4850
	1    0    0    -1  
$EndComp
Text GLabel 9400 2900 0    50   Input ~ 0
scannerCLK
Text GLabel 9400 2500 0    50   Input ~ 0
scannerDATA
Text GLabel 5300 3050 0    50   Input ~ 0
scannerDATA
Text GLabel 5300 2950 0    50   Input ~ 0
scannerCLK
Text GLabel 5400 1150 3    50   Input ~ 0
SDA
Text GLabel 5300 1150 3    50   Input ~ 0
SCL
Text GLabel 6400 3750 2    50   Input ~ 0
SDA
Text GLabel 6400 3850 2    50   Input ~ 0
SCL
$Comp
L power:+5V #PWR0120
U 1 1 5BF1D8E1
P 5000 750
F 0 "#PWR0120" H 5000 600 50  0001 C CNN
F 1 "+5V" H 5015 923 50  0000 C CNN
F 2 "" H 5000 750 50  0001 C CNN
F 3 "" H 5000 750 50  0001 C CNN
	1    5000 750 
	1    0    0    -1  
$EndComp
$Comp
L Peters:ROTARY-ENCODER-Ebay ROT1
U 1 1 5BF1E930
P 6850 950
F 0 "ROT1" H 6850 650 60  0000 C CNN
F 1 "ROTARY-ENCODER-Ebay" H 6900 400 60  0000 C CNN
F 2 "Libs:ROTARY-ENCODER-Ebay" H 6850 950 60  0001 C CNN
F 3 "" H 6850 950 60  0000 C CNN
	1    6850 950 
	1    0    0    -1  
$EndComp
Text GLabel 6400 850  0    50   Input ~ 0
BTN
$Comp
L power:GND #PWR0121
U 1 1 5BF1F58D
P 6500 1050
F 0 "#PWR0121" H 6500 800 50  0001 C CNN
F 1 "GND" H 6505 877 50  0000 C CNN
F 2 "" H 6500 1050 50  0001 C CNN
F 3 "" H 6500 1050 50  0001 C CNN
	1    6500 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Network05 RN1
U 1 1 5BF1F93C
P 5200 950
F 0 "RN1" H 5480 996 50  0000 L CNN
F 1 "R_Network05" H 5480 905 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP6" V 5575 950 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5200 950 50  0001 C CNN
	1    5200 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 5BF209E0
P 7200 950
F 0 "#PWR0122" H 7200 700 50  0001 C CNN
F 1 "GND" H 7200 800 50  0000 C CNN
F 2 "" H 7200 950 50  0001 C CNN
F 3 "" H 7200 950 50  0001 C CNN
	1    7200 950 
	0    -1   -1   0   
$EndComp
Text GLabel 7200 850  2    50   Input ~ 0
ENCA
Text GLabel 7200 1050 2    50   Input ~ 0
ENCB
Text GLabel 3950 3450 0    50   Input ~ 0
BTN
Text GLabel 3950 3750 0    50   Input ~ 0
ENCB
Text GLabel 3950 4050 0    50   Input ~ 0
ENCA
Wire Wire Line
	6400 850  6500 850 
Text GLabel 5200 1150 3    50   Input ~ 0
ENCA
Text GLabel 5100 1150 3    50   Input ~ 0
ENCB
Text GLabel 5000 1150 3    50   Input ~ 0
BTN
$Comp
L 74xx:74HC14 U2
U 1 1 5BF2790A
P 4250 3450
F 0 "U2" H 4200 3450 50  0000 C CNN
F 1 "74HC14" H 4500 3600 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4250 3450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4250 3450 50  0001 C CNN
	1    4250 3450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U2
U 2 1 5BF27975
P 4250 3750
F 0 "U2" H 4200 3750 50  0000 C CNN
F 1 "74HC14" H 4500 3850 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4250 3750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4250 3750 50  0001 C CNN
	2    4250 3750
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U2
U 3 1 5BF279D0
P 4250 4050
F 0 "U2" H 4200 4050 50  0000 C CNN
F 1 "74HC14" H 4450 4200 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 4250 4050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 4250 4050 50  0001 C CNN
	3    4250 4050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC14 U2
U 7 1 5BF27C5B
P 3250 3750
F 0 "U2" H 3350 4150 50  0000 L CNN
F 1 "74HC14" V 2950 3600 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 3250 3750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC14" H 3250 3750 50  0001 C CNN
	7    3250 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 5BF282CE
P 2500 3750
F 0 "C2" H 2408 3704 50  0000 R CNN
F 1 "100n" H 2408 3795 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2500 3750 50  0001 C CNN
F 3 "~" H 2500 3750 50  0001 C CNN
	1    2500 3750
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0123
U 1 1 5BF282D4
P 2500 3650
F 0 "#PWR0123" H 2500 3500 50  0001 C CNN
F 1 "+5V" H 2515 3823 50  0000 C CNN
F 2 "" H 2500 3650 50  0001 C CNN
F 3 "" H 2500 3650 50  0001 C CNN
	1    2500 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 5BF282DA
P 2500 3850
F 0 "#PWR0124" H 2500 3600 50  0001 C CNN
F 1 "GND" H 2505 3677 50  0000 C CNN
F 2 "" H 2500 3850 50  0001 C CNN
F 3 "" H 2500 3850 50  0001 C CNN
	1    2500 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0125
U 1 1 5BF284BD
P 3250 3250
F 0 "#PWR0125" H 3250 3100 50  0001 C CNN
F 1 "+5V" H 3265 3423 50  0000 C CNN
F 2 "" H 3250 3250 50  0001 C CNN
F 3 "" H 3250 3250 50  0001 C CNN
	1    3250 3250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 5BF284EC
P 3250 4250
F 0 "#PWR0126" H 3250 4000 50  0001 C CNN
F 1 "GND" H 3255 4077 50  0000 C CNN
F 2 "" H 3250 4250 50  0001 C CNN
F 3 "" H 3250 4250 50  0001 C CNN
	1    3250 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 3350 4550 3350
Wire Wire Line
	4550 3350 4550 3450
Wire Wire Line
	4550 3750 4700 3750
Wire Wire Line
	4700 3750 4700 3450
Wire Wire Line
	4700 3450 5400 3450
Wire Wire Line
	5400 3550 4750 3550
Wire Wire Line
	4750 3550 4750 4050
Wire Wire Line
	4750 4050 4550 4050
$Comp
L Connector_Generic:Conn_01x04 J5
U 1 1 5BF29DA8
P 9850 5800
F 0 "J5" H 9930 5792 50  0000 L CNN
F 1 "i2cLCD" H 9930 5701 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_bornier-4_P5.08mm" H 9850 5800 50  0001 C CNN
F 3 "~" H 9850 5800 50  0001 C CNN
	1    9850 5800
	1    0    0    -1  
$EndComp
Text GLabel 9650 5900 0    50   Input ~ 0
SDA
Text GLabel 9650 6000 0    50   Input ~ 0
SCL
$Comp
L Device:C_Small C6
U 1 1 5BF2A168
P 10300 5900
F 0 "C6" H 10208 5854 50  0000 R CNN
F 1 "100n" H 10208 5945 50  0000 R CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 10300 5900 50  0001 C CNN
F 3 "~" H 10300 5900 50  0001 C CNN
	1    10300 5900
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 5BF2A16E
P 10300 5800
F 0 "#PWR0127" H 10300 5650 50  0001 C CNN
F 1 "+5V" H 10315 5973 50  0000 C CNN
F 2 "" H 10300 5800 50  0001 C CNN
F 3 "" H 10300 5800 50  0001 C CNN
	1    10300 5800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 5BF2A174
P 10300 6000
F 0 "#PWR0128" H 10300 5750 50  0001 C CNN
F 1 "GND" H 10305 5827 50  0000 C CNN
F 2 "" H 10300 6000 50  0001 C CNN
F 3 "" H 10300 6000 50  0001 C CNN
	1    10300 6000
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0129
U 1 1 5BF2A57D
P 9650 5800
F 0 "#PWR0129" H 9650 5650 50  0001 C CNN
F 1 "+5V" V 9665 5928 50  0000 L CNN
F 2 "" H 9650 5800 50  0001 C CNN
F 3 "" H 9650 5800 50  0001 C CNN
	1    9650 5800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 5BF2A5B0
P 9650 5700
F 0 "#PWR0130" H 9650 5450 50  0001 C CNN
F 1 "GND" H 9655 5527 50  0000 C CNN
F 2 "" H 9650 5700 50  0001 C CNN
F 3 "" H 9650 5700 50  0001 C CNN
	1    9650 5700
	0    1    1    0   
$EndComp
Wire Notes Line
	9300 5450 10750 5450
Wire Notes Line
	10750 5450 10750 6350
Wire Notes Line
	10750 6350 9300 6350
Wire Notes Line
	9300 6350 9300 5450
Text Notes 10550 5600 0    50   ~ 0
DISP
Wire Notes Line
	8450 4200 10750 4200
Wire Notes Line
	10750 4200 10750 5350
Wire Notes Line
	10750 5350 8450 5350
Wire Notes Line
	8450 5350 8450 4200
Text Notes 10050 4350 0    50   ~ 0
Scale interface
Wire Notes Line
	10650 1850 10650 3750
Wire Notes Line
	10650 3750 8700 3750
Wire Notes Line
	8700 3750 8700 1850
Wire Notes Line
	8700 1850 10650 1850
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 5BF369C1
P 1050 6500
F 0 "J2" H 970 6075 50  0000 C CNN
F 1 "Lamp outputs" V 1200 6450 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_bornier-4_P5.08mm" H 1050 6500 50  0001 C CNN
F 3 "~" H 1050 6500 50  0001 C CNN
	1    1050 6500
	-1   0    0    1   
$EndComp
$Comp
L Device:Fuse_Small F1
U 1 1 5BF3BAF0
P 2150 1500
F 0 "F1" H 2150 1685 50  0000 C CNN
F 1 "30V/1100mA" H 2200 1400 50  0000 C CNN
F 2 "Fuse:Fuse_2920_7451Metric_Pad2.10x5.45mm_HandSolder" H 2150 1500 50  0001 C CNN
F 3 "~" H 2150 1500 50  0001 C CNN
	1    2150 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 1700 2400 1700
Wire Wire Line
	1950 1500 2050 1500
$Comp
L Connector:DB9_Male_MountingHoles J4
U 1 1 5BF3F8D9
P 9700 2800
F 0 "J4" H 9880 2803 50  0000 L CNN
F 1 "ToScanner" H 9880 2712 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-9_Female_Horizontal_P2.77x2.84mm_EdgePinOffset7.70mm_Housed_MountingHolesOffset9.12mm" H 9700 2800 50  0001 C CNN
F 3 " ~" H 9700 2800 50  0001 C CNN
	1    9700 2800
	1    0    0    -1  
$EndComp
Text GLabel 5400 3850 0    50   Input ~ 0
L3
Text GLabel 5400 3750 0    50   Input ~ 0
L2
Text GLabel 5400 3650 0    50   Input ~ 0
L1
$Comp
L Device:R_Network05 RN2
U 1 1 5BFD66A0
P 950 3850
F 0 "RN2" H 1230 3896 50  0000 L CNN
F 1 "R_Network05" H 1230 3805 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP6" V 1325 3850 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 950 3850 50  0001 C CNN
	1    950  3850
	1    0    0    -1  
$EndComp
$Comp
L Peters:IRF7306TRPBF Q1
U 1 1 5BFE0558
P 1350 5300
F 0 "Q1" H 1556 5254 50  0000 L CNN
F 1 "IRF7306TRPBF" V 1600 5400 50  0000 L CNN
F 2 "Package_SO:SO-8_5.3x6.2mm_P1.27mm" H 1850 5250 50  0001 C CNN
F 3 "http://192.168.0.101/api/part_attachments/1126/getFile" H 1950 5350 50  0001 C CNN
	1    1350 5300
	-1   0    0    1   
$EndComp
$Comp
L dk_Transistors-FETs-MOSFETs-Single:BSS138 Q2
U 1 1 5BFE105C
P 1700 5600
F 0 "Q2" H 1808 5547 60  0000 L CNN
F 1 "BSS138" V 1500 5050 60  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 1900 5800 60  0001 L CNN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 1900 5900 60  0001 L CNN
F 4 "BSS138CT-ND" H 1900 6000 60  0001 L CNN "Digi-Key_PN"
F 5 "BSS138" H 1900 6100 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 1900 6200 60  0001 L CNN "Category"
F 7 "Transistors - FETs, MOSFETs - Single" H 1900 6300 60  0001 L CNN "Family"
F 8 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 1900 6400 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/BSS138/BSS138CT-ND/244294" H 1900 6500 60  0001 L CNN "DK_Detail_Page"
F 10 "MOSFET N-CH 50V 220MA SOT-23" H 1900 6600 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 1900 6700 60  0001 L CNN "Manufacturer"
F 12 "Active" H 1900 6800 60  0001 L CNN "Status"
	1    1700 5600
	-1   0    0    1   
$EndComp
Text GLabel 5400 3950 0    50   Input ~ 0
L4
Text GLabel 5400 4050 0    50   Input ~ 0
Buzzer
$Comp
L power:+24V #PWR0131
U 1 1 5BFE6C81
P 1250 5100
F 0 "#PWR0131" H 1250 4950 50  0001 C CNN
F 1 "+24V" H 1265 5273 50  0000 C CNN
F 2 "" H 1250 5100 50  0001 C CNN
F 3 "" H 1250 5100 50  0001 C CNN
	1    1250 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0132
U 1 1 5BFE7180
P 1700 5850
F 0 "#PWR0132" H 1700 5600 50  0001 C CNN
F 1 "GND" H 1705 5677 50  0000 C CNN
F 2 "" H 1700 5850 50  0001 C CNN
F 3 "" H 1700 5850 50  0001 C CNN
	1    1700 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 5850 1700 5800
Wire Wire Line
	1500 5300 1700 5300
Wire Wire Line
	1700 5300 1700 5400
Wire Wire Line
	1700 5300 1700 5200
Connection ~ 1700 5300
Text GLabel 1700 5200 1    50   Input ~ 0
PullupsL1
$Comp
L power:+24V #PWR0133
U 1 1 5BFE9747
P 750 3650
F 0 "#PWR0133" H 750 3500 50  0001 C CNN
F 1 "+24V" H 765 3823 50  0000 C CNN
F 2 "" H 750 3650 50  0001 C CNN
F 3 "" H 750 3650 50  0001 C CNN
	1    750  3650
	1    0    0    -1  
$EndComp
Text GLabel 2050 5500 2    50   Input ~ 0
L1
Wire Wire Line
	2050 5500 2000 5500
$Comp
L Device:R_Network05 RN3
U 1 1 5BFEB8FF
P 1000 3200
F 0 "RN3" H 1280 3246 50  0000 L CNN
F 1 "R_Network05" H 1280 3155 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP6" V 1375 3200 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 1000 3200 50  0001 C CNN
	1    1000 3200
	-1   0    0    1   
$EndComp
Text GLabel 750  4050 3    50   Input ~ 0
PullupsL1
$Comp
L power:GND #PWR0134
U 1 1 5BFEBBC9
P 1200 3400
F 0 "#PWR0134" H 1200 3150 50  0001 C CNN
F 1 "GND" H 1205 3227 50  0000 C CNN
F 2 "" H 1200 3400 50  0001 C CNN
F 3 "" H 1200 3400 50  0001 C CNN
	1    1200 3400
	1    0    0    -1  
$EndComp
Text GLabel 800  3000 1    50   Input ~ 0
PullDownsL1
Wire Wire Line
	1250 5500 1250 6300
$Comp
L Peters:IRF7306TRPBF Q1
U 2 1 5BFF0148
P 2550 5250
F 0 "Q1" H 2756 5204 50  0000 L CNN
F 1 "IRF7306TRPBF" V 2800 5350 50  0000 L CNN
F 2 "Package_SO:SO-8_5.3x6.2mm_P1.27mm" H 3050 5200 50  0001 C CNN
F 3 "http://192.168.0.101/api/part_attachments/1126/getFile" H 3150 5300 50  0001 C CNN
	2    2550 5250
	-1   0    0    1   
$EndComp
$Comp
L dk_Transistors-FETs-MOSFETs-Single:BSS138 Q3
U 1 1 5BFF0158
P 2900 5550
F 0 "Q3" H 3008 5497 60  0000 L CNN
F 1 "BSS138" V 2750 5000 60  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 3100 5750 60  0001 L CNN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 3100 5850 60  0001 L CNN
F 4 "BSS138CT-ND" H 3100 5950 60  0001 L CNN "Digi-Key_PN"
F 5 "BSS138" H 3100 6050 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 3100 6150 60  0001 L CNN "Category"
F 7 "Transistors - FETs, MOSFETs - Single" H 3100 6250 60  0001 L CNN "Family"
F 8 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 3100 6350 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/BSS138/BSS138CT-ND/244294" H 3100 6450 60  0001 L CNN "DK_Detail_Page"
F 10 "MOSFET N-CH 50V 220MA SOT-23" H 3100 6550 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 3100 6650 60  0001 L CNN "Manufacturer"
F 12 "Active" H 3100 6750 60  0001 L CNN "Status"
	1    2900 5550
	-1   0    0    1   
$EndComp
$Comp
L power:+24V #PWR0135
U 1 1 5BFF015F
P 2450 5050
F 0 "#PWR0135" H 2450 4900 50  0001 C CNN
F 1 "+24V" H 2465 5223 50  0000 C CNN
F 2 "" H 2450 5050 50  0001 C CNN
F 3 "" H 2450 5050 50  0001 C CNN
	1    2450 5050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 5BFF0165
P 2900 5800
F 0 "#PWR0136" H 2900 5550 50  0001 C CNN
F 1 "GND" H 2905 5627 50  0000 C CNN
F 2 "" H 2900 5800 50  0001 C CNN
F 3 "" H 2900 5800 50  0001 C CNN
	1    2900 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 5800 2900 5750
Wire Wire Line
	2700 5250 2900 5250
Wire Wire Line
	2900 5250 2900 5350
Wire Wire Line
	2900 5250 2900 5150
Connection ~ 2900 5250
Text GLabel 2900 5150 1    50   Input ~ 0
PullupsL2
Text GLabel 3250 5450 2    50   Input ~ 0
L2
Wire Wire Line
	3250 5450 3200 5450
Wire Wire Line
	1250 6400 2450 6400
Wire Wire Line
	2450 5450 2450 6400
$Comp
L Peters:IRF7306TRPBF Q4
U 1 1 5BFF2D52
P 3700 5250
F 0 "Q4" H 3906 5204 50  0000 L CNN
F 1 "IRF7306TRPBF" V 3906 5295 50  0000 L CNN
F 2 "Package_SO:SO-8_5.3x6.2mm_P1.27mm" H 4200 5200 50  0001 C CNN
F 3 "http://192.168.0.101/api/part_attachments/1126/getFile" H 4300 5300 50  0001 C CNN
	1    3700 5250
	-1   0    0    1   
$EndComp
$Comp
L dk_Transistors-FETs-MOSFETs-Single:BSS138 Q5
U 1 1 5BFF2D62
P 4050 5550
F 0 "Q5" H 4158 5497 60  0000 L CNN
F 1 "BSS138" V 3850 5050 60  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 4250 5750 60  0001 L CNN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 4250 5850 60  0001 L CNN
F 4 "BSS138CT-ND" H 4250 5950 60  0001 L CNN "Digi-Key_PN"
F 5 "BSS138" H 4250 6050 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 4250 6150 60  0001 L CNN "Category"
F 7 "Transistors - FETs, MOSFETs - Single" H 4250 6250 60  0001 L CNN "Family"
F 8 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 4250 6350 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/BSS138/BSS138CT-ND/244294" H 4250 6450 60  0001 L CNN "DK_Detail_Page"
F 10 "MOSFET N-CH 50V 220MA SOT-23" H 4250 6550 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 4250 6650 60  0001 L CNN "Manufacturer"
F 12 "Active" H 4250 6750 60  0001 L CNN "Status"
	1    4050 5550
	-1   0    0    1   
$EndComp
$Comp
L power:+24V #PWR0137
U 1 1 5BFF2D69
P 3600 5050
F 0 "#PWR0137" H 3600 4900 50  0001 C CNN
F 1 "+24V" H 3615 5223 50  0000 C CNN
F 2 "" H 3600 5050 50  0001 C CNN
F 3 "" H 3600 5050 50  0001 C CNN
	1    3600 5050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0138
U 1 1 5BFF2D6F
P 4050 5800
F 0 "#PWR0138" H 4050 5550 50  0001 C CNN
F 1 "GND" H 4055 5627 50  0000 C CNN
F 2 "" H 4050 5800 50  0001 C CNN
F 3 "" H 4050 5800 50  0001 C CNN
	1    4050 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 5800 4050 5750
Wire Wire Line
	3850 5250 4050 5250
Wire Wire Line
	4050 5250 4050 5350
Wire Wire Line
	4050 5250 4050 5150
Connection ~ 4050 5250
Text GLabel 4050 5150 1    50   Input ~ 0
PullupsL3
Text GLabel 4400 5450 2    50   Input ~ 0
L3
Wire Wire Line
	4400 5450 4350 5450
Wire Wire Line
	1250 6500 3600 6500
Wire Wire Line
	3600 5450 3600 6500
$Comp
L Peters:IRF7306TRPBF Q4
U 2 1 5BFF4A02
P 4800 5200
F 0 "Q4" H 5006 5154 50  0000 L CNN
F 1 "IRF7306TRPBF" V 5006 5245 50  0000 L CNN
F 2 "Package_SO:SO-8_5.3x6.2mm_P1.27mm" H 5300 5150 50  0001 C CNN
F 3 "http://192.168.0.101/api/part_attachments/1126/getFile" H 5400 5250 50  0001 C CNN
	2    4800 5200
	-1   0    0    1   
$EndComp
$Comp
L dk_Transistors-FETs-MOSFETs-Single:BSS138 Q6
U 1 1 5BFF4A12
P 5150 5500
F 0 "Q6" H 5258 5447 60  0000 L CNN
F 1 "BSS138" V 4950 4950 60  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 5350 5700 60  0001 L CNN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 5350 5800 60  0001 L CNN
F 4 "BSS138CT-ND" H 5350 5900 60  0001 L CNN "Digi-Key_PN"
F 5 "BSS138" H 5350 6000 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 5350 6100 60  0001 L CNN "Category"
F 7 "Transistors - FETs, MOSFETs - Single" H 5350 6200 60  0001 L CNN "Family"
F 8 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 5350 6300 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/BSS138/BSS138CT-ND/244294" H 5350 6400 60  0001 L CNN "DK_Detail_Page"
F 10 "MOSFET N-CH 50V 220MA SOT-23" H 5350 6500 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 5350 6600 60  0001 L CNN "Manufacturer"
F 12 "Active" H 5350 6700 60  0001 L CNN "Status"
	1    5150 5500
	-1   0    0    1   
$EndComp
$Comp
L power:+24V #PWR0139
U 1 1 5BFF4A19
P 4700 5000
F 0 "#PWR0139" H 4700 4850 50  0001 C CNN
F 1 "+24V" H 4715 5173 50  0000 C CNN
F 2 "" H 4700 5000 50  0001 C CNN
F 3 "" H 4700 5000 50  0001 C CNN
	1    4700 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0140
U 1 1 5BFF4A1F
P 5150 5750
F 0 "#PWR0140" H 5150 5500 50  0001 C CNN
F 1 "GND" H 5155 5577 50  0000 C CNN
F 2 "" H 5150 5750 50  0001 C CNN
F 3 "" H 5150 5750 50  0001 C CNN
	1    5150 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 5750 5150 5700
Wire Wire Line
	4950 5200 5150 5200
Wire Wire Line
	5150 5200 5150 5300
Wire Wire Line
	5150 5200 5150 5100
Connection ~ 5150 5200
Text GLabel 5150 5100 1    50   Input ~ 0
PullupsL4
Text GLabel 5500 5400 2    50   Input ~ 0
L4
Wire Wire Line
	5500 5400 5450 5400
Wire Wire Line
	1250 6600 4700 6600
Wire Wire Line
	4700 5400 4700 6600
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 5BFF735A
P 1050 7000
F 0 "J3" H 970 6575 50  0000 C CNN
F 1 "Lamp outputs" V 1200 6950 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_bornier-4_P5.08mm" H 1050 7000 50  0001 C CNN
F 3 "~" H 1050 7000 50  0001 C CNN
	1    1050 7000
	-1   0    0    1   
$EndComp
$Comp
L Peters:IRF7306TRPBF Q7
U 1 1 5BFF780A
P 6150 5450
F 0 "Q7" H 6356 5404 50  0000 L CNN
F 1 "IRF7306TRPBF" V 6356 5495 50  0000 L CNN
F 2 "Package_SO:SO-8_5.3x6.2mm_P1.27mm" H 6650 5400 50  0001 C CNN
F 3 "http://192.168.0.101/api/part_attachments/1126/getFile" H 6750 5500 50  0001 C CNN
	1    6150 5450
	-1   0    0    1   
$EndComp
$Comp
L dk_Transistors-FETs-MOSFETs-Single:BSS138 Q8
U 1 1 5BFF781A
P 6500 5750
F 0 "Q8" H 6608 5697 60  0000 L CNN
F 1 "BSS138" V 6300 5200 60  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 6700 5950 60  0001 L CNN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 6700 6050 60  0001 L CNN
F 4 "BSS138CT-ND" H 6700 6150 60  0001 L CNN "Digi-Key_PN"
F 5 "BSS138" H 6700 6250 60  0001 L CNN "MPN"
F 6 "Discrete Semiconductor Products" H 6700 6350 60  0001 L CNN "Category"
F 7 "Transistors - FETs, MOSFETs - Single" H 6700 6450 60  0001 L CNN "Family"
F 8 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 6700 6550 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/BSS138/BSS138CT-ND/244294" H 6700 6650 60  0001 L CNN "DK_Detail_Page"
F 10 "MOSFET N-CH 50V 220MA SOT-23" H 6700 6750 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 6700 6850 60  0001 L CNN "Manufacturer"
F 12 "Active" H 6700 6950 60  0001 L CNN "Status"
	1    6500 5750
	-1   0    0    1   
$EndComp
$Comp
L power:+24V #PWR0141
U 1 1 5BFF7821
P 6050 5250
F 0 "#PWR0141" H 6050 5100 50  0001 C CNN
F 1 "+24V" H 6065 5423 50  0000 C CNN
F 2 "" H 6050 5250 50  0001 C CNN
F 3 "" H 6050 5250 50  0001 C CNN
	1    6050 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0142
U 1 1 5BFF7827
P 6500 6000
F 0 "#PWR0142" H 6500 5750 50  0001 C CNN
F 1 "GND" H 6505 5827 50  0000 C CNN
F 2 "" H 6500 6000 50  0001 C CNN
F 3 "" H 6500 6000 50  0001 C CNN
	1    6500 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 6000 6500 5950
Wire Wire Line
	6300 5450 6500 5450
Wire Wire Line
	6500 5450 6500 5550
Wire Wire Line
	6500 5450 6500 5350
Connection ~ 6500 5450
Text GLabel 6500 5350 1    50   Input ~ 0
PullupsBuzzer
Wire Wire Line
	6850 5650 6800 5650
Wire Wire Line
	1250 6800 6050 6800
Wire Wire Line
	6050 5650 6050 6800
$Comp
L power:GND #PWR0143
U 1 1 5BFFA1EC
P 1400 6950
F 0 "#PWR0143" H 1400 6700 50  0001 C CNN
F 1 "GND" H 1405 6777 50  0000 C CNN
F 2 "" H 1400 6950 50  0001 C CNN
F 3 "" H 1400 6950 50  0001 C CNN
	1    1400 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 6950 1400 6900
Wire Wire Line
	1400 6900 1250 6900
Text GLabel 850  4050 3    50   Input ~ 0
PullupsL2
Text GLabel 2000 5650 3    50   Input ~ 0
PullDownsL1
Wire Wire Line
	2000 5500 2000 5650
Connection ~ 2000 5500
Text GLabel 3200 5600 3    50   Input ~ 0
PullDownsL2
Wire Wire Line
	3200 5600 3200 5450
Connection ~ 3200 5450
Text GLabel 950  4050 3    50   Input ~ 0
PullupsL3
Text GLabel 900  3000 1    50   Input ~ 0
PullDownsL2
Text GLabel 4350 5600 3    50   Input ~ 0
PullDownsL3
Wire Wire Line
	4350 5600 4350 5450
Connection ~ 4350 5450
Text GLabel 5450 5500 3    50   Input ~ 0
PullDownsL4
Wire Wire Line
	5450 5500 5450 5400
Connection ~ 5450 5400
Text GLabel 6800 5750 3    50   Input ~ 0
PullDownsBuzzer
Wire Wire Line
	6800 5750 6800 5650
Connection ~ 6800 5650
Text GLabel 6850 5650 2    50   Input ~ 0
Buzzer
Text GLabel 1050 4050 3    50   Input ~ 0
PullupsL4
Text GLabel 1150 4050 3    50   Input ~ 0
PullupsBuzzer
Text GLabel 1000 3000 1    50   Input ~ 0
PullDownsL3
Text GLabel 1100 3000 1    50   Input ~ 0
PullDownsL4
Text GLabel 1200 3000 1    50   Input ~ 0
PullDownsBuzzer
$EndSCHEMATC
