#!ruby
require 'set'
t1=Time.now
$palindromes=Set.new
$square=[]
max_starting_limit=7100 #as 7100**2 +7101**2 > limit
limit =100000000

$sums=[]

def check_palindrome num
	a=[]
	i=0
	while num!=0
		a[i]=num%10
		num/=10
		i+=1
	end
	for j in 0..(i-1)/2
		return false if a[j]!=a[i-1-j]
	end
	true
end


#fill cache of squares and initialize sums
for i in 0..max_starting_limit+10
	$square[i]=i**2
	$sums[i]=0
end
#multiple sums going on at the same time
#$sum[i] = sum started at i**2
count=0
while max_starting_limit!=1
	for i in 1..max_starting_limit
		$sums[i]+=$square[i+count]
		if $sums[i]>=limit
			max_starting_limit=i
			break
		end
		#check if palindrome
		if count>=1 and check_palindrome $sums[i]
			$palindromes.add $sums[i]
		end
	end
	count+=1
end

sum= $palindromes.to_a.inject(0){|sum,num|sum=sum+num}
t2=Time.now
puts "Sum of palindromes: #{sum}"
puts "Time taken: " +'%0.2f'%((t2-t1)*1000) +' ms'
