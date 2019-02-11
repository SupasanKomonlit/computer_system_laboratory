#include	<stdio.h>

#include	<stdlib.h>

int bitAnd( int x , int y ); // ( < 8)
int getByte( int x , int n ); // ( < 6 )
int logicalShift( int x , int n ); // ( < 20 )
int bitCount( int x ); // ( < 40 )
int odd_ones( unsigned x ); // ( < 15 ) // amont bit is odd return 1
int tmin(); // ( <4 ) // min interget in two's complement
int fitsBits( int x , int n ); // ( < 15 ) 
int negate( int x ); // ( < 5 )ัั
int isPositive( int x ); // ( < 8 )
int isLessOrEqual( int x , int y ); // ( < 24)

int main(){
	int x , y;

	printf("\n=== Test Function getByte\n");
	x = 0x12345678 ; y = 0;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );
	x = 0x12345678 ; y = 1;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );
	x = 0x12345678 ; y = 2;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );
	x = 0x12345678 ; y = 3;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );
	x = 0x12345678 ; y = 4;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );
	x = 0x12345678 ; y = -1;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , getByte( x , y ) );

	printf("\n=== Test Function isLessOrEqual\n");
	x = 4 ; y = 5;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
	x = 5 ; y = -4;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
	x = 0 ; y = 0;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
	x = 0x80000000 ; y = 0x80000000;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
	x = -5 ; y = 5;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
	x = -2 ; y = -10;
	printf("\tx :%10x, y :%10x result : %10x\n" , x , y , isLessOrEqual( x , y ) );
}

int bitAnd( int x , int y ){ // 3 operation ( < 8 )
	return ~ (  ~ x  |  ~ y  );
}
// Use De Morgan's laws ~ (A ^ B) = ~A v ~B
//						  (A ^ B) = ~ ( ~ A v ~ B)

int getByte( int x , int n ){ // 6 operation( <= 6 )
	int Mask = ( 0xff << ( n << 3 ) );
	return ( x & Mask ); 
}
// We have to discuss about situation to happend in this
//		integer is 32 bit so have value 4 byte that mean you can get byte 0 1 2 3 only
//			if byte 0 -> 0xff _ 1 -> 0xff00 _ 2-> 0xff0000 _ 3-> 0xff000000
//					0xff << 0      0xff << 8     0xff << 16       0xff << 24
//					0 << 3           1 << 3		   2 << 3            3 << 3
//                  0 -> 0           1 -> 1000    10 -> 10000        11 -> 11000
//      and we will shift to return value after and operate by number equal shift left

int tmin(){ // 1 operation ( <  4 )
	return 0b1 << 31;
}
// We know about two's complement system the min of value is sign bit is 1 and other is zero
//		int is 32 bit so I have shift 1 to sign bit position

int negate( int x ){ // 3 operation ( < 5)
	return ( ~x + 0b1);
}
/* 
	Use solution of converting in two's complement system
*/

int isPositive( int x ){ // 5 operation ( < 8)
	return  !(( ( x >> 31 ) & 0b1 ) | (!x) );
}
/*
	!x --> if zero will return 1, so return 0 otherwise 

	x >> 31 --> will shift sign bit to first bit 
	x >> 31 & 0b1 --> that is mask to interest sign bit. 
					--> if x is negative return 1. And return 0 in otherwise

	(!x) | ( x >> 31 & 0b1) --> will mean return 1 when negative or zero
	!((!x) | ( x >> 31 & 0b1)) --> will mean return 0 when negative or zero
*/

int isLessOrEqual( int x , int y ){ // 8 + 9 = 17 or 6 + 6 + 9 = 21 operation
	int diff_or_same = ( (x^y) >> 31 ) & 0b1; // 4 operation
			// diff_or_same & ~ isPositive(x)

	int x_substrance_by_y = x + (~y + 0b1 ); // 4 operation

	return ( diff_or_same & ((((x>>31)&0b1)|(!x))) ) | 
		( !diff_or_same & (((( x_substrance_by_y >>31)&0b1) | (!x_substrance_by_y)))); 
			// 9 operation 
}
/*
	Purpose : return 1 is x <= y and 0 in otherwise
	Design pattern :
		1. split to two part about sign bit
				( ( x ^ y ) >> 31 ) & 0b1 return 1 is different and 0 inotherwise
		   That mean in case different bit we get 
					( ( (x ^ y) >> 31 ) & 0b1 ) & ((( x >> 31 ) & 0b1) (!x)) 7 operation
					( ( (x ^ y) >> 31 ) & 0b1 ) & ! isPositive( x )
			because if x is negative value x < y but if x positive that mean x > y
		2. what happend when and same sign bit
			when x and y is position x - y <= 0 when x <= y
			when x and y is negative x - y <= 0 when x <= y 
			That mean in 
					isPositive( x + negate( y ) )
			will return 0 is x <= y and return 1 in otherwise
			We will get ! infront so
					! isPositive( x + negate( y ) ) 
			will return 1 is  x<= y and return 0 in otherwise
*/
