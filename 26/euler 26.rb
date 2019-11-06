#!ruby
t1 = Time.now
LIMIT=1000

def get_cycle_count(denominator)
	count=0
	remainders = [1]
	remainder = 1
	dividend = 
	loop do
#		puts "#{denominator} #{remainder}  #{remainders.inspect}"
		if remainder < denominator
			remainder*=10
			#remainders.push(remainder)
			next
		end

		remainder = remainder%denominator
		if not remainders.index(remainder).nil?
			count -=remainders.index(remainder)
			break
		else
			remainders.push remainder
		end
		break if remainder==0
		count+=1
	end
	count+1
end

max_count=0
max_den=nil
for denominator in 2..LIMIT-1
	count = get_cycle_count(denominator)
	#puts "#{denominator}   #{count}"
	if count>max_count
		max_count = count
		max_den = denominator
	end
end

puts "Cycle Length: #{max_count} Denominator: #{max_den}"
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"