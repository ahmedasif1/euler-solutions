#!ruby
#Euler 15
t1=Time.now
def factorial(num)
	result = 1
	for i in 1..num
		result*=i
	end
	result
end

dimension = 20  #20x20
#possible moves up and right

fact_20 = factorial(20)

puts "Solution : #{factorial(40)/fact_20/fact_20}"

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'
