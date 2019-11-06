#include <iostream>
#include <fstream>
#include <string>
#include <set>
#include <algorithm>
#include <typeinfo>
#include <string.h>
#include <chrono>
using namespace std;
const int dimension =9;


int solve_sudoku(int sudoku[][dimension]);

int find_in_line(int sudoku[][dimension],int row,int col,int num,int dr,int dc)
{
	int count=0;
	for(int r=row,c=col;r<dimension && c<dimension;r+=dr,c+=dc)
		if(sudoku[r][c]==num)
			++count;
	return count;
}

bool find_in_block(int sudoku[][dimension],int row,int col,int num)
{
	int count=0;
	for(int i = -(row%3);i<=(2-row%3);++i)	
		for(int j = -(col%3);j<=(2-col%3);++j)
			if(sudoku[row+i][col+j]==num)
				++count;

	return count;
}

bool is_valid_sudoku(int sudoku[][dimension])
{
	for(int num=1;num<=dimension;++num)
	{
		for(int i=0;i<dimension;++i)
		{
			//find in row
			int n1=find_in_line(sudoku,i,0,num,0,1);
			//find in col
			int n2= find_in_line(sudoku,0,i,num,1,0);
			//find in block
			int n3=find_in_block(sudoku,i-i%3,(i%3)*3,num);
			if(n1>1||n2>1||n3>1)
				return false;
			if(n1==0)
			{
				bool place_found=false;
				for(int c=0;c<dimension;++c)
				{
					if(sudoku[i][c]!=0)
						continue;
					if(!(find_in_line(sudoku,0,c,num,1,0)||find_in_block(sudoku,i,c,num)))
					{place_found=true;break;}
				}
				if(!place_found)
					return false;
			}

			if(n2==0)
			{
				bool place_found=false;
				for(int r=0;r<dimension;++r)
				{
					if(sudoku[r][i]!=0)
						continue;
					if(!(find_in_line(sudoku,r,0,num,0,1)||find_in_block(sudoku,r,i,num)))
					{place_found=true;break;}
				}
				if(!place_found)
					return false;
			}


			if(n3==0)
			{
				bool place_found=false;
				for(int row=i-i%3;row<i-i%3+3;++row)
				{
					for(int col = (i%3)*3;col<(i%3)*3+3;++col)
					{
						if(sudoku[row][col]!=0)
							continue;
						if(!(find_in_line(sudoku,0,col,num,1,0)||find_in_line(sudoku,row,0,num,0,1)))
						{place_found=true;break;}
					}
				}
				if(!place_found)
					return false;
			}

		}
	}
	return true;
}



void print_sudoku(int sudoku[][dimension])
{
	for(int i=0;i<dimension;++i)
	{
		for (int j=0;j<dimension;++j)
		{
			cout<<sudoku[i][j]<<' ';
		}
		cout<<endl;
	}
	cout<<endl;
}



void row_move(int sudoku[][dimension],int row)
{
	for (int num=1;num<=9;++num)
	{
		int col=-1;
		bool flag=false;
		for(int c=0;c<dimension;++c)
		{
			if(sudoku[row][c]==num)
			{flag=true;break;}
			if(sudoku[row][c]!=0)
				continue;
			if(!(find_in_line(sudoku,0,c,num,1,0) || find_in_block(sudoku,row,c,num)))
			{
				if(col==-1)
				{
					col=c;
				}
				else
				{
					flag=true;
				}
			}
		}
		if(!flag && col!=-1)
		{
			sudoku[row][col]=num;
		}
	}
}
void col_move(int sudoku[][dimension],int col)
{
	for (int num=1;num<=9;++num)
	{
		int row=-1;
		bool flag=false;
		for(int r=0;r<dimension;++r)
		{
			if(sudoku[r][col]==num)
			{flag=true;break;}
			if(sudoku[r][col]!=0)
				continue;
			if(!(find_in_line(sudoku,r,0,num,0,1) || find_in_block(sudoku,r,col,num)))
			{
				if(row==-1)
				{
					row=r;
				}
				else
				{
					flag=true;
				}
			}
		}
		if(!flag && row!=-1)
		{
			sudoku[row][col]=num;
		}
	}
}
int spaces_in_row(int sudoku[][dimension],int row)
{
	int count=0;
	for (int c=0;c<dimension;++c)
	{
		if(sudoku[row][c]==0)
			++count;
	}
	return count;
}

