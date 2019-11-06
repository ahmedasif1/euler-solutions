#!ruby
D=[]
maxD=1000
for i in 0..maxD
	D[i] =true
end

for i in 0..maxD
	sq=i*i
	break if sq >maxD
	D[i*i] =false
end

result =-1
maxX=-1
for i in 2..maxD
#i=2
	next if !D[i]
	sqroot = Math.sqrt(i).to_i
	a=sqroot
	d=1
	m=0
	num =a
	den=1

	num_minus_1=1;
	den_minus_1=0;

	while (num *num -i*den*den) !=1
		#puts "a= #{a} , m= #{m} , d= #{d}"
		m=d*a-m
		d=(i-m*m)/d
		a= (sqroot+m)/d
		

		den_minus_2 = den_minus_1
		num_minus_2 = num_minus_1;

		den_minus_1 = den
		num_minus_1 = num

		num = a*num_minus_1 +num_minus_2;
		den = a*den_minus_1+den_minus_2;

	end
	if num > maxX
		maxX =num
		result = i
		#puts num
	end
	#puts "#{i} #{num}"
end
puts result