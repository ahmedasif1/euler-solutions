#include <iostream>
#include <queue>
#include <stdint.h>

using namespace std;

long long int sort(long long int num)
{
	priority_queue<int> temp;
	do 
	{
		temp.push(num%10);
		num/=10;
	} while (num!=0);

	long long int temp2=0;
	while(!temp.empty())
	{
		temp2*=10;
		temp2+=temp.top();
		temp.pop();
	}
	return temp2;

}
const int limit = 100000;
long long int array[limit];
int main(int argc,char ** argv)
{
	int count;
	long long int final[10];
	for (long long int i=2; i<limit;++i)
	{
		array[i]=sort(i*i*i);
	}

	for (int i=2;i<limit;++i)
	{
		count=0;
		final[count]=i;
		count=1;
		
		for(int j=i+1;j<limit;++j)
		{
			if(array[i]==array[j])
			{
				final[count]=j;
				++count;
			}
		}
		if(count==5)
			{
				break;}
	}

	for(int i=0;i<5;++i)
	{
		cout<<final[i]<<"\t"<<final[i]*final[i]*final[i]<<endl;
	}
	return 0;
}