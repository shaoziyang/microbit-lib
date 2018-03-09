'''
    DS1307 demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn
'''
import DS1307

ds = DS1307.DS1307()

ds.DateTime()
ds.DateTime([2018, 3, 9, 4, 23, 0, 1, 0])

ds.Hour()
