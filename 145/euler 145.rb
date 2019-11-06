#!ruby
t1=Time.now
LIMIT = 10**9

#digits_ahead contains an array containing [carry_received]


def recurse(n,carry,count,length,digits_ahead)
	#puts "#{n} #{count} #{carry} #{digits_ahead.inspect}"
	current_count = 0
	if n==0
		if carry
			return 0
		else
			current_count =count
		end
	end

	if n < length/2 and n > 0
		#puts "#{n} #{carry} #{digits_ahead[length-n-1]}"
		if carry
			if digits_ahead[length-n-1]
				#puts "#{n} #{carry} #{count} #{digits_ahead.inspect}" if n==2
				da =digits_ahead.dup
				da[n] = n==length-n-2 ? carry : digits_ahead[length-n-2]
				current_count = recurse(n-1,da[n],count,length,da)
			else
				return 0
			end
		else
			if digits_ahead[length-n-1]
				return 0
			else
				#puts "#{n} #{carry} #{count} #{digits_ahead.inspect}" if n==2
				da =digits_ahead.dup
				da[n] = n==length-n-2 ? carry : digits_ahead[length-n-2]
				current_count = recurse(n-1,da[n],count,length,da)
			end
		end
	elsif n==(length-1.0)/2 #mid point needs to have a carry from right
		#puts "here"
		if carry
			da = digits_ahead.dup
			da[n] = carry
			current_count+=recurse(n-1,true,count*5,length,da)
			current_count+=recurse(n-1,false,count*5,length,da)
		else
			return 0
		end
	elsif n >= length/2.0
		if carry
			da = digits_ahead.dup
			da[n] = carry
			current_count+=recurse(n-1,true,count* 25 ,length,da)
			current_count+=recurse(n-1,false,count*25,length,da)
		else
			da = digits_ahead.dup
			da[n] = carry
			current_count+=recurse(n-1,true,count*20,length,da)
			current_count+=recurse(n-1,false,count*30,length,da)
		end
	end
	#puts "#{n} #{carry} #{current_count}  #{digits_ahead.inspect}"
	current_count
end

sum =0 
for i in 1..9
	count = recurse(i-2,false,20,i,Array.new(i,false))
	#puts "#{i} #{count}"
	count+=recurse(i-2,true,20,i,Array.new(i,false))
	#puts "#{i} #{count}"
	sum+=count
	#puts "#{i} #{recurse(i-2,true,20,i,Array.new(i,false))}"
end
puts sum

t2=Time.now
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'
