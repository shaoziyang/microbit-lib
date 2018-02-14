from microbit import *
from neopixel import NeoPixel

class neo16x16:
    def __init__(self, pin):
        self.np = NeoPixel(pin, 256)
        self.color = (0,0,8)

    def clear(self):
        self.np.clear()

    def set(self, n, color=''):
        if color!='':
            self.np[n] = color
        else:
            self.np[n] = self.color
        self.np.show()

    def setcolor(self, color):
        self.color = color

    def show(self, dat, pos=0, clear = True, color=''):
        if color != '':
            self.color = color
        if clear:
            for i in range(256):
                self.np[i]=(0,0,0)
        for x in range(16):
            for y in range(16):
                if (x+pos)>=len(dat):
                    self.np[x*16+y]=(0,0,0)
                else:
                    if (1<<y)&dat[x+pos]:
                        if pos%2==0:
                            self.np[x*16 + y] = self.color
                        else:
                            self.np[x*16 +15 - y] = self.color
        self.np.show()

def _delay(t):
    while t>0:
        t = t - 1

npdat=[
0x3F80,0x01FC,0x0080,0x01FC,0x3F80,0x0180,0x3F80,0x01FC,
0x0000,0x0000,0x3F98,0x19FC,0x3F98,0x0000,0x0000,0x0000,
0x0F00,0x01F8,0x3F80,0x010C,0x3080,0x019C,0x1980,0x0090,
0x0000,0x01FC,0x3F80,0x01FC,0x0180,0x0100,0x0080,0x0000,
0x0F00,0x01F8,0x3F80,0x010C,0x3080,0x01FC,0x1F80,0x00F0,
0x0000,0x0000,0x3080,0x010C,0x3080,0x0000,0x0000,0x0000,
0x3FF8,0x1FFC,0x3FF8,0x010C,0x3080,0x01FC,0x1F80,0x00F0,
0x0000,0x0000,0x3F98,0x19FC,0x3F98,0x0000,0x0000,0x0000,
0x0080,0x0100,0x1FF0,0x0FFC,0x3FF0,0x0104,0x3080,0x000C,
]

ne = neo16x16(pin1)
ne.setcolor((16,16,31))
n = 0
while True:
    ne.show(npdat, n)
    n = (n+1)%63
    _delay(100)
