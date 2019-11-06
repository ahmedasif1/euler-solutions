#!ruby
t1=Time.now
def points_on_same_side_of_line x1,y1,x2,y2,x3,y3,px,py
	#a/b =slope
	#(y-y1) = m(x-x1)
	a = (y1-y2)
	b = (x1-x2)
	r1 =((y3 - y1)*b - a *( x3-x1) )
	r2= ((py - y1)*b - a *( px-x1) )
	r1*r2 >0
end

def points_contain_origin p	
	#line between point 1 and point 2
	flag=points_on_same_side_of_line(p[0],p[1],p[2],p[3],p[4],p[5],0,0)
	
	#line between point 1 and point 3
	flag=(flag and points_on_same_side_of_line(p[0],p[1],p[4],p[5],p[2],p[3],0,0)) if flag
	
	#line between point 2 and point 3
	flag=(flag and points_on_same_side_of_line(p[2],p[3],p[4],p[5],p[0],p[1],0,0))	if flag
	flag
end

count =0
File.open('p102_triangles.txt') do |f|
	f.each do |l|
		p=l.chomp.split ','
		count+=1 if points_contain_origin(p.map{|v|v.to_i})
	#	break
	end
end
t2=Time.now
puts"Count: #{count}"
puts 'Time elapsed: ' + '%0.2f'%((t2-t1)*1000) +' ms'
