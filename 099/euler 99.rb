#!ruby
t1 = Time.now
base=1
exponent=1
line_number=1
current_line=1
File.open('p099_base_exp.txt') do |f|
	f.each_line do |line|
		nums = line.split(/,/)
		if exponent*Math.log(base) < nums[1].to_i*Math.log(nums[0].to_i)
			exponent = nums[1].to_i
			base = nums[0].to_i
			line_number = current_line
		end
		current_line+=1
	end
end
t2 =Time.now
puts line_number.to_s
print "Time elapsed: "
puts "%0.2f"%((t2-t1)*1000)