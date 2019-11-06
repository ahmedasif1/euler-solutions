#!ruby
require 'set'
t1 = Time.now

set = Set.new

product =0
for a in 2..100
	product = a
	for b in 2..100
		product*=a
		set.add(product)
	end
end
puts set.size

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"