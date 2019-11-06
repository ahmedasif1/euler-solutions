#!ruby
t1 = Time.now
NUMBER = 600851475143
sum=0
$primes=[]

def generate_primes(limit)
	for i in 0..limit
		$primes[i]=true
	end
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < limit
		multiple=prime**2
		while multiple <= limit
			$primes[multiple]=false
			multiple+=prime
		end
		if prime==2
			prime+=1
		else
			prime+=2
		end
	end
end

sqrt = (Math.sqrt(NUMBER)+10).to_i
generate_primes(sqrt)
sqrt.downto(2) do |number|
	if $primes[number] and NUMBER%number ==0
		puts number
		break
	end
end
t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
