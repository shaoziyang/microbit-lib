from microbit import *
import APDS9930

apds = APDS9930.APDS9930()
apds.Proximity_Enable()

while True:
    sleep(500)
    apds.getProximity()
