#!ruby
t1=Time.now
LENGTH = 20
MAX_SUM=9
#for each length storing count of valid numbers ending in the digits AB
$cache={}

#build initial for first 2 digits
$cache[2]={}
for first in 1..9
	for second in 0..(MAX_SUM - first)
		$cache[2][first.to_s+second.to_s] = 1
	end
end


for location in 3..LENGTH
	$cache[location]={}	
	#puts "Location is #{location}"
	#iterate through all 2 digit combinations of previous digit
	$cache[location-1].each do |key,value|
		#puts "Key #{key}  Count: #{value}"
		two_digit_sum = key.split('').inject(0){ |m,v| m += v.to_i }
		#iterate through possible values of current digit considering the sum of previous 2 digits (two_digit_sum)
		for current_digit in 0..(MAX_SUM - two_digit_sum)

			new_key = key[1]+current_digit.to_s
			$cache[location][new_key] = ($cache[location][new_key].nil? ? 0 : $cache[location][new_key]) + value
		end

	end
end

puts $cache[LENGTH].values.inject(0){ |m,v| m += v.to_i }

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
