#include <stdio.h>
#include <stdlib.h>

#define MAXSIZE 1000

//#define DEBUG
#define TEST_HASH
#define TEST_DRF

/*calculate and return the hash of the input string given a table of values for each latin letter*/
extern int hash(char* input, int* table);

/*calculate and return the factorial of the digital root of a number*/
extern int drootfactorial(int num);

int main(void){
	
	/*  Table of values for each character:
	//	Letters : { a,  b,  c,  d,  e,  f,  g, 	h,  i,  j,  k,  l,  m,  n,  o,  p,  q,  r,  s,  t,  u,  v,  w,  x,  y,  z}																			*/
	int table[] = {10, 42, 12, 21,  7,  5, 67, 48, 69,  2, 36,  3, 19,  1, 14, 51, 71,  8, 26, 54, 75, 15,  6, 59, 13, 25};

	int hash_result, drf_result;
		
	/* TESTING */
	#ifdef DEBUG
	int i, ntests, npassed, exit = 0;
		
	#ifdef TEST_HASH
	char *test_hash[] = {"VascoO Rizou 10021", "kprattis2001@ece.auth.gr", "ABCabc./*=&1", "T : 69***56483", "a55c66o77"};
	int 	ans_hash[] 	= {					241				 ,					593							,				63			 ,				-41			,				0			};
	ntests = 5;
	npassed = 0;
	
	printf("*************************** HASH TEST START (%d TESTS) ***************************\n", ntests);
	for(i = 0; i < ntests; i++){
		printf("------------------------- HASH TEST CASE %d ----------------------\n", i);
		printf("Test string %d is: %s\n", i, test_hash[i]);
		hash_result = hash(test_hash[i], table);
		
		printf("The hash result of the given string is: %d. Expected: %d. ", hash_result, ans_hash[i]);
		if(hash_result == ans_hash[i]){
			npassed ++;
			printf("PASSED\n");
		}
		else{
			printf("FAILED\n");
		}
		
	}
	printf("*************************** HASH TEST END (%d FAILED) ***************************\n", ntests - npassed);
	exit = npassed != ntests;
	
	#endif
	
	#ifdef TEST_DRF
	int  test_drf[] 	= {0, 			 9, 	1023, 	1427,  	 -61, 	4,294,967,294};			
	int 	ans_drf[] 	= {1, 	362880,	 	 720,	 	 120,		5040, 			2				 };
	ntests = 5;
	npassed = 0;
	
	printf("*************************** DRF TEST START (%d TESTS) ***************************\n", ntests);
	for(i = 0; i < ntests; i++){
		printf("------------------------- DRF TEST CASE %d ----------------------\n", i);
		printf("Test number %d is: %d\n", i, test_drf[i]);
		
		drf_result = drootfactorial(test_drf[i]);
		printf("The factorial of its digital root is: %d. Expected: %d. ", drf_result, ans_drf[i]);
		if(drf_result == ans_drf[i]){
			npassed ++;
			printf("PASSED\n");
		}
		else{
			printf("FAILED\n");
		}
		
	}
	printf("*************************** DRF TEST END (%d FAILED) ***************************\n",ntests - npassed);
	exit = npassed != ntests;
	
	#endif
	
	if(exit) return 1;
	
	#endif
	
	
	
	
	
	/*MAIN CODE*/
	char *user_input = (char *) malloc( (MAXSIZE + 1) * sizeof(char));
	
	printf("Please input a string (Less than %d characters)\n", MAXSIZE);

	char c;
	unsigned int len = 0;
	
	while( len <= MAXSIZE && ((c = getchar()) != '\r') ){
		printf("%c", c);
		user_input[len ++] = c;
	}
	user_input[len ++] = '/0';
	//user_input = realloc(user_input, len * sizeof(char));
	
	printf("Your string is: %s\n", user_input);
	
	hash_result = hash(user_input, table);
	printf("Hash result is: %d\n", hash_result);
	
	drf_result = drootfactorial(hash_result);
	printf("%d 's factorial of its digital root is: %d\n", hash_result, drf_result);
	
	free(user_input);
	
	return 0;
}
