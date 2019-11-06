#!ruby
t1=Time.now
$primes=[]
def remainder(a,i)
	a_2 = a**2
	if i%2==0
		return 2
	else
		return (2*i*a)%a_2
	end
end

$max_prime = 1000000
for i in 0..$max_prime
	$primes[i]=true
end
$primes[0]=false
$primes[1]=false

for i in 2..($max_prime/2)
	next if not $primes[i]
	ix = i+i
	while ix<=$max_prime
		$primes[ix]=false
		ix+=i
	end
end

i=2
num=3
rem=0
required = 10**10
while rem < required
	if not $primes[num]
		num+=2
		next
	end
	rem = remainder(num,i)
	i+=1
	num+=2
end

t2= Time.now
puts "n=#{i-1} , pn=#{num-2} , remainder=#{rem}"
puts 'Time elapsed : '+'%0.2f'%((t2-t1)*1000) + ' ms'


