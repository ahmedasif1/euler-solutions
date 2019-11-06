#!ruby
t1 = Time.now
LIMIT = 1000000
$chain_lengths={}


def find_next(num)
	result=nil
	if num%2==0
		result = num/2
	else
		result = num*3+1
	end
	result
end

def calculate_chain_length(starting_number)
	length=0
	current_number = starting_number
	loop do

		x= $chain_lengths[current_number]
		#puts x if not x.nil?
		if not x.nil?
#			puts "found old one #{starting_number} #{current_number} #{length} #{$chain_lengths[current_number]}"
			length+=$chain_lengths[current_number]
			break
		else
			current_number = find_next(current_number)
			length+=1			
		end
		if current_number==1
			length+=1
			break
		end
	end
	$chain_lengths[starting_number]=length
end


max_chain_length=-1
max_st=-1
$chain_lengths[1]=1
for i in 2..LIMIT
	chain_length = calculate_chain_length(i)
	if chain_length > max_chain_length
		max_chain_length = chain_length
		max_st = i
	end	
end

#puts $chain_lengths
puts "starting_number #{max_st} with chain_length: #{max_chain_length}"


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"