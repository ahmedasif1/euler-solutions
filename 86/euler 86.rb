#!ruby
=begin
treat the cube of sides a,b,c where a<=b<=c
as a rectangle with sides as
a,(b+c) , the diagonal will be the straight line
get a*a + (b+c)*(b+c) and check if it is a perfect square
=end


=begin
returns the possible number of unique combinations of x+y=d
where x,y <=a
=end
def combinations(d,a)
	if d > (a+1)
		d=2*(a+1)-d
	end
	d/2
end


def is_perfect_square(sq)
	if Math.sqrt(sq).truncate**2==sq 
		return true
	else
		return false
	end
end


t1 =Time.now
limit = 1000000
a=1
a_square = 1
count=0
while true
	d_square=4
	for d in 2..(2*a)
		if is_perfect_square(a_square+d_square)
			count+=combinations(d,a)
		end
		if(count>=limit)
			break
		end
		d_square=d_square+d+d+1
	end
	if(count>=limit)
		break
	end
	a_square=a_square+a+a+1
	a+=1
end
t2 =Time.now
puts "#{a} ==> #{count}"
puts "Time elapsed :"+"%0.3f" %((t2-t1)*1000)