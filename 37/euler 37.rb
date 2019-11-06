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
def is_primes(number)
	$primes[number]
end

def is_truncatable_primes(prime)
	truncatable = true
	prim1 = prime
	loop do
		prim1/=10
		break if prim1==0 or not truncatable
		truncatable = false if (prim1!=0 and not is_primes(prim1))
	end
	prim1 = prime.to_s

	loop do
		break if not truncatable
		prim1[0]=''
		if prim1.length==0
			break
		elsif prim1[0]=='0' or not is_primes(prim1.to_i)
			truncatable = false
			break
		end
		
	end
	truncatable
end

generate_primes(LIMIT)
#puts is_truncatable_primes(239)
truncatable_prime=[]
for prime in 11..LIMIT
	if is_primes(prime) and is_truncatable_primes(prime)
		truncatable_prime.push prime
	end
end
puts truncatable_prime.inspect
puts "Sum: #{truncatable_prime.inject(0) { |mem, var| mem+=var }}"



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"