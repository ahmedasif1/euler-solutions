#include <iostream>

using namespace std;

int SplitAndSquare(int num)
{
	int result=0;
	while(num!=0)
	{
		result+=(num%10)*(num%10);
		num/=10;
	}
	return result;
}

int main()
{

	bool * T = new bool;
	*T = true;
	bool * F= new bool;
	*F=false;

	const int maxSize=1000;
	int limit=10000000;


	bool * array[maxSize];
	int count=0;
	for (int i=0;i< maxSize;++i)
	{array[i]=nullptr;}
	array[1]=F;
	array[89]=T;
	for(int i=1;i<limit;++i)
	{
		if(i<maxSize && array[i]!=nullptr)
		{
			if(*array[i]==true)
				++count;
			continue;
		}
		int current=i;
		bool * p = new bool;
		while(current >= maxSize || array[current]==nullptr)
		{
			if(current<maxSize)
				array[current]=p;
			current=SplitAndSquare(current);
		}
		*p = *array[current];
		if(*array[current]==true)
			++count;
	}

	cout<<count;

}