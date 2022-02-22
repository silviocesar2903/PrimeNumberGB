//header for the sdk
#include <gb/gb.h>
//standart header for io
#include <stdio.h>
//standart header for manipulating time 
#include <time.h>

//function for define if a number is prime or not
int checkPrimeNumber(int n);

//time delay function
void delay(int number_of_seconds);

int main() {

  int n1, n2, i, flag;

 //here we define our range of prime numbers 
 //thats need to be calculated
  n1 =0;
  n2 = 2048;
  printf("Prime numbers between %d and %d are: \n", n1, n2);
  delay(1);
  while(1)
  {
     int c =0;
    for (i = n1 + 1; i < n2; ++i) 
    {
      // flag will be equal to 1 if i is prime
      
      flag = checkPrimeNumber(i);
      if (flag == 1)
      {
	if(c == 3)
	{
	    printf("\t%d\n", i);
	    c = 0;
	}
	else
	{
	    printf("\t%d", i);
	    c++;
	}
        //printf("\t%d", i);
      }
    }
	printf("\n\n\n\n");
  }

  //return 0;
}

int checkPrimeNumber(int n) {
  int i, flag = 1;

  for (i = 2; i <= n / 2; ++i) {

    if (n % i == 0) {
      flag = 0;
      break;
    }
  }

  return flag;
}


void delay(int number_of_seconds)
{
    // Converting time into milli_seconds
    int milli_seconds = 1000 * number_of_seconds;
  
    // Storing start time
    clock_t start_time = clock();
  
    // looping till required time is not achieved
    while (clock() < start_time + milli_seconds);
}
