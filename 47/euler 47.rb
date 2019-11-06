#!ruby
t1 = Time.now
LIMIT = 1000000
$primes=[]
def generate_primes limit
	for i in 0..limit
		$primes[i]=true
	end
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < limit
		if $primes[prime]
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
def is_prime(number)
	$primes[number]
end

def count_prime_factors(number)
	count=0
	limit = Math.sqrt(number)
	prv_factor=-1
	factor =1
	loop do
		break if number==1
		if is_prime(factor) and number%factor==0
			#puts "#{number}  #{factor}"
			count+=1 if prv_factor!=factor
			number/=factor
			prv_factor=factor
		elsif is_prime(number) and prv_factor!=number
			#puts "#{number}  #{factor}"	
			count+=1
			prv_factor =factor
			break
		elsif is_prime(number)
			break
		else
			factor+=1
		end
	end
	count
end

generate_primes(LIMIT)

num = 6
count=0
loop do
	if count_prime_factors(num)==4
		count+=1
	else
		count=0
	end
	break if count==4
	num+=1
end
puts num-3

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"