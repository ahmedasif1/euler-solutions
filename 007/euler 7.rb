#!ruby
t1 = Time.now

limit = 200000
n_th_prime = 10001
$primes=[]

def is_prime(num)
	return $primes[num]
end

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

generate_primes(limit+1)

count=0
for i in 2..limit
	if is_prime(i)
		count+=1
	end
	if count ==n_th_prime
		puts i
		break
	end
end

t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
