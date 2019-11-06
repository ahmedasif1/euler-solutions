#!ruby
require 'set'

t1=Time.now
MAX_ROWS=51

$max_sq =-1

$set_of_square_free_nums=Set.new
$pascal_triangle=[]
$prime_squares=[]

LIMIT = 11243248

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
			$prime_squares.push(multiple)
			while multiple <= limit
				$primes[multiple]=false
				multiple+=prime
			end
		end

		prime+=1
	end
end

def is_primes(number)
	$primes[number]
end



def square_free(num)
	sq_free = true
	$prime_squares.each do |psq|
		if num%psq == 0
			sq_free = false
			break
		end
	end
	sq_free
end





def generate_pascal_triangle
	for row in 1..MAX_ROWS-1
		$pascal_triangle[row]=[]
		$pascal_triangle[row][0]=1
		$pascal_triangle[row][row]=1
		if 1 <=row-1
			for col in 1..row-1
				$pascal_triangle[row][col]=$pascal_triangle[row-1][col-1] + $pascal_triangle[row-1][col]
				$max_sq = [$max_sq, Math.sqrt($pascal_triangle[row][col])].max
				if square_free($pascal_triangle[row][col])
					$set_of_square_free_nums.add($pascal_triangle[row][col])
				end
			end
		end
	end
end




$pascal_triangle[0]=[1]

generate_primes(LIMIT)
generate_pascal_triangle()

# for i in 0..MAX_ROWS-1
# 	puts $pascal_triangle[i].inspect
# end

#puts $prime_squares.inspect

puts $set_of_square_free_nums.inject(1){|m,v|m+=v}
#puts $set_of_square_free_nums.inspect
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"