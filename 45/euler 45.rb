#!ruby
t1 = Time.now
# Triangle 	  	    T(n)=n(n+1)/2 	  	1, 3, 6, 10, 15, ...
# Pentagonal 	  	P(n)=n(3n−1)/2 	  	1, 5, 12, 22, 35, ...
# Hexagonal 	  	H(n)=n(2n−1)  	  	1, 6, 15, 28, 45, ...
# It can be verified that T(285) = P(165) = H(143) = 40755.
# Find the next triangle number that is also pentagonal and hexagonal.

#traverse hexagonal sequence and calculate n for pentagonal and triangular (if both int then found)
def triangular_n(number)
	number = number*2
	sq = Math.sqrt(number).to_i
	if sq*(sq+1)==number
		return sq
	end
	return nil
end

def pentagonal_n(number)
	square = number*24+1
	root = Math.sqrt(square)
	#puts root
	if root==root.to_i and (root+1)%6==0#integral root
		return (root+1)/6
	end
	return  nil
end
n=2
count =0
loop do
	hexagonal = n*(2*n-1)
	nt = triangular_n(hexagonal)
	if not nt.nil?
		np = pentagonal_n(hexagonal)
		if not np.nil?
			count+=1
			if count==2
				puts "Tri(#{nt}) Pen (#{np}) Hex (#{n})      Solution: #{hexagonal}"
				break
			end
		end
	end
n+=1
end



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"