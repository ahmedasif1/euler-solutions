#include <iostream>
#include <cmath>
#include <stdlib.h>
using namespace std;
/////Circular primes below 1000000//////////////////////////////////////



int rotatenumber(int num)
{

    int silly=num;
    num=silly%10;
    silly/=10;
    int temp=silly;

    while (temp>0)
    {
        temp/=10;
        num*=10;
    }

    num+=silly;
	return num;
}
bool evennumberpresent(int num);

bool isprime(int num)
{
	for(int i=2;i<=sqrt(double(num));++i)
	{
		if(num%i==0)
			return false;
	}
	return true;
}
int main()
{
//    cout<<rotatenumber(197)<<endl;;
//    cout<<rotatenumber(1234);

	int count=13;
	for (int i=101;i<1000000;i=i+2)
	{
		if(!evennumberpresent(i) && isprime(i))
		{

			int num=i;
			do
			{
//                cout<<num<<"  ";
				num=rotatenumber(num);
	//			cout<<num<<"  "<<i<<endl;
				if(i==197)
                {

                }
				if(!isprime(num))
					break;
			}while(num!=i);
			if(num==i)
            {
                //cout<<i<<endl;
                count++;
            }
			//else count++;
		}
	}
	cout<<count;
	return 0;

}


bool evennumberpresent(int num)
{
	while(num!=0)
	{
		int d=num%10;
		if((d%2)==0||d%5==0)
			return true;
		num/=10;
	}
return false;
}














