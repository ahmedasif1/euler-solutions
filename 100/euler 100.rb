#!ruby
t1 = Time.now
max_discs = 10**12
#https://www.alpertron.com.ar/QUAD.HTM
#solution to equation 2x^2 - 2x - 2y^2 + y = 0
#Xn+1 = P Xn + Q Yn + K
#Yn+1 = R Xn + S Yn + L
P = 3
Q = 2
K = -2
R = 4
S = 3
L = -3

x=15
y=21

loop do
	new_x = P*x + Q*y + K
	new_y = R*x + S*y + L
	x=new_x
	y=new_y
	break if y > max_discs
end

t2 = Time.now
puts "Euler 100: #{x}"
puts "Time elapsed: #{'%0.2f'%((t2-t1)*1000)} ms"