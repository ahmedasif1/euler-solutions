#include <iostream>
#include <math.h>
#include <map>
#include <set>
#include <algorithm>
#include <time.h>
#define LIMIT 1000000000

int prime_cache_size=-1;
using namespace std;

bool * primes;
map<int,set<long long int>> admissible;
set<int> pseudo_fortunate;

bool is_prime(long int number){
	if(number<=prime_cache_size){
		return primes[number];
	}
	else{
		int sq = sqrt(number)+1;
		for(int factor = 2;factor <=sq ; ++factor ){
			if(is_prime(factor) && number % factor==0){
				return false;
			}
		}
		return true;
	}
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

int get_next_prime(int n){
	for(n+=1;!is_prime(n);++n);
	return n;
}

//passed number is always even
int find_pseudo_fortunate(long long int number){
	
	long int ps_for = 3;
	while(true){
		//cout<<"Going to call is_prime for "<<number+ps_for<<endl;
		if(is_prime(number+ps_for)){
			pseudo_fortunate.insert(ps_for);
			//cout<<number<<"\t"<<ps_for<<"\t"<<ps_for+number<<"\t"<<pseudo_fortunate.size()<<endl;
			break;
		}
		//cout<<ps_for+number<<" is not prime"<<endl;
		ps_for+=2;
	}
	return ps_for;
}






void count_pseudo_fortunate_numbers(int last_prime,int current_prime,long long int limit){
	bool loop_executed_once = false;
	//cout<<last_prime<< "\t"<<current_prime<<endl;
	set<long long int> last_admissible_set = (*(admissible.find(last_prime))).second;
	set<long long int> current_admissible_set;
	
	long long int product = current_prime;
	
	int next_prime = get_next_prime(current_prime);
	
	while( product*(*last_admissible_set.begin()) <= limit ){
		loop_executed_once = true;
		
		//cout<<product<<endl;
		
		for(auto iterator = last_admissible_set.begin(); iterator !=last_admissible_set.end() ;++ iterator ){
			//cout<<*iterator<<endl;
			long long int adm = *iterator*product;
			if( adm > limit ){
				//cout<<"Loop broken"<<endl;
				break;
			}
			int ps_for = find_pseudo_fortunate(adm);
			//cout<<"Found pseudo_fortunate for "<<adm<<"\t"<<ps_for<<endl;
			current_admissible_set.insert(adm);
			//cout<<"Inserted "<<adm<<" in set "<<current_admissible_set.size()<<endl;
		}
		//cout<<"Outside for loop"<<endl;
		product*=current_prime;
	}
	//cout<<"Adding set to Admissible Map"<<endl;
	admissible[current_prime]=current_admissible_set;
	//cout<<"Added set to Admissible Map"<<endl;
	
	if(loop_executed_once){
		count_pseudo_fortunate_numbers(current_prime,next_prime,limit);
	}
	
}



int main(int argc,char ** argv){
	clock_t c1 = clock();
	long int limit = LIMIT;

	prime_cache_size = sqrt(limit);
	generate_primes(prime_cache_size);
	//cout<<is_prime(16387);
	
	int p=2;
	set<long long int> temp;
	temp.insert(1);

	admissible[1]=temp;
	
	
	count_pseudo_fortunate_numbers(1,2,limit);
	cout<<accumulate(pseudo_fortunate.begin(), pseudo_fortunate.end(), 0)<<endl;
	cout<<"Time Elapsed: "<<clock()-c1<<" ms"<<endl;
}
