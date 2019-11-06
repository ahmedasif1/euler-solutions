#!ruby
# Euler 206
#Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
#where each “_” is a single digit.
#################################################################################
#by analysis the last _ must be 0
t1=Time.now
minimum_value = 1929394959697989900
$format = "1_2_3_4_5_6_7_8_9_0".split('')
puts "Euler 206"

def matches_format(number)
	unmatch_at = 0
	str = number.to_s.split('')
	index = 0
	loop do
		if str[index]!=$format[index]
			unmatch_at = index
			break
		end
		index+=2
		break if index>=str.size || index>=str.size

	end
	unmatch_at
end

sqroot =Math.sqrt(minimum_value).to_i/100*100 +70


flag = true

loop do
	square = sqroot**2

	if matches_format(square) == 0
		puts "Number: #{sqroot}  Square value: #{square}"
		break
	end
	if flag
		sqroot-=40
	else
		sqroot-=60
	end
	flag=!flag
end


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"