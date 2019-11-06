#!ruby
t1=Time.now

LIMIT =100000000
$primes=[]

def is_prime(num)
	$primes[num]
end

def generate_primes(limit)
	for i in 0..limit
		$primes[i]=true
	end
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < limit
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


generate_primes(LIMIT+2)
t2=Time.now
puts "Primes generated in #{'%0.2f'%((t2-t1)*1000)} ms"
sum=1
for product in 1..LIMIT
	next if product%2==1
	prime_gen = true
	for factor in 1..Math.sqrt(product).to_i
		if product % factor == 0 and not is_prime(product/factor+factor)
			prime_gen = false
			break
		end
	end
	if prime_gen
		sum+=product
		#puts "#{product} #{sum}"
	end

end

puts sum

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'