#!ruby
t1 = Time.now

$sum_factors=[]
LIMIT = 10000
def sum_factors(number)
	return 0 if not $sum_factors[number].nil?
	sum=0
	limit = Math.sqrt(number)
	is_even = number%2==0
	factor =1
	loop do
		break if factor>limit
		if number%factor==0
			sum+=factor
			sum+=number/factor if (number/factor!=factor and number/factor!=number)
#			puts "#{factor} #{sum}"

		end
		factor+=1
		factor+=1 if !is_even
	end

	$sum_factors[number]=sum
end

sum_of_amicable = 0 
for i in 2..LIMIT
	sum_of_factors = sum_factors(i)
	amic = sum_factors(sum_of_factors)
	if amic==i and 
		sum_of_amicable += i
		sum_of_amicable += sum_of_factors
	end
end
puts sum_of_amicable	

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"