#include <iostream>
#include <time.h>
 /************************************************************************/
  int one	=		3;
  int two	=		3;
  int three	=		5;
  int four	=		4;
  int five	=		4;
  int six	=		3;
  int seven	=		5;
  int eight	=		5;
  int nine	=		4;
  int ten	=		3;

  int eleven		=	6;
  int twelve		=	6;
  int thirteen	=	8;
  int fourteen	=	8;
  int fifteen	=	7;
  int sixteen	=	7;
  int seventeen	=	9;
  int eighteen	=	8;
  int nineteen	=	8;


  int twenty		=6;
  int thirty		=6;
  int forty		=5;
  int fifty		=5;
  int sixty		=5;
  int seventy	=7;
  int eighty		=6;
  int ninety		=6;
  int hundred	=7;
  int thousand	=8;

  int anD =	3;

 /************************************************************************/

 int xhundred(int num);
 int one_to_nine();
 using namespace std;


 int main()
 {
  clock_t t1,t2;
  t1=clock();
  //code goes here

 	int count=0;
 	count+=xhundred(0);
 	count+=xhundred(one);
 	count+=xhundred(two);
 	count+=xhundred(three);
 	count+=xhundred(four);
 	count+=xhundred(five);
 	count+=xhundred(six);
 	count+=xhundred(seven);
 	count+=xhundred(eighty);
 	count+=xhundred(nine);
 	count+=thousand+one;
 	cout<<count<<endl;
  
  t2=clock();
  float diff ((float)t2-(float)t1);
  cout<<"Time elapsed :"<<diff/(CLOCKS_PER_SEC/1000)<<"ms"<<endl;
 }


 int one_to_nine()
 {
 	return one+two+three+four+five+six+seven +eight+nine;
 }
 int teens()
 {
 	return ten+ eleven+twelve+thirteen+fourteen+fifteen+sixteen+seventeen+eighteen+nineteen;
 }
 int xhundred(int num)
 {
 	int count=0;
 	count+=num*10+one_to_nine()+(num?9*anD+hundred*10:0);//condition if less than 100
 	count+=num*10+teens()+(num?10*anD+hundred*10:0);//condition if less than 100
 	count+=num*10 + twenty*10+one_to_nine()+(num?10*anD+hundred*10:0);//twenty to twenty-nine
 	count+=num*10 + thirty*10+one_to_nine()+(num?10*anD+hundred*10:0);//thirty to thirty-nine
 	count+=num*10 + forty*10+one_to_nine()+(num?10*anD+hundred*10:0);//forty to forty-nine
 	count+=num*10 + fifty*10+one_to_nine()+(num?10*anD+hundred*10:0);//fifty to fifty nine
 	count+=num*10 + sixty*10+one_to_nine()+(num?10*anD+hundred*10:0);//sixty to sixty nine
 	count+=num*10 + seventy*10+one_to_nine()+(num?10*anD+hundred*10:0);//seventy to seventy nine
 	count+=num*10 + eight*10+one_to_nine()+(num?10*anD+hundred*10:0);//eighty to eighty nine
 	count+=num*10 + ninety*10+one_to_nine()+(num?10*anD+hundred*10:0);//ninety to ninety nine
 	return count;
 }
