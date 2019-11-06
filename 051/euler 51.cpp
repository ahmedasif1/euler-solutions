#include <iostream>
#include <math.h>
#include <string>
#include <vector>
#include <time.h>
#include <stdlib.h>
#include <stdio.h>
using namespace std;

void generate(bool * primes,int size)
{
	primes[0]=primes[1]=false;
	double sq =sqrt(double(size));
	for ( unsigned int i=2;i<size;++i)
	{
		for (unsigned int j=2;j<=i;++j)
		{
			int temp=i*j;
			if(temp>=size)
				break;
			primes[temp]=false;
		}
	}
}
unsigned int nChoosek( unsigned int n, unsigned int k )
{
	if (k > n) return 0;
	if (k * 2 > n) k = n-k;
	if (k == 0) return 1;

	int result = n;
	for( int i = 2; i <= k; ++i ) {
		result *= (n-i+1);
		result /= i;
	}
	return result;
}


int  main()
{


	time_t t=clock();
	int size=1000000;
	bool * primes=new bool[size];
	for (int i=0;i<size;++i)
		primes[i]=true;
	generate(primes,size);
	cout<<"Primes Generated "<<clock()-t<<" ms"<<endl;
	string temp;
	string temp2;
	int family_size=8;
	int count;
	for (int number=1;number<size;++number)
	{

		if(!primes[number])
			continue;

		temp.clear();
        temp=to_string(number);
		//temp=to_string( (long long int)number);
		vector<int> indexes;
		for (int i=1;i<temp.length();++i)
		{


			indexes.clear();
			int k=0;

			int loop_for=nChoosek(temp.length()-1,i);
			for(int c=0;c<loop_for;++c)
			{
				count=1;
				if(k==temp2.length()-1)
				{
					indexes.pop_back();
					k=indexes[indexes.size()-1];
					++k;
					indexes.pop_back();
					--c;
				}
				else
				{
					indexes.push_back(k);
					++k;

					if(indexes.size()==i)
					{
						bool flag=true;
						char num=temp[indexes[0]];

						for (int i=0;i<indexes.size();++i)
						{
							if(num!=temp[indexes[i]])
							{
								flag=false;
								break;
							}
						}
						if(flag)
						{
							count=1;
							temp2=temp;
							while (1)
							{

								for (int i=0;i<indexes.size();++i)
								{

									++temp2[indexes[i]];
								}
								if(temp2[indexes[0]]>'9')
								{
									break;
								}
								if(primes[atoi(temp2.c_str())])
									++count;
							}
							if (count==family_size)
							{
								cout<<number<<endl;
								temp2=temp;
								while (1)
								{
									for (int x=0;x<indexes.size();++x)
									{

										++temp2[indexes[x]];
									}
									if(temp2[indexes[0]]>'9')
									{
										break;
									}
									if(primes[atoi(temp2.c_str())])
									cout<<temp2<<endl;
								}
								cout<<"Done at "<<clock()-t<<" ms"<<endl;
								exit(1);
							}
						}
						k=indexes[indexes.size()-1];
						++k;
						indexes.pop_back();
						if(k==temp2.length()-1)
							indexes.push_back(k);
					}
					else --c;
				}
			}
		}
	}
}

