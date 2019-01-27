#include	<stdio.h>

int main(){

	int array_a[] = { 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14
					 ,15 , 16 , 17 , 18 , 19 };
	int array_b[] = { 0x7fffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9 ,0x7ffffff8 ,0x7ffffff7, 0x7ffffff6 };
	int temp;
	int run;
	for( temp = 0 , run = 0 ; run < 20 ; run++ ){
		temp += array_a[ run ];
	}
	printf("Sum a : %d\n" , temp );

	for( temp = 0 , run = 0 ; run < 11 ; run++ ){
		temp += array_b[ run ];
	}
	printf("Sum b : %d\n" , temp );
}
