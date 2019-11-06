#!ruby
require 'set'
t1 = Time.now

def is_prime(number)
	prime = true
	sqrt = Math.sqrt(number).to_i
	for i in 2..sqrt
		if number% i==0
			prime = false
			break
		end
	end
	prime
end

found = false
max = 0
9.downto(1).each do|max_digit|
	(1..max_digit).to_a.permutation.each do|p|
		next if p.last%2==0 or p.inject(0) { |mem, var| mem+=var }%3==0
		#puts p.inspect
		if(is_prime(p.join('').to_i))
			found = true
			max = [max,p.join('').to_i].max
		end
	end
	break if found
end
puts max

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"