#!ruby
t1 = Time.now
LIMIT=500 #greater than 500 divisors of triangle numbers


def count_factors(number)
	count=0
	limit = Math.sqrt(number)
	is_even = number%2==0
	factor =1
	loop do
		break if factor>limit
		if number%factor==0
			count+=2
#			puts "#{factor} #{count}"

		end
		factor+=1
		factor+=1 if !is_even
	end
	count
end

sum = 0
num=1 
prv_factors =0
loop do
	sum+=num
	num+=1
	factors = count_factors(sum)
	if prv_factors < factors
		puts "#{num} #{sum} #{factors}"
		prv_factors =factors
	end
	
	if factors>LIMIT
		break
	end
end


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"