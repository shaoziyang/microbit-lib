'''
    DS1302 demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn

'''
from microbit import *
import DS1302

ds = DS1302.DS1302(clk=pin13, dio=pin14, cs=pin15)

ds.DateTime()
ds.DateTime([2018, 3, 9, 4, 23, 0, 1, 0])

ds.Hour()
ds.Second(10)
