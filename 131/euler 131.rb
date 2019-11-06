#!ruby
=begin
n^3 + n^2*p is a pefect cube
where n is an integer and p is prime
Find primes with this property below 1000000

n**3 + n**2 *p =x**3
n**3((n+p)/n)=x**3	=> (n+p) and n are also perfect cubes
(n-p)    (a)**3
----- = --------
 (n)     (b)**3

p=3(a**2) + 3(a) + 1

=end


$limit=1000000
$primes=[]
def generate_primes limit
	for i in 0..limit
		$primes[i]=true
	end
	$primes[0]=false
	$primes[1]=false
	prime=2
	while prime < $limit
		multiple=prime+prime
		while multiple <= $limit
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


generate_primes $limit
count=0
for i in 0..100
	number=3*i**2+3*i+1
	if number > $limit
		break
	end

	if $primes[number]
		count+=1
		puts number
	end
end
puts count

