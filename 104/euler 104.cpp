#include <iostream>
#include <chrono>
using namespace std;


//class for handling addition of long numbers using char arrays internally
#include <string>
class LongInt
{
	char * number = nullptr;
	int length;
	int maxSize;
	void doubleLength(){
		int newLength = maxSize * 2;
		char * newArray = new char[newLength];
		int i = 0;
		for (; i < length; ++i){
			newArray[i] = number[i];
		}
		newArray[i] = '\0';
		delete[] number;
		number = newArray;
		maxSize = newLength;
	}
	bool panadigitalInIndexes(int start, int end){

		bool panadigital = true;
		bool array[10];
		for (int i = 0; i < 10; ++i){ array[i] = false; }
		for (int i = start; i < end; ++i){
			array[number[i] - '0'] = true;
		}

		for (int i = 1; i < 10; ++i){
			if (!array[i]){
				panadigital = false;
				break;
			}
		}
		return panadigital;
	}
public:
	LongInt(std::string str){
		maxSize = 1000;
		length = str.length();
		number = new char[maxSize];

		int i = 0;
		for (i = 0; i < length; ++i){
			number[i] = str[length - i - 1];
		}
		number[i] = '\0';

	}
	~LongInt(){
		delete[] number;
	}
	void add(const LongInt & addend){
		if (maxSize < length + 10){
			doubleLength();
		}

		int sum = 0;
		int remainder = 0;
		int i = 0;
		for (; i < length && i < addend.length; ++i){
			sum = number[i] - '0' + addend.number[i] - '0' + remainder;
			remainder = sum / 10;
			number[i] = sum % 10 + '0';
		}
		while (i < length)
		{
			sum = number[i] - '0' + remainder;
			remainder = sum / 10;
			number[i] = sum % 10 + '0';
			++i;
		}

		while (i < addend.length)
		{
			sum = addend.number[i] - '0' + remainder;
			remainder = sum / 10;
			number[i] = sum % 10 + '0';
			++i;
			++length;
		}

		if (remainder>0){
			number[i++] = remainder + '0';
			++length;
		}

		number[i] = '\0';
	}
	static void swap(LongInt & param1, LongInt & param2){
		char * temp = param1.number;
		param1.number = param2.number;

		int len = param1.length;
		param1.length = param2.length;

		int mxLen = param1.maxSize;
		param1.maxSize = param2.maxSize;

		param2.number = temp;
		param2.maxSize = mxLen;
		param2.length = len;

	}
	void print(){
		for (int i = 0; i < length; ++i){
			std::cout << number[length - i - 1];
		}
		std::cout << std::endl;
	}
	bool panadigitalStart(){
		bool result = false;
		if (length >= 10){
			result = panadigitalInIndexes(length - 9, length);
		}
		return result;
	}
	bool panadigitalEnd(){
		bool result = false;
		if (length >= 10){
			result = panadigitalInIndexes(0, 9);
		}
		return result;

	}
};



int main(){
	auto start = std::chrono::system_clock::now();

	cout << "Euler 104" << endl;
	LongInt fib1("1");
	LongInt fib2("1");
	int k = 2;

	//Fib2 contains the smaller b4 edition
	while (true){
		++k;
		fib2.add(fib1);
		LongInt::swap(fib1, fib2);
		if (fib1.panadigitalEnd()){
			if (fib1.panadigitalStart()){
				cout << "Fibonacci number with panadigital start and end: " << k << endl;
				break;
			}
			 
		}
	}

	auto end = std::chrono::system_clock::now();

	auto elapsed =
		std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

	cout << "Elapsed time(ms): " << elapsed.count() << endl;
}