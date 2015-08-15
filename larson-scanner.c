#include<avr/io.h>
#include<util/delay.h>
#include<stdbool.h>

int main() {
  bool direction=1;
  uint8_t display = 0x01;

  DDRE = 0xff;

  PORTE = ~display;

  while(1) {
    if(display == 0x80) {
      direction = 0;
    } else if(display == 0x01) {
      direction = 1;
    }

    if(direction) {
      display <<= 1;
    } else {
      display >>= 1;
    }

    PORTE = ~display;
    _delay_ms(40);
  }

  return 0;

}
