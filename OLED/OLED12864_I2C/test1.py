'''
    I2C OLED 128x64 demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn

'''
from microbit import *
import oled12864_i2c

oled = oled12864_i2c.OLED12864_I2C()
oled.clear()
oled.rect(0,0,60,30)

n = 0
while 1:
    oled.text(1,1, str(n))
    n+=1
    sleep(200)
