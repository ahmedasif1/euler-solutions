#!ruby

p=[]
p[0]=1
p[1]=1

def g(k)	
	(k*(3*k-1))/2
end
coins =2
while true
	possibilities=0
	k=1
	while true
		gk =g(k)		
		break if gk > coins
		possibilities += (-1)**(k-1) * p[coins -gk]
		gk =g(-k)	
		break if gk > coins
		possibilities += (-1)**(k-1) * p[coins -gk]
		k+=1
		possibilities =possibilities%1000000
	end

	p[coins]=possibilities
	break if possibilities%1000000==0
	coins+=1
end

puts coins