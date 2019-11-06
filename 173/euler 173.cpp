#include <iostream>
#include <time.h>
 
#define LIMIT 1000000
using namespace std;
 
int main(){
	
	unsigned int cl=clock();
	int max_sq_size = LIMIT/4+1;
 	
 	//array store tiles used in each layer of squares with side length as indexes
 	
	int * array = new int[max_sq_size+1];
	array[0]=array[1]=array[2]=0;
	
	//formula for tiles in nth layer n*4 - 4
	for(int i=0;i<=max_sq_size;++i){
		array[i]= 4*i-4;
	}
	
	int count = 0;
	for(int outer=3; outer <=max_sq_size ;++outer ){
		count+=1;
		int tiles = array[outer];
 		for	(int inner = outer - 2; inner >= 3 ;inner-=2){
 			tiles+=array[inner];
 			
 			if(tiles > LIMIT){
 				break;
			}
 			count+=1;
		}
	}
	cout<<count<<endl;
	cout<<"Total time elapsed: "<<clock()-cl<<" ms"<<endl;
	delete []array;
}
