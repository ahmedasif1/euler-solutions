#!ruby
t1 = Time.now
$lcm = 1

def divide_array_by(array,num)
	for i in 0..array.size-1
		array[i]/=num if array[i]%num==0
	end
	array
end

def calculate_lcm(array)
	array = array.sort
	for i in 0..(array.size-1)
		next if array[i]==1
		gcd = array[i]
		for j in 0..(array.size-1)
			next if array[j]==1
			current_gcd = array[j].gcd(gcd)
			if current_gcd!=1
				gcd = current_gcd
				i-=1
			end
		end
		array = divide_array_by(array,gcd)
		$lcm*=gcd
	end
	$lcm
end

array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
calculate_lcm(array)
puts $lcm
t2 = Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
