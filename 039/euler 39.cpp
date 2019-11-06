#include <iostream>

using namespace std;



int main()
{
    int p=120,b,c;
    int max_p;
    int count=0;
    int max_count=0;
    max_p;
    for(p=12; p<=1000; ++p)
    {

    count=0;
        for(b=1; b<p/2 ; ++b)
        {
            for(c=p-b; c>=b; --c)
            {
                int temp = p*p - 2*p*(b+c) + (b+c)*(b+c);


                if((b*b +c*c) ==temp)
                {
                    ++count;
                }
            }
        }
        if(count>max_count)
        {
            max_count=count;
            max_p=p;
        }

    }
    cout<<"MAX P(solution):"<<max_p<<endl<<"COUNT:"<<max_count<<endl;
    return 0;
}

