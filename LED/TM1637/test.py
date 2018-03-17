'''
    Four Digit Display (TM1637) demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn

'''
from microbit import *
import TM1637

tm=TM1637.TM1637(dio=pin13,clk=pin14)

n = 0
while 1:
    tm.shownum(n)
    n += 1
    time.sleep_ms(1000)
