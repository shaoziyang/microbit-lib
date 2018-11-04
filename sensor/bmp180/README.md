# BMP180 Digital pressure sensor

## I2C Address

**0x77**

## API

* **Temperature()**  
get envirment temperature 

* **Pressure()**  
get Pressure

* **Altitude()**  
Calculating absolute altitude


## example


```
from microbit import *

import bmp180

b = bmp180.BMP180()

while True:
    sleep(500)
    b.get()

```

From microbit/micropython Chinese community.  
www.micropython.org.cn
