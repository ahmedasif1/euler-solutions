#!ruby
t1 = Time.now
sum=0
for number in 3..1000
	if number%2==0
		sum+=number*(number-2)
	else
		sum+=number*(number-1)
	end
end
t2 = Time.now

puts "Sum : #{sum}"
puts 'Time elapsed: '+'%0.2f'%((t2-t1)*1000)+' ms'

