'''
    Four Digit Display demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn

'''
from microbit import *
import FourDigitDisplay

fdd = FourDigitDisplay.FourDigitDisplay()

n = 0
while 1:
    fdd.shownum(n)
    n += 1
    sleep(1000)
