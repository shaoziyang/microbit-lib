from microbit import *
import bme280

b = bme280.BME280()

while 1:
    print(b.get())
    sleep(1000)
