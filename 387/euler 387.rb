#!ruby
t1=Time.now
$primes=nil
MAX_LIMIT = 10**14

def is_prime(num)
	
	if num <$primes.size
		prime = $primes[num]
	else
		prime = num%2!=0
		limit = Math.sqrt(num).round
		i=3
		while prime
			break if i >limit
			prime = (num % i) !=0
		i+=2
		end
	end	
	prime
end


def generate_primes(limit)
	$primes = Array.new(limit+1,true)
	#puts "Memory initialized"
	$primes[0] = $primes[1] = false
	number = 4
	loop do
		break if number > limit
		$primes[number]=false
		number+=2
	end
	number = 3
	loop do
		if is_prime(number)
			st = number**2
			loop do
				break if st > limit
				$primes[st]=false
				st+=number*2
			end
		end
		number+=2
		break if number**2>limit
	end
end

def sum_of_digits(num)
	num.to_s.split('').inject(0){|m,v|m+=v.to_i}
end
$min_num=111111111111
$max_num=-1

#when passed a right truncatable strong harshad
#gives sum of primes made by concatinating one digit to the right
def get_sum_of_primes_by_concatinating_1_digit(num)
	sum=0
	i=1
	#multiply by 10
	num*=10
	loop do #add numbers 1 to 9 (only odds to create prime numbers)
		break if i==11
		temp_num = num+i
		if is_prime(temp_num) #if prime increment sum
			sum+=(temp_num)
			if $min_num > temp_num
				$min_num = temp_num
			end
			if $max_num < temp_num
				$max_num = temp_num
			end
		end
		i+=2
	end
	sum
end
#queue containing right truncatable harshad primes
right_truncatable_harshads=[1,2,3,4,5,6,7,8,9]




#dividing limit by 100
#the inner loop and get_sum_of_primes_by_concatinating_1_digit, both add one digit each
max_limit=MAX_LIMIT/100
generate_primes(Math.sqrt(max_limit))
loop_limit = 10
sum = 0
loop do
	number = right_truncatable_harshads.first
    
	if number>=loop_limit #at this point all numbers in the array have same number of digits and are right truncatable harshads
		loop_limit*=10
		break if loop_limit > max_limit
	end

	number=right_truncatable_harshads.shift
	#puts "#{number} #{right_truncatable_harshads.inspect}"
	number*=10
	for i in 0..9
		temp_num = number+i
		if temp_num%sum_of_digits(temp_num)==0
			right_truncatable_harshads.push(temp_num)

			factor = temp_num/sum_of_digits(temp_num)
			#puts "#{temp_num} #{sum_of_digits(temp_num)}  #{factor}"
			if is_prime(factor) 
				#puts "#{factor}"
				sum+=get_sum_of_primes_by_concatinating_1_digit(temp_num)
			end
		end
	end
end

puts sum

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'