#!ruby
require 'set'
$squares=[]
$cubes=[]
$fourth=[]
$primes=[]

$limit =50000000
$result =SortedSet.new

#max of square will be less than log2(limit)
#max of cube will be less than log3(limit)
#max of fourth will be less than log4(limit)

$square_limit= ($limit**0.5).ceil
$cube_limit= ($limit**(1.0/3)).ceil
$fourth_limit = ($limit**0.25).ceil


def make_primes
	for i in 0..$square_limit
		$primes.push true
	end
	$primes[0]=false
	$primes[1]=false

	for i in 2..$square_limit
		if $primes[i]
			j=i*2
			while j < $square_limit
				$primes[j]=false
				j+=i
			end 
		end
	end
end
#generate primes
make_primes

#generate squares cubes and fourths
for i in 0..$square_limit
	if $primes[i]
		$squares.push i*i
	end
end
for i in 0..$cube_limit
	if $primes[i]
		$cubes.push i*i*i
	end
end
for i in 0..$fourth_limit
	temp = $squares[i]*$squares[i]
	break if temp >=$limit
	$fourth.push temp
end



$squares.each do |sq|
	break if sq >$limit
	$cubes.each do |cb|
		sum1 = sq+cb
		break if sum1>$limit
		$fourth.each do |fo|
			sum2=sum1+fo
			break if sum2 >$limit
			$result.add sum2
		end
	end

end


puts $result.size







