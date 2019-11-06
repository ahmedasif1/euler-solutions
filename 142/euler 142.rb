#!ruby
# Euler 142
#Find sum of x,y,z when 
# x + y = a
# x - y = b
# x + z = c
# x - z = d
# y + z = e
# y - z = f
# are prefect squares
t1=Time.now

a=0,b=0,c=0,d=0,e=0,f=0
MAX_LIMIT = 1000

def is_square num
	return false if num<=0
	num*=1.0
	sqrt = Math::sqrt(num)
	num == sqrt.floor**2
end

def is_even num
	num%2==0
end
solution_found = false
for i in MAX_LIMIT.downto(4)
	a = i**2

	for j in 3..(i-1)
		c=j**2
		f = a - c
		next if not is_square(f)
		
		for k in 1..j-1
			d = k**2
			e = a - d
			b = c - e
			#puts "#{a}  #{b}  #{c}  #{d}  #{e}  #{f}"
			next if (is_even(d)!=is_even(c)) or not is_square(e) or not is_square(b)
			
			puts "#{a}  #{b}  #{c}  #{d}  #{e}  #{f}"
			solution_found = true
			break if solution_found
		end
		break if solution_found
	end
	break if solution_found
end

x = (a+b)/2
y = (e+f)/2
z = (c-d)/2

puts "Euler 142:"
puts "x = #{x}, y = #{y}, z=#{z}"
puts "Sum = #{x+y+z}"
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"