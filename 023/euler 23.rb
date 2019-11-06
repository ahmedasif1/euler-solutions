#!ruby
t1 = Time.now
LIMIT = 28123
$abundant_numbers = []
def sum_factors(number)
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
	sum
end

def generate_abundant_numbers
	for i in 2..LIMIT
		if sum_factors(i) > i
			$abundant_numbers.push(i)
		end
	end
end

generate_abundant_numbers()
sum_of_2_abdnt_numbers = Array.new(LIMIT+1,false)
sum = 0
for i in 0..$abundant_numbers.size-1
	break if $abundant_numbers[i]*2 >LIMIT
	for j in i..$abundant_numbers.size-1
		break if $abundant_numbers[i]+$abundant_numbers[j] > LIMIT
		if !sum_of_2_abdnt_numbers[$abundant_numbers[i]+$abundant_numbers[j]]
			sum_of_2_abdnt_numbers[$abundant_numbers[i]+$abundant_numbers[j]]=true
			sum+=$abundant_numbers[i]+$abundant_numbers[j]
		end
	end
end

puts (LIMIT*(LIMIT+1)/2)-sum 
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"