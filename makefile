DEVICE = atmega128
PROGRAMMER = stk500
DEVICE_PATH = /dev/ttyUSB0
FUSE = -U lfuse:w:0xe1:m -U hfuse:w:0x99:m -U efuse:w:0xfd:m 

CFLAGS = -Wall -Os
COMPILER = avr-gcc -mmcu=$(DEVICE) $(CFLAGS)
AVRDUDE = avrdude -c $(PROGRAMMER) -p $(DEVICE) -P $(DEVICE_PATH)

SOURCE_FILES = larson-scanner.c

main.hex: main.elf
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex

main.elf: $(SOURCE_FILES)
	$(COMPILER) *.c -o main.elf

clean:
	rm -f main*

fuse:
	$(AVRDUDE) $(FUSE)

deploy: main.hex fuse
	$(AVRDUDE) -U flash:w:main.hex
