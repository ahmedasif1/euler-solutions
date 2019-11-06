#include <iostream>
#include <cmath>
using namespace std;


bool is_fifth_power(long long int num);
int main()
{
	long long int sum=0;
	for (int i=10;i<1000000;++i)
	{
		if(is_fifth_power(i))
		{
			sum+=i;
			cout<<i<<endl;
		}
	}
	cout<<"SUM : "<<sum;
}


bool is_fifth_power(long long int num)
{
	long long int temp=num;
	long long int sum=0;
	while(temp)
	{
		sum+=pow(double(temp%10),5);
		temp/=10;
	}
	return sum==num;
}
