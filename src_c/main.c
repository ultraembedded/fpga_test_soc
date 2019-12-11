#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "spi_lite.h"
#include "printf.h"

void LogHex(void *Data,int Len);

//-----------------------------------------------------------------
// main
//-----------------------------------------------------------------
int main(int argc, char *argv[])
{
    int i;
    unsigned char Buf[256];
    int Id = 0;
    for(i = 0; i < 8; i++) {
       printf("helloworld!\n");
    }

    printf("Spi read test\n");
    memset(Buf,0x55,sizeof(Buf));
    spi_cs(0);
// read SPI flash device id
    spi_sendrecv(0x9f);
// Read and toss first byte which was received while the command was
// being shifted out
    spi_readblock(Buf,1);
    spi_readblock(Buf,3);
    spi_cs(1);
    printf("SPI flash JEDEC device ID:");
    for(i = 0; i < 3; i++) {
       Id <<= 8;
       Id += Buf[i];
       printf(" 0x%02x",Buf[i]);
    }
    printf("\n");

    switch(Id) {
       case 0x202018:
          printf("M25P128 SPI flash confirmed\n");
          break;

       case 0x202014:
          printf("M25P80 SPI flash confirmed\n");
          break;

       default:
          printf("Unknown JEDEC ID\n");
          break;
    }

    printf("\nReading first 256 bytes of flash...");
    spi_cs(0);
    spi_sendrecv(0x03);
    spi_sendrecv(0);
    spi_sendrecv(0);
    spi_sendrecv(0);
    spi_readblock(Buf,1);
    spi_readblock(Buf,sizeof(Buf));
    spi_cs(1);

    printf("\n");
    LogHex(Buf,sizeof(Buf));

    return 0;
}

void LogHex(void *Data,int Len)
{
   int i;
   uint8_t *cp = (uint8_t *) Data;

   for(i = 0; i < Len; i++) {
      if(i != 0 && (i & 0xf) == 0) {
         printf("\n");
      }
      else if(i != 0) {
         printf(" ");
      }
      printf("%02x",cp[i]);
   }
   if(((i - 1) & 0xf) != 0) {
      printf("\n");
   }
}

