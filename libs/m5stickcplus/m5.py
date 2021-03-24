from machine import I2C, Pin
from axp192 import AXP192

hw_i2c_0 = I2C(0, sda=Pin(21), scl=Pin(22))
axp = AXP192(hw_i2c_0)
axp.setup()

def backlight(status=True):
    """Turn LCD backlight on or off"""
    # in M5StickC, LCD backlight is wired to AXP192 LD02 output.
    axp.set_LD02(status)


def power_button():
    """Returns status of the power button"""
    return bool(axp.button())
