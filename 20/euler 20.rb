#!ruby
t1 = Time.now

def fact(num)
	res = 1
	for i in 1..num
		res*=i
	end
	res
end

puts fact(100).to_s.split('').inject(0) { |mem, var| mem+=var.to_i }

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"