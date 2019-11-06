#!ruby
require 'set'
t1=Time.now

$target = Rational(15499,94744)
primes =[2,3,5,7,11,13,17,19,23,29,31]

LIMIT = 1000

$primes={}
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



=begin
1) Initialize result as n
2) Consider every number 'p' (where 'p' varies from 2 to √n). 
   If p divides n, then do following
   a) Subtract all multiples of p from 1 to n [all multiples of p
      will have gcd more than 1 (at least p) with n]
   b) Update n by repeatedly dividing it by p.
3) If the reduced n is more than 1, then remove all multiples
   of n from result.
=end


def totient(number)
	result = number
	sq = Math.sqrt(number).to_i
	for p in 2..sq
		break if number==1
		if number%p==0
			result-=result/p
			loop do
				break if not number%p==0
				number/=p
			end
		end
	end
	if (number > 1)
        result -= result / number;
    end
    result
end



def resilience(denominator)
	if is_primes(denominator)
		return Rational(denominator-1,denominator-1)
	end
	Rational(totient(denominator),denominator-1)
end
res=nil
n=0
generate_primes(LIMIT)

product = 1
loop do
	product*=primes[n]
	res = resilience(product)
	if res <$target #try to multiply numbers smaller than primes[n]
		break
	end
	n+=1
end
limit = primes[n]

product2=product/primes[n]

for i in 2..primes[n]-1
	res = resilience(product2*i)
	if res <$target #solution found
		product=product2*i
		break
	end
end
puts "Target Resilience: #{$target.to_f}"
puts "Solution: #{product}  \nResilience of solution: #{resilience(product).to_f}"

t2=Time.now


puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'