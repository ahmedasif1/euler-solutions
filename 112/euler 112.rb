#!ruby
t1=Time.now
def is_bouncy num
	greater=false
	less=false
	
	last=num%10
	num/=10

	while num>0
		t=num%10
		greater=true if t<last
		less=true if t>last
		break if less ==true and greater==true
		num/=10
		last=t
	end
	less and greater
end

numbers=99
bouncy=0
n=1
prop=0
for i in 100..1990000
	numbers+=1
	if is_bouncy i
		bouncy+=1
		#puts "#{i} #{bouncy} #{numbers}  #{bouncy*1.0/numbers*100}"
		n=i
		prop=bouncy*1.0/numbers*100
		break if  prop>= 99

	end
end
t2=Time.now
puts n
puts prop
puts "Time: " +'%0.2f'%((t2-t1)*1000) +'ms'