#!ruby
puts 'Euler 197 - Investigating the behaviour of a recursively defined sequence'
# The recursive sequence starts bouncing off 2 numbers after some time
# If an old number comes again, then add it and the next one and print the result
puts 

t1 = Time.now
array=[]
sum = 0
s=-1
for i in 1..1000
	
	s=(2**(30.403243784-s**2)).floor*10**-9
	
	if not array.index(s).nil?
		sum = s + (2**(30.403243784-s**2)).floor*10**-9
		break
	end
	array.push s
end

puts "Sum #{'%0.9f'%(sum)} "
t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
