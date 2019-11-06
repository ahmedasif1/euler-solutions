#!ruby
#Euler 408
require 'set'
t1=Time.now
LIMIT =   10000000
MODULUS = 1000000007

$squares = nil
$in_admissible_points=[]
$factorial_cache={}
$inv_cache={}
$max_fact=0

class Point
	attr_accessor :x
	attr_accessor :y
	attr_accessor :mirror
	attr_accessor :admissible_paths_till_this
	def initialize(x,y)
		@x=x
		@y=y
		@mirror =nil
		@admissible_paths_till_this=nil
	end

end

$origin = Point.new(0,0)

def extended_Gcd(a,n)
	t=1
	r=a
	old_t=0
	old_r=n

	loop do 
		break if r==0
		q=old_r/r
		old_r,r = r, (old_r-q*r)
		old_t,t = t, (old_t-q*t)
	end
	if old_r > 1
		return nil
	end
	return old_t%n
end

def multiplicative_inverse(a)
	extended_Gcd(a,MODULUS)
end

def multiplyMod(num1,num2)
	(num1*num2)%MODULUS
end

def addMod(num1, num2)
	(num1+num2)%MODULUS
end

def minusMod(num1, num2)
	(num1-num2)%MODULUS
end


def build_factorial_cache(limit)
	$factorial_cache[0]=1
	for i in ($max_fact+1)..limit
		$factorial_cache[i] = multiplyMod($factorial_cache[i-1],i)
#		$inv_cache[i]=multiplicative_inverse(i)
	end
	$max_fact = limit
end

def generate_squares(limit)
	$squares = SortedSet.new
	num = 1
	loop do
		sq =num**2
		$squares.add(sq)
		num+=1
		break if sq > limit
	end
end

def factMod(num)
	result =0
	if $factorial_cache[num].nil?
		build_factorial_cache(num)
	end
	result = $factorial_cache[num]
end


#gives answer disregarding anything else
def find_all_paths_from_source_to_destination(source,destination)
	dx = destination.x-source.x
	dy = destination.y-source.y
	den = multiplyMod(factMod(dx), factMod(dy))
	num = factMod(dx+dy)
	inv = $inv_cache[den]
	if inv.nil?
		inv = multiplicative_inverse(den)	
		$inv_cache[den]=inv
	end
	multiplyMod(num,inv)
end

def find_all_admissible_paths_though_this_point(point,destination)
	count = 0
	pointX = point
	if not point.mirror.nil?
		pointX = point.mirror
	end
	if pointX.admissible_paths_till_this.nil?
		count = find_admissible_paths_till_destination(pointX)
	else
		count = pointX.admissible_paths_till_this
	end

	between = find_all_paths_from_source_to_destination(point,destination)
	multiplyMod(between,count)
end

def find_admissible_paths_till_destination(destination)
	result =nil
	if not destination.admissible_paths_till_this.nil?
		result = destination.admissible_paths_till_this
	elsif !destination.mirror.nil?
		result = find_admissible_paths_till_destination(destination.mirror)
	else
		total_paths_till_destination = find_all_paths_from_source_to_destination($origin,destination)
		in_admissible_paths = 0
		$in_admissible_points.each do |in_admissible|
			if (destination==in_admissible) or (destination.x < in_admissible.x) or (destination.y < in_admissible.y)
				#puts "#{destination.inspect} #{in_admissible.inspect}"
				#next
				if destination.x < in_admissible.x
					break
				else
					next
				end
			end
			in_admissible_paths+=find_all_admissible_paths_though_this_point(in_admissible,destination)
		end

		result = minusMod(total_paths_till_destination,in_admissible_paths)
		destination.admissible_paths_till_this = result
	end

	#puts "#{destination.x}  #{destination.y}  #{result}"
	result
end


limit = LIMIT
#generate squares for looking up perfect squares
generate_squares(2*limit)
t2=Time.now
puts "Squares built in #{'%0.2f'%((t2-t1)*1000)} ms"
build_factorial_cache(2*limit+1)
t2=Time.now
puts "factorial_cache built in #{'%0.2f'%((t2-t1)*1000)} ms"
sq_array=$squares.to_a.sort
for i in 0..sq_array.size-1
	break if sq_array[i] > limit
	for j in i..sq_array.size-1
		break if sq_array[j] > limit
		sum = sq_array[i]+sq_array[j] 
		if $squares.include?(sum)
			point = Point.new(sq_array[i],sq_array[j])
			mirror_point = Point.new(sq_array[j],sq_array[i])
			point.mirror = mirror_point
			$in_admissible_points.push (point)
			$in_admissible_points.push (mirror_point)
		end
	end	
end

#puts $in_admissible_points.inspect

$in_admissible_points.sort!{|i,j|i.x<=>j.x}
t2=Time.now
puts "Cache built in #{'%0.2f'%((t2-t1)*1000)} ms"
puts "Number of in-admissible points: #{$in_admissible_points.size}"
puts 


destination = Point.new(limit,limit)


puts find_admissible_paths_till_destination(destination)



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
