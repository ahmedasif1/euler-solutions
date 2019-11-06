#include <iostream>
#include <stack>
#include <math.h>
#include <limits.h>
using namespace std;

long long int lim;
bool * prime_generator(long long int limit=50)
{
	bool * temp =new bool[limit];
	lim=limit;
	for (long long int i=0;i<limit;++i)
	{
		temp[i]=true;
	}
	temp[0]=temp[1]=false;
	for (long long int i=2;i<limit;++i)
	{
		if(!temp[i])
			continue;
		for (long long int j=i+i;j<limit;j+=i)
		{
			temp[j]=false;
		}
	}
	return temp;

}
bool isprime(long int num,bool * ptr);
bool euler60(long long int num1,long long int num2,bool * ptr)
{
	long long int temp1=num1;
	long long int temp2= num2;
	stack<int> mystack,mystack2;
	while(!temp1==0)
	{
		mystack.push(temp1%10);
		temp1/=10;
	}
	while(!temp2==0)
	{
		mystack2.push(temp2%10);
		temp2/=10;

	}

	while(!mystack.empty())
	{
		num2*=10;
		num2+=mystack.top();
		mystack.pop();
	}
	while(!mystack2.empty())
	{
		num1*=10;
		num1+=mystack2.top();
		mystack2.pop();
	}
	return((num1<lim &&num2<lim)&& ptr[num1]&&ptr[num2]) ||(isprime(num1,ptr)&&isprime(num2,ptr));
}

bool isprime(long int num,bool * ptr)
{
	int sq=sqrt(double(num));
	for (int i=2;i<=sq; ++i)
	{
		if(!ptr[i])
			continue;
		if(num%i == 0)
			return false;
	}
	return true;
}
int main()
{
	long long int limit=100000;
	long long int min_sum=INT_MAX;
	bool * primes=prime_generator(limit*100);

	for(long long int i=3;i<limit;i+=2)
	{
		if(!(i*5<min_sum))
			break;
		if(!primes[i])
			continue;
		if(i==5)
			continue;
		
		for(long long int j=i+2;j<limit;j+=2)
		{
			if(!((i+j*4)<min_sum))
				break;
			if(!primes[j])
				continue;
			if(j==5)
				continue;
			
			if(!euler60(i,j,primes))
				continue;

			for(long long int k=j+2;k<limit;k+=2)
			{
				if(!((i+j+k*3)<min_sum))
					break;
				if(!primes[k])
					continue;
				if(k==5)
					continue;
				
				if(!euler60(i,k,primes) || !euler60(j,k,primes) )
					continue;

				for(long long int l=k+2;l<limit;l+=2)
				{
					if(l==5)
						continue;
					if(!((i+j+k+l*2)<min_sum))
						break;
					if(!primes[l])
						continue;
					
					if(!euler60(i,l,primes) || !euler60(j,l,primes) || !euler60(k,l,primes))
						continue;


					for(long long int m=l+2;m<limit;m+=2)
					{
						
						if(m==5)
							continue;
						if(!((i+j+k+l+m)<min_sum))
							break;
						if(!primes[m])
							continue;
						
						if(!euler60(i,m,primes) || !euler60(j,m,primes) || !euler60(k,m,primes) || !euler60(l,m,primes))
							continue;
						cout<<i<<endl<<j<<endl<<k<<endl<<l<<endl<<m<<endl;
						cout<<"sum = "<<i+j+k+l+m<<endl<<endl;
						min_sum=i+j+k+l+m;
						break;
					}


				}



			}

		}
		
	}
	return 0;
}