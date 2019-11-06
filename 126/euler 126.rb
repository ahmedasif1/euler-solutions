#!ruby
require 'set'
t1=Time.now

def count_cubes(n,a,b,c)
	2*(a*b+b*c+a*c)+4*(n-1)*(a+b+c+n-2)
end

$set = Set.new
$counts = {}
limit =20000

#loop runs in the format a<=b<=c
a=1
loop do
	break if count_cubes(1,a,a,a) > limit
	b=a
	loop do
		break if count_cubes(1,a,b,b) > limit
		c=b
		loop do
			break if count_cubes(1,a,b,c) > limit
			n=1
			loop do
				cubes = count_cubes(n,a,b,c)
				break if cubes > limit
				$counts[cubes]= 0 if $counts[cubes].nil?
				$counts[cubes]+=1
				n+=1
			end
			c+=1
		end
		b+=1
	end
	a+=1
end

$counts.keys.sort.each do |key|
	if $counts[key]==1000
		puts key
		break
	end
end

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'