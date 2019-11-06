#include <iostream>
#include <cstdlib>
#include <time.h>
long int factc(long int req);
void print(int [],int );
void adder(int array[],int size);
bool check (int array[],int size);
long int factorial(int n);
void ini(int array[],int size);
using namespace std;

int main()
{
    int size = 10;
    long int req=1000000;
    clock_t t1,t2;
  	t1=clock();
    req=req%factorial(size);
    req=(req==0 ? factorial(size):req);

    int array[size];
    ini(array,size);
    for(int a=1; a<req;)
    {
        int num=factc(req-a+1);
        int c=0;
        while(size-num+c<size-1-c)
        {
            swap(array[size-num+c],array[size-1-c]);
            c++;
        }
        a+=factorial(num)-1;
        if(a<req)
        {
            adder(array,size);
            a++;
        }
    }
    print(array,size);
    t2 = clock();
    float diff ((float)t2-(float)t1);
  	cout<<"Time elapsed :"<<diff/(CLOCKS_PER_SEC/1000)<<"ms"<<endl;
    return 0;
}


bool check (int array[],int size)
{
    for(int i=0; i<size; i++)
    {
        for(int j=i+1; j<size; j++)
        {
            if(array[i]==array[j])
                return false;
        }
    }
    return true;
}
void adder(int array[],int size)
{
    while(1)
    {
        for(int i=size-1; i>=0;)
        {
            array[i]++;
            if(array[i]==size)
            {
                array[i]=0;
                i--;
            }
            else if(check(array,size))
                return;
            else i=size-1;
        }
    }
}
void print (int array[],int size)
{
    for(int i=0; i<size; i++)
        cout<<array[i];
    cout<<endl;
}
long int factc(long int req)
{
    long int ans=1;
    int i=0;
    for(; ans*(i+1)<=req;)
    {
        i++ ;
        ans*=i;
    }

    return i;
}
long int factorial(int n)
{
    long int ans=1;
    for(; n>=1; n--)
        ans*=n;
    return ans;
}
void ini(int array[],int size)
{
	for(int i=0;i<size;i++)
	array[i]=i;
}
