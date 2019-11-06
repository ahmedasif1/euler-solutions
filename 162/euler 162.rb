#!ruby
t1=Time.now
#finding Hex numbers of length upto 16 having (0,1,A) atleast once

LENGTH=16
DIGITS = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']
REQUIRED_DIGITS =['0','1','A']

def sort_string string
	string.chars.uniq.sort.join
end

REQUIRED_KEY = sort_string("01A")
$cache={}

$cache[1]={}
for i in 1..DIGITS.length-1
	$cache[1][DIGITS[i]]={}

	if REQUIRED_DIGITS.include? DIGITS[i]
		$cache[1][DIGITS[i]][DIGITS[i]] = 1
	else
		$cache[1][DIGITS[i]]['']=1
	end
end


sum=0
for location in 2..LENGTH
	$cache[location]={}
	#puts "Location #{location}"
	DIGITS.each do |current_digit|
		#puts "Current digit #{current_digit}"
		$cache[location][current_digit]={}
		$cache[location-1].each do |last_digit,counters|
			#puts "Last digit #{last_digit}  Counters #{counters.inspect}"
			counters.each do|pat,count|
				key = nil
				if REQUIRED_DIGITS.include? current_digit
					key = sort_string(current_digit+pat)
				else
					key = pat
				end
				$cache[location][current_digit][key] = ($cache[location][current_digit][key].nil? ? 0 : $cache[location][current_digit][key]) + count
			end

		end
		if not $cache[location][current_digit][REQUIRED_KEY].nil?
			sum+=$cache[location][current_digit][REQUIRED_KEY]
		end
	end

end

#give answer also in HEX
puts sum.to_s(16).upcase

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"