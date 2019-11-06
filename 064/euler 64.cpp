#include <iostream>
#include <time.h>
#include <math.h>
using namespace std;

int main()
{

	unsigned int aaa= clock();
	int multi;
	int denom;
	double sq;
	int count=0;
	for (int n=2;n<=10000;++n)
	{
	
		int init_a=-1;
		int init_x=-1;
		int init_d=-1;
		
		multi=1;
		denom=1;
		sq=sqrt(double(n));
		if(sq == int(sq))
			continue;
		int a=0,x=0;
		x=-sq;
		int i;
		for (i=0;a!=init_a || x!=init_x||init_d!=denom;++i)
		{
			x*=-1;
			denom=n-x*x;
			if(denom%multi==0)
				denom/=multi;
			a=0;
			while( ( sq + x ) >= denom )
			{
				x-=denom;
				++a;
			}
	
			if(i==0)
			{
				init_a=a;
				init_x=x;
				a=0;
				init_d=denom;
			}
			multi=denom;
			

		}
		if(i%2==0)
			++count;



	}
	cout<<"Count : "<<count<<endl;
	cout<<"Solution took "<<clock()-aaa<<" ms";

}