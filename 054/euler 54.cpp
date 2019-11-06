#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

int card_to_num(char c)
{
	if(c>='2'&&c<='9')
		return c-'0';
	else if(c=='T')
		return 10;
	else if(c=='J')
		return 11;
	else if(c=='Q')
		return 12;
	else if(c=='K')
		return 13;
	else if (c=='A')
		return 14;
	return -1;
}

void sort(vector<short> & arr)
{
	
	for (unsigned int i=0;i<arr.size();++i)
	{
		
		for (unsigned int j=i+1;j<arr.size();++j)
		{
			if(arr[j]<arr[i])
				swap(arr[i],arr[j]);
		}
	}
}

class poker_hand{
	vector<short> cards;
	vector<char> type;

	bool is_royal_flush()
	{
		return (cards[0]==10)&&is_straight_flush();
	}

	short is_straight_flush()
	{
		if(is_flush()&&is_straight())
			return cards[0];
		return false;
	}
	
	short four_of_a_kind()
	{
		if(count_a_card(cards[0])==4)
			return cards[0];
		else if	(count_a_card(cards[1])==4)
			return cards[1];
		return false;
	}

	bool is_flush()
	{
		char temp=type[0];
		for(int i=0;i<type.size();++i)
		{
			if(temp!=type[i])
				return false;
		}
		return true;
	}

	short is_straight()
	{
		for(int i=0;i<cards.size()-1;++i)
		{
			if((cards[i]+1)!=cards[i+1])
				return false;
		}
		return cards[0];
	}

	bool full_house()
	{
		return one_pair()&&three_of_kind();
	}
	
	short count_a_card(short & num)
	{
		short count=0;
		for(int i=0;i<cards.size();++i)
		{
			if(cards[i]==num)
				++count;
		}
		return count;
	}

	short one_pair()
	{
		for(int i=0;i<cards.size();++i)
			if(count_a_card(cards[i])==2)
				return cards[i];
		return false;
	}
	
	short three_of_kind()
	{
		for(int i=0;i<cards.size();++i)
		{
			if(count_a_card(cards[i])==3)
				return cards[i];
		}
		return false;
	}
	
	short second_pair()
	{
		short pair1=one_pair();
		if(pair1==0)
			return false;
		for (int i=0;i<cards.size();++i)
		{
			if(pair1!=cards[i] && count_a_card(cards[i])==2)
				return cards[i];
		}
		return false;
	}

	bool two_pairs()
	{
		return second_pair();
	}

	short rank()
	{
		if(is_royal_flush())
			return 1;
		else if(is_straight_flush())
			return 2;
		else if(four_of_a_kind())
			return 3;
		else if(full_house())
			return 4;
		else if(is_flush())
			return 5;
		else if(is_straight())
			return 6;
		else if(three_of_kind())
			return 7;
		else if(two_pairs())
			return 8;
		else if(one_pair())
			return 9;
		return 10;


	}






public:
	poker_hand(vector<short>vec1,vector<char> vec2)
	{
		cards=vec1;
		sort(cards);
		type=vec2;
	}
	bool compare(poker_hand & hand)
	{
		short rank_1=this->rank();
		short rank_2=hand.rank();
		short high_card1;
		short high_card2;
		if(rank_1==rank_2)
		{

			//cannot be royal flush
			//straight flush
			if(rank_1==2)
			{
				high_card1=cards[4];
				high_card2=hand.cards[4];
			}

			//four of a kind
			else if(rank_1==3)
			{
				high_card1=four_of_a_kind();
				high_card2=hand.four_of_a_kind();
				
				
			}

			//full house
			else if(rank_1==4)
			{
				high_card1=three_of_kind();
				high_card2=hand.three_of_kind();
				
			}
			//flush
			else if(rank_1==5)
			{
				high_card1=0;
				high_card2=0;
				int i=4;
				while(high_card1==high_card2)
				{
					
					high_card1=cards[i];
					high_card2=hand.cards[i];
					if(i==0)
						break;
					else --i;
				}

			}



			//straight
			else if(rank_1==6)
			{
				high_card1=cards[4];
				high_card2=hand.cards[4];
			}
			//three of a kind
			else if(rank_1==7)
			{
				high_card1=three_of_kind();
				high_card2=hand.three_of_kind();
			}
			//2 pair
			else if(rank_1==8)
			{
				short first_pair1=one_pair();
				short first_pair2=hand.one_pair();
				short second_pair1=second_pair();
				short second_pair2=hand.second_pair();

				if(first_pair1>second_pair1)
					swap(first_pair1,second_pair1);
				if(first_pair2>second_pair2)
					swap(first_pair2,second_pair2);

				if(second_pair1==second_pair2)
				{
					if(first_pair2==first_pair1)
					{
						for (int i=0;i<cards.size();++i)
						{
							if(cards[i]!=first_pair1 && cards[i]!=second_pair1 )
								high_card1=cards[i];
							if(hand.cards[i]!=first_pair2 && hand.cards[i]!=second_pair1 )
								high_card2=hand.cards[i];
						}
					}
					else {
						high_card1 =first_pair1;
						high_card2 = first_pair2;
					}

				}
				else{
					high_card1=second_pair1;
					high_card2=second_pair2;
				}


			}
			//one pair
			else if(rank_1==9)
			{
				high_card1=one_pair();
				high_card2=hand.one_pair();
				if(high_card1==high_card2)
				{
					int i=4;
					while(high_card1==high_card2)
					{

						high_card1=cards[i];
						high_card2=hand.cards[i];
						if(i==0)
							break;
						else --i;
					}
				}
			}


			//high card
			else if(rank_1==10)
			{
				high_card1=cards[4];
				high_card2=hand.cards[4];
			}
		
			return high_card1>high_card2;

		}
		else return rank_1<rank_2;
	}





};




int main()
{
	string filename="p054_poker.txt";
	
	ifstream fin(filename.c_str());
	vector<short> cards;
	vector<char> type;
	char a;
	bool flag=true;
	int player_1_count=0;
	int player_2_count=0;
	poker_hand * hands[2];
	while(!fin.eof())
	{
		cards.clear();
		type.clear();

		for(int i=0;i<2;++i)
		{
			cards.clear();
			type.clear();
			for(int j=0;j<5;++j)
			{
				fin>>a;
				if(fin.eof())
				{flag=false;break;}
				cards.push_back(card_to_num(a));
				fin>>a;
				type.push_back(a);
			}
			if(!flag)
				break;
			hands[i]=new poker_hand(cards,type);
		}
		if(!flag)
			continue;
		if(hands[0]->compare(*(hands[1])))
			++player_1_count;
		else ++player_2_count;
		delete hands[0];
		delete hands[1];
	}

	cout<<"Player 1 Count "<<player_1_count<<endl;
	cout<<"Player 2 Count "<<player_2_count<<endl;




}