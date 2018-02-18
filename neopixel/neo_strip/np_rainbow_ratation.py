from microbit import *
import neopixel

np = neopixel.NeoPixel(pin1 ,32)

def np_rainbow(np, num, bright=32, offset = 0):
    rb = ((255,0,0), (255,127,0), (255,255,0), (0,255,0), (0,255,255),(0,0,255),(136,0,255), (255,0,0))
    for i in range(num):
        t = 7*i/num
        t0 = int(t)
        r = round((rb[t0][0] + (t-t0)*(rb[t0+1][0]-rb[t0][0]))*bright)>>8
        g = round((rb[t0][1] + (t-t0)*(rb[t0+1][1]-rb[t0][1]))*bright)>>8
        b = round((rb[t0][2] + (t-t0)*(rb[t0+1][2]-rb[t0][2]))*bright)>>8
        np[(i+offset)%num] = (r, g, b)

n = 0
while 1:
    np_rainbow(np, 32, offset = n)
    np.show()
    n += 1
    sleep(100)
