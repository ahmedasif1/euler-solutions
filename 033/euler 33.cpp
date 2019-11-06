#include <iostream>
#include <stdio.h>
#include <time.h>

using namespace std;


struct fraction
{
	int num;
	int den;
	fraction(int num1,int den1)
	{
		num=num1;den=den1;
	}

};

fraction simplify(fraction param)
{
	for (int i=2;i<=param.num;)
	{
		if(param.num%i==0 && param.den%i==0)
		{
			param.num/=i;
			param.den/=i;
		}
		else ++i;
	}
	return param;
}
int main()
{
	int count=0;
	float array[4];
	double temp;
	int numer=1;
	int denom=1;
	int cll=clock();
	for(short num=11;num<=99;++num)
	{
		if(num%10==0 ||num%11==0)
			continue;
		for (int den=num+1;den<=99;++den)
		{

			if(den%10==0)
				continue;
			int n=num,d=den;
			array[0]=n%10;
			n/=10;
			array[1]=n%10;

			array[2]=d%10;
			d/=10;
			array[3]=d%10;

            float temp1=-1,temp2=-1,temp3=-1,temp4=-1;
			if(array[0]==array[2])
				temp1= array[1]/array[3];
			if(array[0]==array[3])
				temp2= array[1]/array[2];
			if(array[1]==array[2])
				temp3= array[0]/array[3];
			if(array[1]==array[3])
				temp3= array[0]/array[2];
            float ratio = double(num)/double(den);
			if(temp1==ratio||temp2==ratio||temp3==ratio||temp4==ratio)
			{
			    cout<<num<<" / "<<den<<endl;
				++count;
				fraction t=simplify(fraction(num,den));
				denom*=t.den;
				numer*=t.num;
			}
		}

	}
	fraction f1 = simplify(fraction(numer,denom));
	printf("Numerator : %d \nDenominator : %d \nSolution took ms: ",f1.num,f1.den);
	cout<<clock()-cll;
}
