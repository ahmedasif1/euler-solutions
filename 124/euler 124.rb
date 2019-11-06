#!ruby
require "set"
t1=Time.now
max_number = 100000
$primes=[]
$set_of_prime_factors=[]

(max_number+1).times  {$primes.push true}

#generate_primes
$primes[0]=false
$primes[1]=false
for i in 2..(max_number+1)/2
	next if not $primes[i]
	j=i+i
	while j <= max_number
		$primes[j]=false
		j+=i
	end
end


def find_prime_factors _num
	num=_num
	set=SortedSet.new
	current_factor=2
	while true
		if num==1
			$set_of_prime_factors[_num]=set
			return set
		end
		if not $set_of_prime_factors[num].nil?
			return set+$set_of_prime_factors[num]			
		elsif $primes[num] 
			set.add num
			$set_of_prime_factors[num]=set
			return set
		else
			while num%current_factor!=0 or not $primes[current_factor]
				current_factor+=1 if current_factor!=2
				current_factor+=1
			end
			while num%current_factor==0
				num=num/current_factor
				set.add current_factor
			end
		end
	end
end

$radicals={}
$radicals[1]=1
for i in 2..max_number
	$radicals[i]=(find_prime_factors(i).to_a).inject(1) { |mem, var| mem*=var }
end
$radicals=Hash[$radicals.sort_by{|k,v|v}]

t2=Time.now
puts $radicals.to_a[9999][0]

puts 'Time: '+'%0.2f'%((t2-t1)*1000)+ ' ms'