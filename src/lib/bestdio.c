#include "bestdio.h"
char *vidptr = (char*)0xb8000;
unsigned int current_loc = 0;

void kprint_c(const char chr) {
	vidptr[current_loc++] = chr;
	vidptr[current_loc++] = 0x07;
}

void kprint_s(const char *str) {
	unsigned int i = 0;
	while (str[i] != '\0') {
		vidptr[current_loc++] = str[i++];
		vidptr[current_loc++] = 0x07;
	}
}

void kprint_d(int number) {
	char *str;
	int i, rem, len = 0, n;
 
    n = number;
    while (n != 0)
    {
        len++;
        n /= 10;
    }
    for (i = 0; i < len; i++)
    {
        rem = number % 10;
        number /= 10;
        str[len - (i + 1)] = rem + '0';
    }
    str[len] = '\0';
	kprint_s(str);
}