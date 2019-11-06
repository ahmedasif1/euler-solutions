#!ruby
t1 = Time.now
LIMIT = 50000

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

generate_primes(LIMIT)

def count_primes(i,j)
	count=0
	n=0
	loop do 
		exp = n**2+i*n+j
		if $primes[exp]
			count+=1
		else
			break
		end
		n+=1
	end
	count
end

max_i=nil
max_j=nil
max_count=-1

for i in -999..999
	for j in -1000..1000
		count = count_primes(i,j)
		if count>max_count
			max_i=i
			max_j=j
			max_count =count
		end
	end
end

puts "a: #{max_i} b:#{max_j} a*b:#{max_i*max_j}"
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"