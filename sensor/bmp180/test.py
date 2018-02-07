'''
    BMP180 demo

    Author: shaoziyang
    Date:   2018.2

    http://www.micropython.org.cn

'''
from microbit import *

import bmp180

b = bmp180.BMP180()

while True:
    sleep(500)
    b.get()
