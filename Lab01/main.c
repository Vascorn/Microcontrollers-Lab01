#include <stdio.h>
#include <stdlib.h>

#define MAXSIZE 100

extern int hash(char* input, int* table);
extern int drootfactorial(int num);

int main(void){
	/*
	char* user_input = (char*)malloc(sizeof(char) * MAXSIZE);
	
	printf("Enter a string with no more than 100 characters: \n");
	scanf("%s", user_input);
	
	free(user_input);
	*/
	int table[] = {10, 42, 12, 21, 7, 5, 67, 48, 69, 2, 36, 3, 19, 1, 14, 51, 71, 8, 26, 54, 75, 15, 6, 59, 13, 25};
	char user_input[] = "12";
	
	int result = hash(user_input, table);
	printf("The hash result of the given string is: %d \n", result);
	printf("The digital root and factorial of the given string is: %d \n", drootfactorial(result));
	
	
	return 0;
}
