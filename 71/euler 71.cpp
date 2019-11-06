#include <iostream>
#include <time.h>
using namespace std;

int limit =1000000;
bool relatively_prime(int num1,int num2)
{
	if(num1==0)
		return num2==1;
	else if(num2==0)
		return num1==1;
	return relatively_prime(num2,num1%num2);
}

int main()
{
	unsigned int cl=clock();
	double num=2;
	double den=5;
	for (int i=2;i<=limit;++i)
	{
		for (int j= num*i/den ;j<=(i/2);++j)
		{
			if((double(j)/double(i)) >= (double(3)/double(7)))
				break;
			if((double(j)/double(i)) < (num/den))
				continue;
			if(!relatively_prime(i,j))
				continue;

			if((double(j)/double(i))>(num/den))
			{
				num=j;
				den=i;
				//break;
			}

		}
	}
	cout<<num<<"/"<<den;
	cout<<"solution took "<<clock()-cl<<" ms"<<endl;
	
}