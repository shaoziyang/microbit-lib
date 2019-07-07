# I2C OLED 128x64 Display drive

I2C OLED 128x64 with 6x8 font module drive.  

Part of the drive base on fizban99's microbit OLED driver:  
https://github.com/fizban99/microbit_ssd1306  


## I2C Addr

Address is 0x3C / 0x3D, default is 0x3C.

## API

* **pixel(x, y, color=1)**  
set pixel in (x, y) using color.  
  **x** range:  
  * 0 - 127,  normal mode

  **y** range:  
  * 0 - 63,  normal mode

* **on()**  
turn on display  

* **off()**  
turn off display  

* **clear（）**  
clear content of the display  

* **invert(v=1)**  
invert display.  

* **draw()**  
redraw screen.  

* **text(x, y, s)**  
show a text string in screen.  
Character size is:  
  * 5 x 8, normal mode  
  * 10 x 16, zoom mode

  **x** range:  
  * 0 - 23,  normal mode
  * 0 - 11,  zoom mode  

  **y** range:  
  * 0 - 7,  normal mode
  * 0 - 3,  zoom mode  

## example

```
from microbit import i2c
from OLED12864_I2C_6x8 import OLED12864_I2C_6x8

oled = OLED12864_I2C_6x8()
oled.clear()
oled.print('12345')
oled.print('abcde', 0)

```


From microbit/micropython Chinese community.  
www.micropython.org.cn
