#!ruby
#Euler 381
#using Wilson theorem which says:
#(p-1)! = -1 mod p
t1=Time.now
$limit = 100000000
$primes=[]

#calculates multiplicative inverse using 
#extended euclidean algorithm
def inverse(a,n)
	t=1
	r=a
	old_t=0
	old_r=n

	loop do 
		break if r==0
		q=old_r/r
		old_r,r = r, (old_r-q*r)
		old_t,t = t, (old_t-q*t)
	end
	if old_r > 1
		return nil
	end
	return old_t%n
end

def is_prime(n)
	if n==2
		return true
	elsif n ==0 || n==1 || n%2==0
		return false
	else
		return $primes[n]
	end
			
end


def generate_primes(limit)
	$primes = Array.new(limit+1,true)
	#puts "Memory initialized"
	$primes[0] = $primes[1] = false
	number = 3
	loop do
		if is_prime(number)
			st = number**2
			loop do
				break if st > limit
				$primes[st]=false
				st+=number*2
			end
		end
		number+=2
		break if number**2>limit
	end
end

def find_factorial_mod_sum_wilson(p)

	fail = false
	p1 = p-1
	inv =inverse(p-1,p)
	fail  = true if inv.nil?
	
	p2 = (p1*inv)%p  if not fail
	inv =inverse(p-2,p) if not fail
	fail  = true if inv.nil?

	p3 = (p2*inv)%p  if not fail
	inv =inverse(p-3,p)  if not fail
	fail  = true if inv.nil?

	p4 = (p3*inv)%p if not fail
	inv = inverse(p-4,p) if not fail
	fail  = true if inv.nil?

	p5 = (p4*inv)%p if not fail

	if not fail
	return (p1+p2+p3+p4+p5)%p
	else
		return 0
	end
end
limit =$limit-1
generate_primes(limit)
t2=Time.now
puts "Primes generated in:  #{'%0.2f'%((t2-t1)*1000)} ms"
sum = 0
p=5
loop do
	if is_prime(p)
		value = find_factorial_mod_sum_wilson(p)
		sum+=value
		#puts "#{p}  #{value}  #{sum}"
	end
	p+=2
	break if p>limit
	#if p%1000==0
end
puts sum


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
