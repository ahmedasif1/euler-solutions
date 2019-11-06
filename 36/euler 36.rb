#!ruby
t1 = Time.now

LIMIT = 1000000
def is_palindrome (str)
	str=str.to_s
	str==str.reverse
end

sum = 0
for i in 1..LIMIT
	if(is_palindrome(i) and is_palindrome(i.to_s(2)))
		sum+=i
	end
end

puts sum
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"