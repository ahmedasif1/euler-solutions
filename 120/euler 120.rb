#!ruby
t1 = Time.now
def modexp a ,b ,n
	
	result = 1
	b=b%n
	while b > 0
		result = (result*a)%n if b%2==1
		b = b>>1
		a=(a**2)%n
	end	
	result
end

#returns ((a+1)^n + (a-1)^n) % a^2
def remainder_a_n a,n
	a_2 = a**2
	#(modexp(a-1,n,a_2) +modexp(a+1,n,a_2))%a_2
	if n%2==0
		return 2
	else
		return (2*a*n)%a_2
	end
end


sum=0
for number in 3..1000
	max=-1
	i=1
	while i <=(2*number)
		temp = remainder_a_n(number,i)
		max = temp  if temp > max
		#keep i odd as remainder_a_n returns higher value for odd n
		i+=2
	end
	sum+=max	
end
t2 = Time.now

#puts remainder_a_n(5,5)
#puts remainder_a_n(5,4)
puts "Sum : #{sum}"
puts 'Time elapsed: ' +'%0.2f'%((t2-t1)*1000) + ' ms'