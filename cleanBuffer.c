#include <stdio.h>
#include <stdlib.h>

char cleanBuffer (char str1[]){
int i;
    for ( i = 0; i < 1000; ++i)
        {
        	str1[i]=0;
        }        
        	return str1[i];
}