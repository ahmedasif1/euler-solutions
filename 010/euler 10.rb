#!ruby
t1 = Time.now
LIMIT = 2000000
$sum_of_primes=0

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
			$sum_of_primes+=prime
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

generate_primes(LIMIT)
puts $sum_of_primes

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"