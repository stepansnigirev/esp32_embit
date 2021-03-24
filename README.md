# esp32_embit


to flash on M5stickC Plus:

```
esptool.py -p /dev/ttyUSB0 -b 115200 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size detect --flash_freq 40m 0x1000 build-GENERIC/bootloader/bootloader.bin 0x8000 build-GENERIC/partition_table/partition-table.bin 0x10000 build-GENERIC/micropython.bin
```

or

```
esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 write_flash --flash_mode dio --flash_size detect --flash_freq 40m -z 0x1000 build-GENERIC/firmware.bin
```