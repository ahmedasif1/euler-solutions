#!ruby
t1 = Time.now
sum=0

for i in 1..(1000-1)
	sum +=i if i%3==0 or i%5==0
end
puts sum
t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
