#!ruby
t1=Time.now

$limit = 10**7
 55900232
100000000
$primes = (0..($limit+1)/2).to_a.inject([]){|mem,val|mem[val]=true;mem}
#puts $primes.size

def generate_primes
	$primes[0]=false
	$primes[1]=false
	for i in 2..(($primes).size+1)/2
		next if not $primes[i]
		number = i
		loop do
			#puts i
			number+=i
			break if  number >= $primes.size 
			$primes[number] = false
		end
	end
end

def find_max_prime_product(p,q,limit)
	max = -1
	smaller_power =1
	larger_power = Math.log(limit/p,q).to_i
	#puts "#{p} #{smaller_power} #{q} #{larger_power}"
	#larger_power = #limit/p
	return 0 if p*q>limit

	larger_power.downto(1) do |lp|
		ln = q**lp
		smaller_power = Math.log(limit/ln,p).to_i
		for sp in smaller_power..limit
			number = p**sp *ln
			break if number> limit
			max = [max,number].max
		end
	end
	max
end


generate_primes()
#puts $primes.inspect
#puts find_max_prime_product(2,5,100)
sums = 0
for i in 2..$primes.size-1
	next if !$primes[i]
	break if i**2>$limit
	for j in (i+1)..$primes.size-1
		next if !$primes[j]
		break if i*j>$limit
		num = find_max_prime_product(i,j,$limit)
		sums+=num
		#puts "#{i}  #{j}  #{num}  #{sums}"
	end
end
puts sums




t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
