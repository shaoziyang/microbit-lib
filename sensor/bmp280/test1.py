'''
    BMP280 demo

    Author: shaoziyang
    Date:   2018.2

    http://www.micropython.org.cn

'''
from microbit import *
import bmp280

b = bmp280.BMP280()

while True:
    sleep(500)
    b.get()
