#include<iostream>
#include <fstream>
#include <string.h>

double trianglenumber(int num);
bool checktriangle(int num);
int word_value(const char word[]);
using namespace std;

int main()
{
	//cout<<trianglenumber(10);
	ifstream fin("p042_words.txt");
	int count=0;
	
	char sample[25];
	while (!fin.eof())
	{
		fin.ignore();
		fin.getline(sample,24,'"');
		if(checktriangle(word_value(sample)))
			count++;
		fin.ignore();
	}
	cout<<"TRIANGLE WORDS : "<<count<<endl;
}
bool checktriangle(int num)
{
	for ( int i = 1 ; trianglenumber(i)<=num;i++)
	{
		if(trianglenumber(i)==num)
			return true;
	}
	return false;
}
double trianglenumber(int num)
{
	return .5*num*(num+1);
}
int word_value(const char word[])
{
	int sum=0;
	for (int i=0;i<strlen(word);i++)
	{
		sum+=word[i]-'A'+1;
	}
	return sum;
}