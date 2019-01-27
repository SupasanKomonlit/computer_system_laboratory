#include	<stdio.h>

#include	<stdlib.h>

#define		_TEST_LOGICAL_SHIFT_
#define		_TEST_LOGICAL_SHIFT_SOLUTION_
#define		_TEST_SIZE_

#ifndef _TEST_LOGICAL_SHIFT_
	#ifdef _TEST_LOGICAL_SHIFT_SOLUTION_
		#undef _TEST_LOGICAL_SHIFT_SOLUTION_
	#endif
#endif

int bitAnd( int x , int y );
int getByte( int x , int n );
int logicalShift( int x , int n );

int main(){
	#ifdef _TEST_SIZE_
		printf("size of int is %d\n" , sizeof( int ) );
	#endif

	printf("Testing bitAnd function\n");
	printf("x = %x and y = %x so x & y = %x should be %x\n" 
			, 0b101 , 0b110 , bitAnd( 0b101 , 0b110 ) , 0b100);

	printf("Testing getByte function\n");
	printf("x = %x and n = %x so x & y = %x should be %x\n"
			, 0x12345678 , 1 , getByte( 0x12345678 , 1 ) , 0x56 );

	printf("Testing logicalShift function\n");
	printf("x = %x and n = %x so x & y = %x should be %x\n"
			, 0x87654321 , 4 , logicalShift( 0x87654321 , 4 ) , 0x08765432 );
//	printf("x = %x and n = %x so x & y = %x should be %x\n"
//			, -256 , 4 , logicalShift( -256 , 4 ) , -10 );
//	printf("x = %x and n = %x so x & y = %x should be %x\n"
//			, 7 , 1 , logicalShift( 7 , 1 ) , 3 );

	printf("x = %x and CountBit = %x should be %x\n"
			, 0b0100111111 , CountBit( 0b0100111111) , 7 );
}

int bitAnd( int x , int y ){
	return ~ (  ~ x  |  ~ y  );
}

int getByte( int x , int n ){
	return ( x >> ( n << 3 ) ) & 0xff;
}

int logicalShift( int x , int n ){
	int MaskAllBit1 = 0xffffffff; 
	int MaskAllBit2 = ~ ( MaskAllBit1 <<  ( 32 - n ) );
	int answer = ( x >> n ) & MaskAllBit2 ;
	#ifdef _TEST_LOGICAL_SHIFT_
		printf("MaskAllBit1 is %x\n" , MaskAllBit1 );
		printf("MaskAllBit2 is %x\n" , MaskAllBit2 );
		printf("answer is %x\n" , answer );
	#endif
	return answer;
}

int CountBit( int x ){
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
