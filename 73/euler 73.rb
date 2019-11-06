#!ruby
maxD = 12000
count =0
lower_bound  = 1.0/3.0
upper_bound  = 1.0/2.0
for d in 2..maxD
	n = d/3-1;

	while true
		if n >=d
			break
		end	
		ans = n*1.0/d		
		if ans >lower_bound
			if ans <upper_bound
				if n.gcd(d) !=1
					n=n+1
					next
				end
				count=count+1
			else
				break
			end
		end
		n=n+1
	end
end
puts count
