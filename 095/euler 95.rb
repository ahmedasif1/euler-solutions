#!ruby
$divisors={}
$divisor_sum={}
$chain_length={}
$max_length =-1

$limit = 1000000
$min_number = $limit
#generated divisors of numbers in form of
#{number1->[array of divisors], number2->[array of divisors]}
#
def generate_divisors
	for i in 2..$limit/2
		for j in i..$limit/2
			number = i * j
			break if number > $limit
			$divisors[number] = [1] if $divisors[number].nil?
			$divisors[number].push(i)
			$divisors[number].push(j) if (i!=j )
		end
	end
end


def recursive_chain_generator starting_number,current_length,number,chain_members
	result =-1
	#find index of argument "number" in chain_members
	prv_index = chain_members.index(number)

	#the number where chain started has occured
	if starting_number == number and current_length!=0
		result = current_length
	#argument number is present on some index in the chain
	elsif !prv_index.nil?
		#the actual length of amicable chain containing numbers from index(prv_index till end)
		result = chain_members.size - prv_index
	
	#call the recursive function only if required
	elsif (!number.nil?) and (number>=starting_number) and (starting_number != number or (current_length==0 and number==starting_number)) and
	 (number < $limit) and ($chain_length[number].nil? )
	 	#add to chain_members
	 	chain_members.push(number)

		result = recursive_chain_generator(starting_number,current_length+1,$divisor_sum[number],chain_members)
		#remove this number from chain if it is not a member of amicable chain
		if chain_members.size - current_length > result
			result =-1
		end
		#set variables used to calculate result
		if $max_length < result
			$max_length = result
			$min_number = number
		elsif $max_length == result and number < $min_number
			$min_number = number
		end
	end

	$chain_length[number]=result
end

#calls the recursive function recursive_chain_generator on each number
def generate_chain_lengths
	$divisor_sum.each do |num,div_sum|
		chain_members =[]

		recursive_chain_generator(num,0,num,chain_members) if $chain_length[num].nil?
	end
end

def parse_chain starting_number
	array = []
	number = starting_number
	loop do
		array.push number
		number = $divisor_sum[number]
		break if number ==starting_number
	end 
	array.inspect
end
t1=Time.now



generate_divisors()


#creates sum of divisors against each number like 
#{number->sumofdivisors, number2->sumofdivisors}
$divisors.each do |number,div|
	$divisor_sum[number] = div.inject(0) { |sum, var| sum + var  }
end
generate_chain_lengths()

puts "Euler 95 :Minimum Number in Max Length Amicable Chain with Each number <#{$limit}"
puts "Solution: Min Number: #{$min_number} Max Length: #{$max_length}"
puts parse_chain($min_number)
t2=Time.now

puts 'Time :' +'%0.2f'%((t2-t1)*1000) +' ms'