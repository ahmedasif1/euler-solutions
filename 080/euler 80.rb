#!ruby
t1 =Time.now
result =0

for i in 1..99
	counted=0
	sqrt = Math.sqrt(i)
	next if sqrt==sqrt.truncate

	chunks = i.to_s.reverse.scan(/.{1,2}/).reverse.map{|i|i.reverse}
	
	top =0
	count=0
	current =0
	chunks.each do |c|
		if top==0
			top += Math.sqrt(Integer(c)).to_i
			current = Integer(c) - top*top
			count+=top
#			print top
			counted+=1
		else
			current = current *100 +Integer(c)
			double_top=top*2;
			z=current/double_top
			while (double_top*10**z.to_s.length+z) *z > current
				z-=1
			end
#			print z
			current =current -(double_top*10**z.to_s.length+z) *z
			top =top*10**z.to_s.length+z
		#	count+=z
		#	counted+=1
		end


	end

	if current!=0
	while true
		
		current = current *100
		
		double_top =top*2;
#		print "#{current }    #{top}    "
		z=current/double_top
		while (double_top*10**z.to_s.length+z) *z >= current
			z-=1
		end
		current =current -(double_top*10**z.to_s.length+z) *z
		top=top*10**z.to_s.length+z
		if counted ==100
			break
		end
		count+=z
		counted+=1
		
		#print z
	end
end

#puts count
result +=count
#puts "#{i}   #{count}"
end

puts result


t2 =Time.now
print "Time elapsed : "
puts "%0.2f" %((t2-t1)*1000)