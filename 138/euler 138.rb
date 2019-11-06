#!ruby
#equation
#(5b+-2)^2 -l^2 =-1
#sqrt(5)=2....
#continued fraction form [2;4,4,4..]
#solved using pell equation
t1=Time.now
a=4
p=[]
q=[]
p[0]=2 #a0
p[1]=2*a +1 
q[0]=1
q[1]=a


count=0
i=2
result=0
while count <12
	p[i]=a*p[i-1] + p[i-2]
	q[i]=a*q[i-1] + q[i-2]
	if (p[i]**2-5*q[i]**2) ==-1
		result+=q[i]
		count+=1
		b=0
		if (p[i]-2)%5==0
			b=2*(p[i]-2)/5
		else
			b=2*(p[i]+2)/5			
		end
		sq= Math.sqrt(q[i]**2 -(b/2)**2)
		puts "b=#{b}   L=#{q[i]}  h=#{sq.truncate}"
	end
	i+=1
end
t2=Time.now
puts "Sum of Isosceles hypotenuse : #{result}"
puts 'Time : '+'%0.2f'%((t2-t1)*1000) +'ms'

