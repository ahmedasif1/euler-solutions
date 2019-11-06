#!ruby
require 'set'
t1 = Time.now
#d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
array = [1,10,100,1000,10000,100000,1000000]
LIMIT = 1000000
#string contains concatenated natural numbers
string  = ''
number =1
loop do
	string.concat(number.to_s)
	break if string.size>LIMIT
	number+=1
end
product =1
array.each do |index|
	#puts "#{index} #{string[index-1]}"
	product *= string[index-1].to_i
end
puts product

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"