from microbit import *

BME280_I2C_ADDR = 0x76

class BME280():
  def __init__(self):
    self._T1 = self._g2r(0x88)
    self._T2 = self.short(self._g2r(0x8A))
    self._T3 = self.short(self._g2r(0x8C))
    self._P1 = self._g2r(0x8E)
    self._P2 = self.short(self._g2r(0x90))
    self._P3 = self.short(self._g2r(0x92))
    self._P4 = self.short(self._g2r(0x94))
    self._P5 = self.short(self._g2r(0x96))
    self._P6 = self.short(self._g2r(0x98))
    self._P7 = self.short(self._g2r(0x9A))
    self._P8 = self.short(self._g2r(0x9C))
    self._P9 = self.short(self._g2r(0x9E))
    self._H1 = self._gr(0xA1)
    self._H2 = self.short(self._g2r(0xE1))
    self._H3 = self._gr(0xE3)
    a = self._gr(0xE5)
    self._H4 = (self._gr(0xE4)<<4)+(a%16)
    self._H5 = (self._gr(0xE6)<<4)+(a>>4)
    self._H6 = self._gr(0xE7)
    if self._H6>127:
      self._H6 -= 256
    self._sr(0xF2, 0x04)
    self._sr(0xF4, 0x2F)
    self._sr(0xF5, 0x0C)
    self.T = 0
    self.P = 0
    self.H = 0
    self.version = '2.0'

  def short(self,	dat):
    if dat > 32767:
      return dat - 65536
    else:
      return dat
	
  # set reg
  def _sr(self, reg, dat):
    i2c.write(BME280_I2C_ADDR, bytearray([reg, dat]))
		
  # get reg
  def _gr(self, reg):
    i2c.write(BME280_I2C_ADDR, bytearray([reg]))
    t = i2c.read(BME280_I2C_ADDR, 1)
    return t[0]
	
  # get two reg
  def _g2r(self, reg):
    i2c.write(BME280_I2C_ADDR, bytearray([reg]))
    t = i2c.read(BME280_I2C_ADDR, 2)
    return t[0]+t[1]*256

  def get(self):
    adc_T = (self._gr(0xFA)<<12) + (self._gr(0xFB)<<4) + (self._gr(0xFC)>>4)
    var1 = (((adc_T>>3)-(self._T1<<1))*self._T2)>>11
    var2 = (((((adc_T>>4)-self._T1)*((adc_T>>4) - self._T1))>>12)*self._T3)>>14
    t = var1+var2
    self.T = ((t * 5 + 128) >> 8)/100
    var1 = (t>>1) - 64000
    var2 = (((var1>>2) * (var1>>2)) >> 11 ) * self._P6
    var2 = var2 + ((var1*self._P5)<<1)
    var2 = (var2>>2)+(self._P4<<16)
    var1 = (((self._P3*((var1>>2)*(var1>>2))>>13)>>3) + (((self._P2) * var1)>>1))>>18
    var1 = ((32768+var1)*self._P1)>>15
    if var1 == 0:
      return  # avoid exception caused by division by zero
    adc_P = (self._gr(0xF7)<<12) + (self._gr(0xF8)<<4) + (self._gr(0xF9)>>4)
    p=((1048576-adc_P)-(var2>>12))*3125
    if p < 0x80000000:
      p = (p << 1) // var1
    else:
      p = (p // var1) *2
    var1 = (self._P9 * (((p>>3)*(p>>3))>>13))>>12
    var2 = (((p>>2)) * self._P8)>>13
    self.P = p + ((var1 + var2 + self._P7) >> 4)
    adc_H = (self._gr(0xFD)<<8) + self._gr(0xFE)
    var1 = t - 76800
    var2 = (((adc_H<<14)-(self._H4<<20)-(self._H5*var1))+16384)>>15
    var1 = var2*(((((((var1*self._H6)>>10)*(((var1*self._H3)>>11)+32768))>>10)+2097152)*self._H2+8192)>>14)
    var2 = var1-(((((var1>>15)*(var1>>15))>>7)*self._H1)>>4)
    if var2 < 0:
      var2 = 0
    if var2 > 419430400:
      var2 = 419430400
    self.H = (var2>>12)/1024
    return [self.T, self.P, self.H]

  # get Temperature in Celsius
  def Temperature(self):
    self.get()
    return self.T

  # get Pressure in Pa
  def Pressure(self):
    self.get()
    return self.P

  # get Humidity in %RH
  def getHumi(self):
    self.get()
    return self.H

  # Calculating absolute altitude
  def Altitude(self):
    self.get()
    return 44330*(1-(self.P/101325)**(1/5.255))

  # sleep mode
  def poweroff(self):
    self._sr(0xF4, 0)

  # normal mode
  def poweron(self):
    self._sr(0xF4, 0x2F)
