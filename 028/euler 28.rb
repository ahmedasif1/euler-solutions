#!ruby
#x+(x-y)+(x-2y)+(x-3y) in each square
t1=Time.now

start=3
sum=1
while start <=1001
	square=start**2
	sum+=square*4-(start-1)*6
	start+=2
end
t2=Time.now
puts sum
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'
