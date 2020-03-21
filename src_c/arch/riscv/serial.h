#ifndef __SERIAL_H__
#define __SERIAL_H__

#include "uart_lite.h"

#define serial_init        uartlite_init
#define serial_putchar     uartlite_putc
#define serial_getchar     uartlite_getchar
#define serial_haschar     uartlite_haschar

#endif // __SERIAL_H__