int spaces_in_col(int sudoku[][dimension],int col)
{
	int count=0;
	for (int r=0;r<dimension;++r)
	{
		if(sudoku[r][col]==0)
			++count;
	}
	return count;
}
int spaces_in_block(int sudoku[][dimension],int block)
{
	int count=0;
	for(int row=block-block%3;row<block-block%3+3;++row)
	{
		for(int col = (block%3)*3;col<(block%3)*3+3;++col)
		{
			if(sudoku[row][col]==0)
				++count;
		}
	}
	return count;
}


template<typename T>
pair<T,int> move_3_helper(set<T>sets[],int nums[])
{
	set<T>result;
	if(sets[0].size()==2 && sets[0]==sets[1])
	{
		set_difference(sets[2].begin(),sets[2].end(),sets[0].begin(),sets[0].end(),inserter(result,result.end()));
		if(result.size()==0)
			throw 1;
		return pair<T,int>(*(result.begin()),nums[2]);
	}

	else if(sets[0].size()==2 && sets[0]==sets[2])
	{
		set_difference(sets[1].begin(),sets[1].end(),sets[0].begin(),sets[0].end(),inserter(result,result.end()));
		if(result.size()==0)
			throw 1;
		return pair<T,int>(*(result.begin()),nums[1]);
	}
	else if(sets[1].size()==2 && sets[1]==sets[2])
	{
		set_difference(sets[0].begin(),sets[0].end(),sets[1].begin(),sets[1].end(),inserter(result,result.end()));
		if(result.size()==0)
			throw 1;
		return pair<T,int>(*(result.begin()),nums[0]);
	}		

	if(sets[0].size()==0)
		throw "exception";
	return pair<T,int>(*(sets[0].begin()),-1);
}


void row_move_3(int sudoku[][dimension],int row)
{
	bool numbers[dimension+1];
	for (int i=1;i<dimension+1;++i)
	{numbers[i]=false;}
	for (int c=0;c<dimension;++c)
		numbers[sudoku[row][c]]=true;
	int required_nums[3];
	set<int>sets[3];
	int i=0;
	for (int num=1;num<=dimension;++num)
	{
		if(numbers[num])
			continue;
		required_nums[i]=num;

		for (int c=0;c<dimension;++c)
		{
			if(sudoku[row][c]==0 && !(find_in_line(sudoku,0,c,num,1,0)||find_in_block(sudoku,row,c,num)))
				sets[i].insert(c);		
		}
		++i;
	}
	
	pair<int,int> p =move_3_helper<int>(sets,required_nums);
	if(p.second!=-1)
		sudoku[row][p.first]=p.second;

}
void col_move_3(int sudoku[][dimension],int col)
{
	bool numbers[dimension+1];
	for (int i=1;i<dimension+1;++i)
	{numbers[i]=false;}
	for (int r=0;r<dimension;++r)
		numbers[sudoku[r][col]]=true;
	int required_nums[3];
	set<int>sets[3];
	int i=0;


	for (int num=1;num<=dimension;++num)
	{
		if(numbers[num])
			continue;
		required_nums[i]=num;

		for (int r=0;r<dimension;++r)
		{
			if(sudoku[r][col]==0 && !(find_in_line(sudoku,r,0,num,0,1)||find_in_block(sudoku,r,col,num)))
				sets[i].insert(r);		
		}
		++i;
	}
	
	pair<int,int> p =move_3_helper<int>(sets,required_nums);
	if(p.second!=-1)
		sudoku[p.first][col]=p.second;
}

void block_move_3(int sudoku[][dimension],int block)
{
	bool numbers[dimension+1];
	for (int i=1;i<dimension+1;++i)
	{numbers[i]=false;}
	for(int row=block-block%3;row<block-block%3+2;++row)
	{
		for(int col = (block%3)*3;col<(block%3)*3+2;++col)
		{
			numbers[sudoku[row][col]]=true;
		}
	}
	int required_nums[3];
	set<pair<int,int>>sets[3];
	int i=0;


	for (int num=1;num<=dimension;++num)
	{
		if(numbers[num])
			continue;
		required_nums[i]=num;

		for(int row=block-block%3;row<block-block%3+3;++row)
		{
			for(int col = (block%3)*3;col<(block%3)*3+3;++col)
			{
				if(sudoku[row][col]==0 && !(find_in_line(sudoku,0,col,num,1,0)||find_in_line(sudoku,row,0,num,0,1)))
					sets[i].insert(pair<int,int>(row,col));		
			}
		}
		++i;
	}
	pair<pair<int,int>,int> p = move_3_helper(sets,required_nums);
	if(p.second!=-1)
	{
		sudoku[p.first.first][p.first.second]=p.second;
	}
}

