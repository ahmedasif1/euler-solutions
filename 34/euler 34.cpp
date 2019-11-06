#include <iostream>
#include <cmath>
#include <stdlib.h>
using namespace std;
long long int fact(long long int);
bool yes(long long int);
int main()
{
	long long int numbers[1000];
	int count=0;
	for (long long int i=10;i<100000;i++)
	{
		if(yes(i))
			numbers[count++]=i;
	}
	long long int sum=0;
	for (int i=0;i<count;i++)
	{
		sum+=numbers[i];
		cout<<numbers[i]<<endl;
	}
	cout<<"Sum : "<<sum<<endl;


	return 0;
}

long long int fact(long long int num)
{
	if(num<=1)
		return 1;
	else return num*fact(num-1);
}
bool yes(long long int num)
{
	long long int temp=num;
	long long int sum=0;
	while(temp>0)
	{
		sum+=fact(temp%10);
		temp/=10;
	}
	if(sum==num)
		return true;
	else return false;
}




