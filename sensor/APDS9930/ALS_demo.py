from microbit import *
import APDS9930

apds = APDS9930.APDS9930()

while True:
    sleep(500)
    apds.getALS()