void block_move(int sudoku[][dimension],int block)
{
	for (int num=1;num<=9;++num)
	{
		bool flag=false;
		int r=-1;
		int c=-1;
		for(int row=block-block%3;row<block-block%3+3;++row)
		{
			for(int col = (block%3)*3;col<(block%3)*3+3;++col)
			{
				if(sudoku[row][col]==num)
				{flag=true;break;}
				if(sudoku[row][col]!=0)
					continue;
				if(!(find_in_line(sudoku,row,0,num,0,1)||find_in_line(sudoku,0,col,num,1,0)))
				{
					if(r==-1)
					{
						r=row;c=col;
					}
					else
					{
						flag=true;
					}
				}
			}
			if(flag)break;
		}
		if(!flag && c!=-1)
		{
			sudoku[r][c]=num;
		}
	}
}

void copy_sudoku(int dest[][dimension],int source[][dimension])
{
	for (int i=0;i<dimension;++i)
	{
		for(int j=0;j<dimension;++j)
		{
			dest[i][j]=source[i][j];
		}
	}
}


void try_row_move(int sudoku[][dimension],int row)
{
	for(int num=1;num<=dimension;++num)
	{
		if(find_in_line(sudoku,row,0,num,0,1))		
			continue;
		set<int> possibilities;

		for(int c=0;c<dimension;++c)
		{
			if(sudoku[row][c]==0 && !(find_in_line(sudoku,0,c,num,1,0) || find_in_block(sudoku,row,c,num)))
			{
				possibilities.insert(c);
			}
		}
		
		if(possibilities.size()==2)
		{
			int new_sudoku[dimension][dimension];
			copy_sudoku(new_sudoku,sudoku);
			auto iter = possibilities.begin();
			if(rand()%2)
			{
				new_sudoku[row][*iter]=num;
				if(solve_sudoku(new_sudoku)==-1)
				{
					++iter;
					sudoku[row][*iter]=num;
				}
				else
				{
					copy_sudoku(sudoku,new_sudoku);
				}
			}
			else
			{
				++iter;
				new_sudoku[row][*iter]=num;
				if(solve_sudoku(new_sudoku)==-1)
				{
					--iter;
					sudoku[row][*iter]=num;
				}
				else
				{
					copy_sudoku(sudoku,new_sudoku);
				}
			}
			return;
		}

	}
}




int solve_sudoku(int sudoku[][dimension])
{
	for(int j=0;j<4;++j)
	{
		for(int i=0;i<dimension;++i)
		{
			if(!is_valid_sudoku(sudoku))
			{
				return -1;
			}
			try{
				row_move(sudoku,i);
				col_move(sudoku,i);
				block_move(sudoku,i);
				if(spaces_in_row(sudoku,i)==3)
					row_move_3(sudoku,i);			
				if(spaces_in_col(sudoku,i)==3)
					col_move_3(sudoku,i);			
				if(spaces_in_block(sudoku,i)==3)
					block_move(sudoku,i);
				if(j>1 && j%2==0)
					try_row_move(sudoku,i);
			}
			catch(...)
			{
				return -1;
			}
		}
	}	
	
	return sudoku[0][0]*100+sudoku[0][1]*10+sudoku[0][2];	
}


int main()
{
	std::chrono::steady_clock::time_point start = std::chrono::steady_clock::now() ;
	string filename = "sudoku.txt";
	ifstream fin(filename);
	char ch;
	int sudoku[dimension][dimension];
	int result=0;
	while(!fin.eof())
	{
		getline(fin,filename);
		if(fin.eof())break;
		
		for (int i=0;i<dimension;++i)
		{
			for (int j=0;j<dimension;++j)
			{
				fin>>ch;
				sudoku[i][j]=ch-'0';
			}
		}
	//	print_sudoku(sudoku);
		result+=solve_sudoku(sudoku);
//		print_sudoku(sudoku);
		getline(fin,filename);
		//break;		
	}
	std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now() ;

	typedef std::chrono::duration<int,std::milli> millisecs_t ;
	millisecs_t duration( std::chrono::duration_cast<millisecs_t>(end-start) ) ;	
	cout<<result<<endl;
	std::cout << duration.count() << " milliseconds.\n" ;
}