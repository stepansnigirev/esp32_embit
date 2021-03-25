from machine import I2C, Pin, SPI
from axp192 import AXP192
import st7789py

hw_i2c_0 = I2C(0, sda=Pin(21), scl=Pin(22))
axp = AXP192(hw_i2c_0)
axp.setup()

spi = SPI(1, baudrate=27000000, polarity=0, phase=0, bits=8, firstbit=0, sck=Pin(13), mosi=Pin(15))
display = st7789py.ST7789(spi, 135, 240, reset=Pin(18, Pin.OUT), dc=Pin(23, Pin.OUT), cs=Pin(5, Pin.OUT))
display.init()

def backlight(status=True):
    """Turn LCD backlight on or off"""
    # in M5StickC, LCD backlight is wired to AXP192 LD02 output.
    axp.set_LD02(status)


def power_button():
    """Returns status of the power button"""
    return bool(axp.button())

display.on = lambda: backlight(True)
display.off = lambda: backlight(False)