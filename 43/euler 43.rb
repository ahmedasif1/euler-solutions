#!ruby
t1 = Time.now
$primes=[2,3,5,7,11,13,17]

def satisfies_condition(array)
	satisfies = true
	for i in 0..array.size-4
		number = array[i+1,3].join.to_i
		if number% $primes[i]!=0
			satisfies=false
			break
		end
	end
	satisfies
end


sum = 0

(0..9).to_a.permutation.each do|p|
	#puts p.inspect
	if(satisfies_condition(p))
		#puts "#{p.join.to_i} #{sum}"
		sum+=p.join.to_i
	end
end


puts sum

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"