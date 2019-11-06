#!ruby
t1=Time.now
LIMIT = 100000000

$primes=[]

$array_of_primes=[]

def is_prime(number)
	$primes[number]
end

def generate_primes limit
	for i in 0..limit
		$primes[i]=true
	end
	sqrt = Math.sqrt(limit).ceil
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < sqrt
		if is_prime(prime)
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


generate_primes(LIMIT/2)

t2=Time.now
puts "Primes generated in : #{'%0.2f'%((t2-t1)*1000)} ms"

count=0
for pr1 in 2..Math.sqrt(LIMIT).round
	next if not is_prime(pr1)
	for pr2 in pr1..LIMIT/pr1.ceil
		next if not is_prime(pr2)
		count+=1

	end
end

puts count
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"