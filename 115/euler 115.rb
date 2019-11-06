#!ruby
t1=Time.now
$mem=[] #for caching of results of recursive calculate
$minimum=50
def calculate i,n
	return 1 if i>=n
	
	return $mem[i] if not $mem[i].nil?

	count=0
	#red starting at i of varying lengths
	for j in $minimum..(n-i)
		count+=calculate(i+j+1,n)
	end
	count+=calculate(i+1,n)
	$mem[i]=count
	#black at i
end


n=50
while true
	$mem=[]
	count = calculate(0,n)	
	break if count >1000000
	n+=1
end
puts "#{n} ==> #{count}"
t2=Time.now
puts 'Time : '+'%0.2f'%((t2-t1)*1000)+'ms'