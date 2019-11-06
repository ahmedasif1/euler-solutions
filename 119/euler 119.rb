#!ruby
require 'set'
t1=Time.now
numbers=SortedSet.new

max = 2**50
for num in 2..10000
	for power in 2..50

		temp=num**power
		next if temp<10
		numbers.add temp
		break if temp>max
	end
end

def sum_of_digits num
	sum=0
	while num>0
		sum+=num%10
		num/=10
	end
	sum
end

def check_power num,base
	while num!=1
		if num%base!=0
			return false
		end
		num/=base
	end
	true
end

n=1
numbers.each do |num|	
	sum=sum_of_digits(num)
	next if sum<=1
	if check_power(num,sum)
		
		puts "#{n} ==> #{num}" if n==30
		break if n==30
		n+=1
	end
end

t2=Time.now

puts "Time taken: "+'%0.2f'%((t2-t1)*1000)+' ms'