#!ruby
t1=Time.now
perimeter_sum=0
#using square root convergents and pells equation
#(3a+-2)^2 -3(h)^2 =1
i=2
p=[]
q=[]
a=[1,2]#continued fraction of 3
p[0]=1
q[0]=1
p[1]=2
q[1]=1
cur_a=1
while i< 100
	p[i]=a[cur_a]*p[i-1]+p[i-2]
	q[i]=a[cur_a]*q[i-1]+q[i-2]
	if i%2==1
		#puts "#{p[i]}^2 - 3*#{q[i]}^2 = #{p[i]**2 -3*q[i]**2}"
		mod3 =p[i]%3
		base=0
		side=0
		if mod3 ==1
			base = 2* (p[i]+2)/3 # 3a-2 = p[i]
			side = base-1
		else
			base = 2* (p[i]-2)/3
			side =base+1
		end
		puts "#{side}, #{side}, #{base}"

		perimeter=base+side+side
		break if perimeter> 1000000000
		perimeter_sum+=perimeter
	end

	i+=1
	cur_a+=1
	cur_a=cur_a%2
end
t2=Time.now
puts "Sum =#{perimeter_sum}"
puts 'Time :' +'%0.2f'%((t2-t1)*1000) +' ms'