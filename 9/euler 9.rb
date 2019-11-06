#!ruby
t1 = Time.now
SUM = 1000
$squares ={}
def generate_squares(limit)
	num = 1
	loop do
		sq =num**2
		$squares[sq] = num
		num+=1
		break if sq > limit
	end
end
generate_squares(SUM**2)

squares_array = $squares.keys
for a2 in 0..squares_array.size-1
	#break if $squares[squares_array[a2]]>=SUM/3
	for b2 in a2..squares_array.size-1
		#($squares[squares_array[a2]]+$squares[squares_array[b2]])>=SUM
		c2 = squares_array[a2]+squares_array[b2]
		#is a perfect square
		if not $squares[c2].nil? and $squares[squares_array[a2]]+$squares[squares_array[b2]]+$squares[c2] ==1000
			puts $squares[squares_array[a2]]*$squares[squares_array[b2]]*$squares[c2]

		end
	end
end



t2 = Time.now
puts "Time Elapsed #{'%0.2f'%((t2-t1)*1000)} ms"
