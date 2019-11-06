#!ruby
t1=Time.now
#   --		1
#  |  |	   2 3
#   --		4
#  |  |	   5 6
#   --      7
#   
#   
LIMIT = 2*10**7
STARTING = 10**7
OFF ="OFF"
LEDS = {}
LEDS[0]=[true,true,true,false,true,true,true]
LEDS[1]=[false,false,true,false,false,true,false]
LEDS[2]=[true,false,true,true,true,false,true]
LEDS[3]=[true,false,true,true,false,true,true]
LEDS[4]=[false,true,true,true,false,true,false]
LEDS[5]=[true,true,false,true,false,true,true]
LEDS[6]=[true,true,false,true,true,true,true]
LEDS[7]=[true,true,true,false,false,true,false]
LEDS[8]=[true,true,true,true,true,true,true]
LEDS[9]=[true,true,true,true,false,true,true]
LEDS[OFF] = [false,false,false,false,false,false,false]

$transition_from_X_to_Y=[]
$leds_for_digit={}
$primes={}
$transition_cache_max={}
$transition_cache_sam={}


def print_number(num)
	if LEDS[num][0]
		puts " -- "	
	else
		puts "    "	
	end
	if LEDS[num][1]
		print "|  "
	else
		print "   "
	end
	if LEDS[num][2]
		print "|"
	else
		print ""
	end
	puts
	if LEDS[num][3]
		puts " -- "	
	else
		puts "    "	
	end
	if LEDS[num][4]
		print "|  "
	else
		print "   "
	end
	if LEDS[num][5]
		print "|"
	else
		print ""
	end
	puts
	if LEDS[num][6]
		puts " -- "	
	else
		puts "    "	
	end
end


def generate_primes(limit)
	for i in 0..limit
		$primes[i]=true
	end
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < limit
		if is_primes(prime)
			multiple=prime**2
			while multiple <= limit
				$primes[multiple]=false
				multiple+=prime
			end
		end
		if prime==2
			prime+=1
		else
			prime+=2
		end
	end
end

def is_primes(number)
	return $primes[number]
end

def count_leds_in_digit(digit)
	if $leds_for_digit[digit].nil?
		$leds_for_digit[digit] = LEDS[digit].inject(0){|m,v|v ? m+=1 : m }
	end
	$leds_for_digit[digit]
end

def count_leds(number)
	count = 0
	if not number.nil?
		loop do
			count+=count_leds_in_digit(number%10)
			number/=10
			break if number==0
		end
	end
	count
end


def transitions_clock_1(previous,nxt)
	return count_leds(previous)+count_leds(nxt)
end

def count_differences_in_led(digit_prv,digit_nxt)
	count=0
	if $transition_from_X_to_Y[digit_prv][digit_nxt].nil?

		array1 = LEDS[digit_prv]
		array2 = LEDS[digit_nxt]

		for i in 0..array1.size-1
			count+=1 if array1[i]!=array2[i]
		end
		$transition_from_X_to_Y[digit_prv][digit_nxt] = count
	else
		count = $transition_from_X_to_Y[digit_prv][digit_nxt]
	end
	count
end

def transitions_clock_2(previous,nxt)
	count = 0
	array_prv = previous.to_s.split('').reverse.map { |e| e.to_i  }
	array_nxt = nxt.to_s.split('').reverse.map { |e| e.to_i  }
	#puts "#{array_prv.size} #{array_nxt.size}"
	i=0
	loop do
		count+=count_differences_in_led(array_prv[i],array_nxt[i])
		#puts "#{array_prv[i]}    #{array_nxt[i]}"
		i+=1
		break if i >=array_nxt.size
	end
	loop do
		break if i >=array_prv.size
		#puts "#{array_prv[i]}    #{LEDS[OFF]}"
		count+=count_differences_in_led(array_prv[i],OFF)
		i+=1		
	end
	count
end



def digital_root(num)
	num.to_s.split('').inject(0){|m,v|m+=v.to_i}
end


def generate_primes_from_A_to_B(a,b)
	sqrt_b = Math.sqrt(b).to_i
	generate_primes(sqrt_b)
	for i in a..b
		$primes[i]=true
	end
	for i in 2..sqrt_b
		if is_primes(i)
			number = a/i*i
			number+=i if i==number
			loop do 
				$primes[number]=false
				number+=i
				break if number > b
			end
		end
	end
end

generate_primes_from_A_to_B(STARTING,LIMIT)

for i in 0..10
	$transition_from_X_to_Y.push({})
end

total_count_max = 0
total_count_sam = 0
start = STARTING+1
loop do
	number = start
	count_max=0
	count_sam=0
	if is_primes(number)
		#puts number
		count = count_leds(number)
		total_count_sam += count
		total_count_max += count
		
		loop do
			break if number/10==0
			root = digital_root(number)
			total_count_sam += transitions_clock_2(number,root)
			total_count_max += transitions_clock_1(number,root)
			#puts "#{number} #{root} #{count}"
			number = root
		end
		total_count_sam += count_leds(number)
		total_count_max += count_leds(number)
	end
	start+=2
	break if start >= LIMIT
end

puts total_count_max-total_count_sam

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'