#!ruby
t1 = Time.now


count =0
for n in 1..100
	for r in 0..n/2
		nCr = (1..n).to_a.combination(r).size
		if nCr > 1000000
			#puts "#{n}  #{r}  #{nCr}"
			count+=1
			count+=1 if not 2*r==n
		end
	end
end

puts count

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"