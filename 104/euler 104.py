import math
current=3

fib_1=1 #previous
fib_2=1 #latest

def first_and_last_panadigital(num):

	array=[False,False,False,False,False,False,False,False,False,False]
	
	last=int(num%1000000000)
	while last!=0:
	 	array[int(last%10)]=True
	 	last/=10
	
	for i in range(1,10):
		if array[i]==False:
	 		return False

	if num <1000000000:
		return False
	lg=int(math.log(num)/math.log(10))
	pow=10**(lg-9+1)
	last= int(num/(pow))


	array=[False,False,False,False,False,False,False,False,False,False]
	while last!=0:
		array[int(last%10)]=True
		last/=10
			
	for i in range(1,10):
		if array[i]==False:
			return False
	return True


while True:
	fib_1 =fib_1+fib_2
	#fib_1 =fib_1%1000000000
	fib_1,fib_2 =fib_2,fib_1
	if first_and_last_panadigital(fib_2): #or current==2750: 
		break
	current+=1
print(current)

