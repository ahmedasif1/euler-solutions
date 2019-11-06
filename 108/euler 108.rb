#!ruby
t1=Time.now
def distinct_solutions n
	count=0
	for x in n+1..2*n
		count+=1 if (x*n) % (x-n)==0
	end
	count
end

max=999999999
max_count=0

for i2 in 1..2
	for i3 in 1..2
		num=2**i2*3**i3*5*7*11*13
		ans=distinct_solutions num
		if ans >max_count and ans>1000 and num < max
			max=num
		end		
	end
end
t2=Time.now
puts max
puts 'Time :' +'%0.2f'%((t2-t1)*1000) +' ms'