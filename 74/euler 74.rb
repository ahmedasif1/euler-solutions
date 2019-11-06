#!ruby
$fact=[]
$chain_lengths=[]

def factorial(num)
	if num <=9
		return $fact[num]
	end

	num.to_s.split(//).inject('0') { |sum, var| sum.to_i+$fact[var.to_i] }

end

$fact[0]=1
$fact[1]=1
for i in 2..9
	$fact[i] = $fact[i-1]*i
end


$chain_lengths[871]=2
$chain_lengths[872]=2
$chain_lengths[145]=1
$chain_lengths[45361]=2
$chain_lengths[45362]=2
$chain_lengths[169]=3
$chain_lengths[1454]=3
$chain_lengths[36301]=3
$chain_lengths[1]=1
$chain_lengths[2]=1
def recurse(num)

	result=0
	temp = factorial(num)
	if temp==num
		$chain_lengths[num]=1
		return 1
	end
	if $chain_lengths[temp].nil?
		result = recurse(temp)+1
		$chain_lengths[num] =result
	else
		result = $chain_lengths[temp]+1
		$chain_lengths[num]=result
	end
	result
end

result =0
for i in 0..1000000
	#print "#{i}"
	temp=i
	if $chain_lengths[i].nil?
		list=[]
		count=0
		list.push 0
		while list.last !=temp
			list.push temp
			temp = factorial(temp)
			count+=1
			if temp < 1000000 and not $chain_lengths[temp].nil?
				count+=$chain_lengths[temp]
				break
			end
		end

		if count==60
			result+=1
		end

		for j in 1..list.length-1
			$chain_lengths[list[j]]=count
			count-=1
		end

		#recurse(i)
		
	end
	#puts "#{$chain_lengths[i]}"
	if $chain_lengths[i]==60
		count+=1
	end
end

puts result




