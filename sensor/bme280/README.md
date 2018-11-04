# BME280 humidity and pressure sensor

![](bme280.jpg)

## I2C Address

I2C Address depend SDO, defult address is:

**0x76**

When SDO is high address is:

**0x77**

## API

* **get()**  
get envirment temperature, pressure and humidity  

* **Temperature()**  
get envirment temperature 

* **Pressure()**  
get Pressure

* **Humidity()**  
get Humidity

* **Altitude()**  
Calculating absolute altitude

* **poweron()**  
goto normal mode

* **poweroff()**  
goto sleep mode

## example


```
from microbit import *
import bme280

b = bme280.BME280()

while 1:
    print(b.get())
    sleep(1000)

```

From microbit/micropython Chinese community.  
www.micropython.org.cn
