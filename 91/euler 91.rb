#!ruby
t1=Time.now
$squares ={}

for i in 0..100
	$squares[i*i]=i
end

count=0
limit =50

for x1 in 0..limit
	for y1 in 0..limit	
		next if x1==0 and y1==0
		
		for x2 in 0..limit
			b_square_4ac = (y1**2) - 4*(x2**2 -x1*x2)
			if not $squares[b_square_4ac].nil?
				sqr = $squares[b_square_4ac]
				y21 = (y1+ sqr)/2.0
				y22= (y1- sqr)/2.0
				
				if y21==y21.truncate  and  y21 >=0 and y21<=limit and not (x1==x2 and y21.truncate==y1) and not (x2==0 and y21.truncate==0)
					#puts "#{x1},#{y1}  #{x2},#{y21.truncate}  #{}"
					count+=1
				end
				if y22==y22.truncate and  y22 >=0 and y22<=limit and y21!=y22  and not (x1==x2 and y22.truncate==y1) and not (x2==0 and y22.truncate==0)
					#puts "#{x1},#{y1}  #{x2},#{y22.truncate}  #{}"
					count+=1
				end
			end
		end
	end
end
count+=limit*limit
t2=Time.now
puts "Right-angle triangles: #{count}"
puts 'Time elapsed: ' +'%0.2f'%((t2-t1)*100) +' ms'