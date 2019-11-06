#!ruby
t1 = Time.now
LIMIT = 4000000
sum=0

num1 =1
num2 =2
loop do
	sum += num2 if num2%2==0
	num1+=num2
	num1,num2 = num2,num1
	break if num2 >= LIMIT
end
puts sum
t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
