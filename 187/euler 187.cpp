#include <iostream>
#include <math.h>
#include <time.h>

#define LIMIT 100000000

/**************************************
Euler 187
Program to count products of
2 primes (may be same)
not exceeding LIMIT
***************************************/

using namespace std;

bool * primes;

bool is_prime(int number){
	
	return primes[number];
}

//prime generation using sieve
void generate_primes(int limit){
	primes = new bool[limit+1];
	primes[0]=primes[1]=false;
	for (int i=2;i<=limit;++i){
		primes[i]=true;
	}
	int sq_root = sqrt(limit);
	int prime = 2;
	
	while(prime <=sq_root){
		if (is_prime(prime)){
			int multiple = prime*prime;	
			while(multiple <= limit){
				primes[multiple]=false;
				multiple+=prime;
			}		
		}
		if(prime!=2){
			prime+=1;
		}
		prime+=1;
	}
}




int main(){
	unsigned int cl=clock();
	generate_primes(LIMIT/2);
	unsigned int c2=clock();

	cout<<"Primes generated in: "<<clock()-cl<<" ms"<<endl;
	
	int sq_root = sqrt(LIMIT)+1;
	int count=0;
	for (int pr1 =2; pr1 <= sq_root ;++pr1)
	{
		if(is_prime(pr1)){
			int loop_2_limit = LIMIT/pr1+1;
			for (int pr2 = pr1 ; pr2<loop_2_limit;++pr2){
				if(is_prime(pr2)){
					count+=1;
				}
			}
		}
	}
	cout<<count<<endl;
	cout<<"Total time elapsed: "<<clock()-cl<<" ms"<<endl;
	delete [] primes;
	return 0;
	
}
