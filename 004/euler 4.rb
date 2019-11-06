#!ruby
t1 = Time.now
def is_palindrome(number)
	string = number.to_s
	string.reverse == string
end

largest_palindrome =-1

for number1 in 100..999
	for number2 in number1..999
		product = number1*number2
		if is_palindrome(product) and largest_palindrome < product
			largest_palindrome = product
		end
	end
end

puts largest_palindrome
t2 = Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
