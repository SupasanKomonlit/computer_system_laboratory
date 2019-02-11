#include	<stdio.h>
#include	<string.h>

#define RANGE 255
#define N 1000

#define _DEBUG_

int main(){

	char str[] = "cadljgarhtoxAHdgdsJKhYEasduwBRLsdgHoptxnaseurh";

	char output[N];

	int count[ RANGE + 1 ] , i;

	for( i = 0 ; i < RANGE+1 ; i++ ) count[i] = 0 ; // set all member in array have 0

	for( i = 0 ; str[i] ; ++i ) ++count[ str[i] ]; // count position in ASCII code how many have

	for( i = 1 ; i <= RANGE ; ++i ) count[i] += count[i-1]; // aiai

	#ifdef _DEBUG_
		printf("print str : ");
	#endif
	for( i = 0 ; str[i] ; ++i ){
		#ifdef _DEBUG_
			printf("%c " , str[i] );
		#endif
		output[ count[ str[i] ] - 1 ] = str[i];
		--count[ str[i] ];
	}
	#ifdef _DEBUG_ 
		printf("===\n");
	#endif

	for( i = 0 ; str[i] ; ++i ) str[i] = output[i];

	printf("Sorted string is %s\n" , str );
	return 0;
}
