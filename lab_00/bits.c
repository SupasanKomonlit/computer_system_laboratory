#include	<stdio.h>

#include	<stdlib.h>

//#define		_TEST_LOGICAL_SHIFT_
//#define		_TEST_LOGICAL_SHIFT_SOLUTION_
//#define		_TEST_SIZE_

#ifndef _TEST_LOGICAL_SHIFT_
	#ifdef _TEST_LOGICAL_SHIFT_SOLUTION_
		#undef _TEST_LOGICAL_SHIFT_SOLUTION_
	#endif
#endif

int bitAnd( int x , int y );
int getByte( int x , int n );
int logicalShift( int x , int n );
int bitCount( int x );
int odd_ones( unsigned x ); // ( < 15 ) // amont bit is odd return 1
int tmin(); // ( <4 ) // min interget in two's complement
int fitsBits( int x , int n ); // ( < 15 ) 
int negate( int x ); // ( < 5 )ัั
int isPositive( int x ); // ( < 8 )
int isLessOrEqual( int x ); // ( < 24 )

int main(){
	int x , y; 
	printf("Test bitAnd function\n");
		x = -1 ; y = 0x80000000; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );
		x = 1 ; y = 0x80000000; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );
		x = 6 ; y = 5; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );
		x = 0x80001000 ; y = 0x80101000; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );
		x = 0x00001000 ; y = 0x00100000; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );
		x = 0x80000000 ; y = 0x7FFFFFFF; 
		printf("\t x , y : %x , %x result %x\n" , x , y , bitAnd( x , y ) );

	printf("Test getByte function\n");
		x = 0x87654321 ; y = 0; 
		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );
		x = 0x87654321 ; y = 1; 
		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );
		x = 0x87654321 ; y = 2; 
		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );
		x = 0x87654321 ; y = 3; 
		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );
//		x = 0x87654321 ; y = 4; It should be zero
//		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );
//		x = 0x87654321 ; y = 5; 
//		printf("\t x , y : %x , %x result %x\n" , x , y , getByte( x , y ) );

	printf("Test logicalShift function\n");
		x = -1 ; y = 30; 
		printf("\t x , y : %x , %x result %x\n" , x , y , logicalShift( x , y ) );
		x = 0x87654321 ; y = 4; 
		printf("\t x , y : %x , %x result %x\n" , x , y , logicalShift( x , y ) );
		x = -1 ; y = 0; 
		printf("\t x , y : %x , %x result %x\n" , x , y , logicalShift( x , y ) );
		x = 0x80000000 ; y = 0; 
		printf("\t x , y : %x , %x result %x\n" , x , y , logicalShift( x , y ) );

	printf("Test bitCount function\n");
		x = 0 ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );
		x = 0b11111111111111111111111111111111 ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );
		x = 0xff ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );
		x = 0xff00 ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );
		x = 0xf0f0f0f0 ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );
		x = 0x0f0f0f0f ; 
		printf("\t x : %d result %d\n" , x , bitCount( x ) );

	printf("Test tmin() function\n");
		printf("\t tmin is %x\n" , tmin() );

	printf("Test negate function\n");
		x = 0 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );
		x = 0x80000000 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );
		x = 1 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );
		x = -1 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );
		x = -100 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );
		x = 0b01111111111111111111111111111111 ; 
		printf("\t x : %d result %d\n" , x , negate( x ) );

	printf("Test isPositive function\n");
		x = 0 ; 
		printf("\t x : %d result %d\n" , x , isPositive( x ) );
		x = -1 ; 
		printf("\t x : %d result %d\n" , x , isPositive( x ) );
		x = 1 ; 
		printf("\t x : %d result %d\n" , x , isPositive( x ) );
		x = 0b01111111111111111111111111111111 ; 
		printf("\t x : %d result %d\n" , x , isPositive( x ) );
		x = 0x80000000 ; 
		printf("\t x : %d result %d\n" , x , isPositive( x ) );
}

int bitAnd( int x , int y ){ // 3 operation ( < 8 )
	return ~ (  ~ x  |  ~ y  );
}
// Use De Morgan's laws ~ (A ^ B) = ~A v ~B
//						  (A ^ B) = ~ ( ~ A v ~ B)

int getByte( int x , int n ){ // 3 operation ( < 6 )
	return  ( ( x >> ( n << 3 ) ) & 0xff ) ;
}
// 1 Byte have 8 bits 0xff is 0b11111111 we will use this to mask and get value
// n << 3 we will calculate about number have to shift left to mask for get bits
//		if n --> 0 result 0 --> 1 result 8 --> 1 result 16 that mean 2^(3*n)

int logicalShift( int x , int n ){ // 7 operation ( < 20 )
	int MaskAllBit1 = 0xffffffff; 
	int MaskAllBit2 =  ( ~ ( MaskAllBit1 <<  ( 31 - n ) ) ) | ( ((!x) << 31) >> 31);
	int answer = ( x >> n ) & MaskAllBit2 ;
	#ifdef _TEST_LOGICAL_SHIFT_
		printf("MaskAllBit1 is %x\n" , MaskAllBit1 );
		printf("MaskAllBit2 is %x\n" , MaskAllBit2 );
		printf("answer is %x\n" , answer );
	#endif
	return answer;
}
// we create a mask to get value bit position 0 to 32 - n from right to left
//		and we will shift left so get result to & with mask

int bitCount( int x ){ // 34 operation ( < 40 ) 
	int MaskCount = 0b00000001000000010000000100000001;
	int SplitCount = ( x & MaskCount )
					+( ( x >> 1 ) & MaskCount )
					+( ( x >> 2 ) & MaskCount )
					+( ( x >> 3 ) & MaskCount )
					+( ( x >> 4 ) & MaskCount )
					+( ( x >> 5 ) & MaskCount )
					+( ( x >> 6 ) & MaskCount )
					+( ( x >> 7 ) & MaskCount ); 
	return ( SplitCount & 0b1111 ) 
			+ ( ( SplitCount >> 8 ) & 0b1111 )
			+ ( ( SplitCount >> 16 ) & 0b1111 )
			+ ( ( SplitCount >> 24 ) & 0b1111 );
	 
}
// We have to split part of number to count each part I divide to 4 part, 8 bit for each part

int tmin(){ // 1 operation ( <  4 )
	return 0b1 << 31;
}
// We know about two's complement system the min of value is sign bit is 1 and other is zero
//		int is 32 bit so I have shift 1 to sign bit position

int negate( int x ){ // 3 operation ( < 5)
	return ( ~x + 0b1);
}
// Use solution of converting in two's complement system

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
