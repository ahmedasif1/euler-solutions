#!ruby
t1 = Time.now
DIGITS = 1000

num1 =1
num2 =2
index = 2
loop do
	index+=1
	num1+=num2
	num1,num2 = num2,num1
	if num2.to_s.size >=DIGITS
		puts index
		break
	end
end



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"