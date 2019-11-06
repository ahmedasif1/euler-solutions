#!ruby
#using product of 2 primes to minimize n/totient(n)

t1=Time.now

array_of_primes=[]

LIMIT = 10000
MAX_LIMIT = 10**7
$primes=[]
def generate_primes(limit)
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

def is_permutation(num1,num2)
	num1 = num1.to_s
	num2 = num2.to_s
	num1.split('').sort.join==num2.split('').sort.join
end



generate_primes(LIMIT)
$primes.map.with_index{ |e, index|array_of_primes.push(index) if e}
best_phi = 10000000000
n=nil


for p1 in 250..array_of_primes.size-1
	break if array_of_primes[p1]**2 >=MAX_LIMIT
	for p2 in p1..array_of_primes.size-1
		num1 = array_of_primes[p1]
		num2 = array_of_primes[p2]
		product = num1*num2
		break if product >=MAX_LIMIT
		totient = (num1-1)*(num2-1)
		if is_permutation(product,totient) and Rational(product,totient) < best_phi
			best_phi = Rational(product,totient)
			n= product
			#puts "#{product}   #{best_phi}"
		end
	end
end

puts "#{n}  #{best_phi}"

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'