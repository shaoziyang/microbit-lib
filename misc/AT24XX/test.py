'''
    AT24C32 demo

    Author: shaoziyang
    Date:   2018.3

    http://www.micropython.org.cn
'''
from microbit import *

AT24CXX_I2C_ADDRESS = (80)

class AT24XX():
    def write_byte(self, addr, dat):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr, dat]))

    def read_byte(self, addr):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr]))
        t = i2c.read(AT24CXX_I2C_ADDRESS, 1)
        return t[0]

    def write_word(self, addr, dat):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr, dat//256, dat]))

    def read_word(self, addr):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr]))
        t = i2c.read(AT24CXX_I2C_ADDRESS, 2)
        return t[0]*256 + t[1]

    def write_dword(self, addr, dat):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr, dat>>24, dat>>16, dat>>8, dat]))

    def read_dword(self, addr):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr]))
        t = i2c.read(AT24CXX_I2C_ADDRESS, 4)
        return (t[0]<<24) + (t[1]<<16) + (t[2]<<8) + t[3]

    def write_buf(self, addr, buf):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr]) + buf)
        
    def read_buf(self, addr, num):
        i2c.write(AT24CXX_I2C_ADDRESS, bytearray([addr//256, addr]))
        return i2c.read(AT24CXX_I2C_ADDRESS, num)


ee = AT24XX()

ee.write_byte(0, 12)
ee.read_byte(0)

ee.write_word(4, 0x1234)
ee.read_word(4)

ee.write_buf(800, 'Hello!')
ee.read_buf(800, 8)

