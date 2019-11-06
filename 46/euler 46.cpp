#include <iostream>
#include <math.h>
using namespace std;

bool checktheorem(long int);
bool checkprime(long int);
int main()
{
	for (long int i=3;i<10000;i+=2)//to generate odd numbers
	{
		if(!checkprime(i))//the number is not prime
		{
			if(!checktheorem(i))
			{
				cout<<"Solution Euler no. 46 : "<<i<<endl;
				break;
			}
		}
	}
}

bool checkprime(long int num)
{
	for ( int i = 2 ; i <= sqrt(double(num)) ; i++ )
	{
		if(num%i==0)
			return false;
	}
	return true;
}
bool checktheorem(long int num)
{
	for (int i=1;2*i*i<num;i++)
	{
		if(checkprime(num-2*i*i))
			return true;
	}
	return false;
}