#!ruby
#euler 121
t1=Time.now
def blue_probability try_no
	return [Rational(1)] if try_no==0
	n_array=blue_probability(try_no-1)
	arr=[]
	(try_no+1).times{arr.push 0}
	for i in 0..n_array.length-1
		#red
		arr[i]+=n_array[i]*Rational(try_no,try_no+1)
		#blue
		arr[i+1]+=n_array[i]*Rational(1,try_no+1)
	end
	arr
end

tries=15
i=(tries+2)/2
# take the terms where number of blue tiles is greater
sum = (blue_probability(tries)[i..tries]).inject(0) { |mem, var| mem+=var }
t2=Time.now

puts "Prize: #{(1/sum).to_i}"
puts 'Time elapsed: '+'%0.2f'%((t2-t1)*1000)