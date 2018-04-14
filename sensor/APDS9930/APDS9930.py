from microbit import *

APDS9930_I2C_ADDRESS = 0x39

# APDS-9930 register addresses
APDS9930_ENABLE      = 0x00
APDS9930_ATIME       = 0x01
APDS9930_PTIME       = 0x02
APDS9930_WTIME       = 0x03
APDS9930_PERS        = 0x0C
APDS9930_CONFIG      = 0x0D
APDS9930_PPULSE      = 0x0E
APDS9930_CONTROL     = 0x0F
APDS9930_Ch0DATAL    = 0x14
APDS9930_Ch0DATAH    = 0x15
APDS9930_Ch1DATAL    = 0x16
APDS9930_Ch1DATAH    = 0x17
APDS9930_PDATAL      = 0x18
APDS9930_PDATAH      = 0x19
APDS9930_POFFSET     = 0x1E 

# ALS coefficients
DF = 52
GA = 0.49
B  = 1.862
C  = 0.746
D  = 1.291

# AGAIN
APDS9930_AGAIN = (1, 8, 16, 120)

# PGAIN
APDS9930_PGAIN = (1, 2, 4, 8)

class APDS9930:
    def __init__(self):
        self.ATIME(256 - 8)
        self.setReg(APDS9930_ENABLE, 0)
        self.setReg(APDS9930_ATIME, 0xFF)
        self.setReg(APDS9930_PTIME, 0xFF)
        self.setReg(APDS9930_WTIME, 0xFF)
        self.setReg(APDS9930_PERS, 0x22)
        self.setReg(APDS9930_CONFIG, 0)
        self.setReg(APDS9930_PPULSE, 8)
        self.setReg(APDS9930_CONTROL, 0x2C)
        self.ALS_Enable()
        self.Power()

    def setReg(self, reg, dat):
        i2c.write(APDS9930_I2C_ADDRESS, bytearray([reg|0xA0, dat]))

    def getReg(self, reg):
        i2c.write(APDS9930_I2C_ADDRESS, bytearray([reg|0xA0]))
        return i2c.read(APDS9930_I2C_ADDRESS, 1)[0]

    def get2Reg(self, reg):
        i2c.write(APDS9930_I2C_ADDRESS, bytearray([reg|0xA0]))
        t = i2c.read(APDS9930_I2C_ADDRESS, 2)
        return t[0] + t[1]*256

    def getCH0(self):
        return self.get2Reg(APDS9930_Ch0DATAL)

    def getCH1(self):
        return self.get2Reg(APDS9930_Ch1DATAL)

    def ATIME(self, v=None):
        if v == None:
            return self.getReg(APDS9930_ATIME)
        else:
            self.setReg(APDS9930_ATIME, v)

    def AGAIN(self, gain=None):
        t = self.getReg(APDS9930_CONTROL)
        if gain == None:
            return APDS9930_AGAIN[t & 0x03]
        else:
            t &= 0xFC
            t |= APDS9930_AGAIN.index(gain)
            self.setReg(APDS9930_CONTROL, t)

    def PGAIN(self, gain=None):
        t = self.getReg(APDS9930_CONTROL)
        if gain == None:
            return APDS9930_PGAIN[(t & 0x0F)>>2]
        else:
            t &= 0xF3
            t |= APDS9930_PGAIN.index(gain)<<2
            self.setReg(APDS9930_CONTROL, t)

    def Power(self, on=True):
        t = self.getReg(APDS9930_ENABLE)
        t &= 0xFE
        if on:
            t |= 1
        self.setReg(APDS9930_ENABLE, t)

    def ALS_Enable(self, on=True):
        t = self.getReg(APDS9930_ENABLE)
        t &= 0xFD
        if on:
            t |= 2
        self.setReg(APDS9930_ENABLE, t)

    def Proximity_Enable(self, on=True):
        t = self.getReg(APDS9930_ENABLE)
        t &= 0xFB
        if on:
            t |= 4
        self.setReg(APDS9930_ENABLE, t)

    def Wait_Enable(self, on=True):
        t = self.getReg(APDS9930_ENABLE)
        t &= 0xF7
        if on:
            t |= 8
        self.setReg(APDS9930_ENABLE, t)

    def getALS(self):
        Ch0 = self.getCH0()
        Ch1 = self.getCH1()
        ALSIT = 2.72 * (256 - self.ATIME())
        IAC = max(Ch0 - B * Ch1, C * Ch0 - D * Ch1, 0)
        LPC = GA * DF / (ALSIT * self.AGAIN())
        return IAC * LPC

    def getProximity(self):
        return self.get2Reg(APDS9930_PDATAL)

