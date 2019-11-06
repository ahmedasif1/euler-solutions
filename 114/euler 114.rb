#!ruby
t1=Time.now
$mem=[] #for caching of results of recursive calculate
$minimum=3
def calculate i,n
	if i>=n
		return 1
	end
	if not $mem[i].nil?
		return $mem[i]
	end
	count=0
	#red starting at i of varying lengths
	for j in $minimum..(n-i)
		count+=calculate(i+j+1,n)
	end
	count+=calculate(i+1,n)
	$mem[i]=count
	#black at i
end


n=7
$minimum=3
count=1 #no red tile

for n in $minimum..50
	$mem=[]
	puts"#{n} #{calculate(0,n)}"
end

=begin

array=[]
array[3]=2
array[4]=4
#puts "#{3} #{2}"
#puts "#{4} #{4}"
flag =true
for i in 5..50
	if i%3==0
		flag =!flag
		array[i]=array[i-1]+array[i-2]
	else
		array[i]=array[i-1]+array[i-2]
		if flag
			array[i]+=1
		else
			array[i]-=1
		end
	end

#puts "#{i} #{calculate(0,i)}"
#puts "#{i} #{array[i]}"
end

puts "#{50} #{array[50]}"
=end
t2=Time.now
puts 'Time : '+'%0.2f'%((t2-t1)*1000)+'ms'