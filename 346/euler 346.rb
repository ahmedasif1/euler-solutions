#!ruby
t1=Time.now
require 'radix'
require 'set'

$limit = 10**12
#using following max radix after analysis
max_basis = 1000000
set = Set.new

sum =1 
string="111"
should_end = false
#this loop increases length of "string"
for counter in 1..40

	#puts "Counter #{counter}    #{sum}"
	#puts string
	for i in 2..max_basis
		num = string.b(i).to_i
		if i==2 and num > $limit
			should_end = true
		end
		break if num > $limit
		if not set.include?num
			#puts "#{i} #{num}"
			sum+=num
			set.add num
		end
	end
	break if should_end
	string+='1'
end
puts "Sum of repunit numbers( in more than one basis below #{$limit})"
puts  "#{sum}"


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
