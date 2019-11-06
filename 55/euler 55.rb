#!ruby
t1=Time.now
def is_lycheral num
	count=0
	while true
		return true if count==50
		num+=num.to_s.reverse.to_i
		count+=1
		break if num.to_s == num.to_s.reverse
	end
	false
end

count=0
for i in 1..10000-1
	if is_lycheral i
		count+=1

	end
end
t2=Time.now
puts count
puts 'Time: ' +'%0.2f'%((t2-t1)*1000)+'ms'