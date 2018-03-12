'''
    DS3231 demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn
'''
from microbit import *
import DS3231

ds = DS3231.DS3231()

ds.Hour(12)

ds.Time()
ds.Time([12,10,0])

ds.DateTime([2018,3,12,1,22,10,0])

ds.ALARM(12, 20, 10, ds.PER_DISABLE)
ds.ALARM(12, 20, 10, ds.PER_DAY)
ds.ClearALARM()