"""
  microbit drive for BMP180 Digital Pressure Sensor

  Author: shaoziyang
  Date:   2018.2

  http://www.micropython.org.cn

"""
from microbit import *

BMP180_I2C_ADDR = 0x77

class BMP180():
  def __init__(self):
    self.AC1 = self.short(self._g2r(0xAA))
    self.AC2 = self.short(self._g2r(0xAC))
    self.AC3 = self.short(self._g2r(0xAE))
    self.AC4 = self._g2r(0xB0)
    self.AC5 = self._g2r(0xB2)
    self.AC6 = self._g2r(0xB4)
    self.B1 = self.short(self._g2r(0xB6))
    self.B2 = self.short(self._g2r(0xB8))
    self.MB = self.short(self._g2r(0xBA))
    self.MC = self.short(self._g2r(0xBC))
    self.MD = self.short(self._g2r(0xBE))
    self.UT = 0
    self.UP = 0
    self.T = 0
    self.P = 0
    self.version = '2.2'

  def short(self, dat):
    if dat > 32767:
      return dat - 65536
    else:
      return dat
  
  # set reg
  def _sr(self, reg, dat):
    i2c.write(BMP180_I2C_ADDR, bytearray([reg, dat]))
	
  # get two reg
  def _g2r(self, reg):
    i2c.write(BMP180_I2C_ADDR, bytearray([reg]))
    t =	i2c.read(BMP180_I2C_ADDR, 2)
    return t[0]*256 + t[1]

  # get Temperature and Pressure
  def get(self):
    # start measure
    self._sr(0xF4, 0x2E)
    sleep(6)
    self.UT = self._g2r(0xF6)
    self._sr(0xF4, 0x34)
    sleep(6)
    self.UP = self._g2r(0xF6)
    # calc
    X1 = (self.UT - self.AC6) * self.AC5/(1<<15)
    X2 = self.MC * (1<<11) / (X1 + self.MD)
    B5 = X1 + X2
    self.T = (B5 + 8)/160
    B6 = B5 - 4000
    X1 = (self.B2 * (B6*B6/(1<<12))) / (1<<11)
    X2 = (self.AC2 * B6)/(1<<11)
    X3 = X1 + X2
    B3 = ((self.AC1*4+X3) + 2)/4
    X1 = self.AC3 * B6 / (1<<13)
    X2 = (self.B1 * (B6*B6/(1<<12))) / (1<<16)
    X3 = (X1 + X2 + 2)/4
    B4 = self.AC4 * (X3 + 32768)/(1<<15)
    B7 = (self.UP-B3) * 50000
    if B7 < 0x80000000:
      p = (B7*2)/B4
    else:
      p = (B7/B4) * 2
    X1 = (p/(1<<8))*(p/(1<<8))
    X1 = (X1 * 3038)/(1<<16)
    X2 = (-7357*p)/(1<<16)
    self.P = p + (X1 + X2 + 3791)/16
    return [self.T, self.P]

  # get Temperature in Celsius
  def Temperature(self):
    self.get()
    return self.T
    
  # get Pressure in Pa
  def Pressure(self):
    self.get()
    return self.P
  
  # Calculating absolute altitude
  def Altitude(self):
    self.get()
    return 44330*(1-(self.P/101325)**(1/5.255))
