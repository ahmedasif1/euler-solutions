#!ruby
t1 = Time.now


max_sum =0
for a in 1..99
	for b in 1..99
		sum=(a**b).to_s.split('').inject(0){|m,v|m+=v.to_i}
		if sum > max_sum
			max_sum = sum
		end
	end
end
puts max_sum
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"