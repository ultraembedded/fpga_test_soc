#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include "printf.h"

//-----------------------------------------------------------------
// main
//-----------------------------------------------------------------
int main(int argc, char *argv[])
{
    int i;
    for(i = 0; i < 8; i++) {
       printf("helloworld!\n");
    }

    return 0;
}
