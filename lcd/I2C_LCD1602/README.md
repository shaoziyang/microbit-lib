# I2C LCD1602


## link

| microbit | LCD1602 |
|--|--|
| 3V | VCC |
| GND | GND |
| P19/SCL | SCL |
| P20/SDA | SDA |


## internal signal

|LCD1602  | PCF8574A |
|--|--|
|RS  |P0  |
|RW  |P1  |
|E  |P2  |
|BackLight  |P3  |
|Dat  |P4-P7  |

## I2C Address

| PCF8574 | PCF8574A |
|--|--|
| 0x20 | 0x3F |


## API

on()  
: turn on LCD  

off()  
: turn off LCD

backlight(on)  
: 0 turn of backlight  
1 turn on backlight

char(ch, x, y)
: show a character in given position  
x, 0-15  
y, 0-1

puts(s, x, y)
: show a string in given position  
x, 0-15  
y, 0-1


## example

copy mb_i2c_lcd1602.py to microbit using **mu** or copy file content to your python file first.

```
from mb_i2c_lcd1602 import *

l=LCD1620()
l.puts('Hello microbit!')
```

![](file:///W:/Documents/projects/microbit-lib/lcd/I2C_LCD1602/mb_i2c_lcd1602.jpg)