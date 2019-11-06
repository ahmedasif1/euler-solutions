#include <iostream>
#include <math.h>

#define LIMIT 10000000
using namespace std;


int * divisor_count;
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



int count_divisors(int number){
	int count=2;
	if(!is_prime(number)){
		double sq =sqrt(number);
		if(sq==(int)sq){
			count+=1;
			sq-=1;
		}
		
		for(int factor =2;factor<=sq ;++factor){
			if(number%factor==0)
				count+=2;
		}
	}
	return count;
}


int build_divisor_cache(int limit){
	int count=0;
	divisor_count= new int[limit+1];
	divisor_count[0]=0;
	divisor_count[1]=1;
	
	for(int i=2;i<=limit;++i){
		divisor_count[i]=count_divisors(i);
		if(divisor_count[i]==divisor_count[i-1]){
			count+=1;
		}
		//if(i%100000==0){
		//	cout<<i<<"\t"<<divisor_count[i]<<"\t"<<count<<endl;
		//}
		
	}
	return count;
}


int main(){
	unsigned int cl=clock();
	generate_primes(LIMIT);
	cout<<build_divisor_cache(LIMIT);
	cout<<"Total time elapsed: "<<clock()-cl<<" ms"<<endl;
	
}
