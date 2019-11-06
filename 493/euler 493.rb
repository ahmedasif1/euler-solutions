#!ruby
t1= Time.now
$final_combinations=[]
precision='a.bcdefghij'

def factorial(num)
	res=1
	res=(1..num).to_a.inject(1){|m,v|m*=v}
end


def make_combinations(combinations,box_size,next_color,ball_types)
	#puts "Ball type #{next_color+1}"
	#puts combinations.inspect
	combinations[next_color]=[]
	combinations[next_color-1].each do | combination |
		for i in 0..combination[next_color-1]
			comb = combination.dup
			comb[next_color]=i
			sum = comb.inject(0) { |mem, var| mem+=var }
			if sum >box_size
				break
			elsif sum==box_size
				$final_combinations.push(comb)
			else
				combinations[next_color].push(comb)
			end
		end

	end
	#make recursive call
	if next_color+1!=ball_types
		make_combinations(combinations,box_size,next_color+1,ball_types)
	end
end

def count_n(array,n)
	array.inject(0){|m,v| v==n ? m+=1 : m }
end

def count_non_zero(array)
	array.inject(0){|m,v| v!=0 ? m+=1 : m }
end

def calculate_permutations(array)
	res = factorial(array.size)
	for i in 0..10
		res/=factorial(count_n(array,i))
	end
	res
end

def nCr(n,r)
	factorial(n)/factorial(r)/factorial(n-r)
end

def find_expected_ball_types
	ball_types=0
	total_ways=0
	#contains combinations making sum 20
	$final_combinations.each do| combination |

		p= calculate_permutations(combination) #number of distinct permutations
		c= count_non_zero(combination) # ball types in draw
		#puts "#{combination.inspect}   #{p}   #{c}"

		#ways to select combination[i] balls of type i
		for i in 0..6
			p*=nCr(10,combination[i])
		end
		total_ways+=p
		ball_types+=p*c
	end


	#puts "#{ball_types}  #{total_ways}"
	Rational(ball_types,total_ways)
end

combinations = []
combinations[0] = []

for i in 3..10
	combinations[0].push([i,0,0,0,0,0,0])
end

make_combinations(combinations,20,1,7)
ans = find_expected_ball_types().to_f
puts ans.to_f.to_s[0..precision.size-1]

t2 = Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'