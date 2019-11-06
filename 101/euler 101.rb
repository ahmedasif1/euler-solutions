#!ruby
t1=Time.now
$series=[]

$terms=100

=begin
for n^3

	1 ==> 1


	1,8==>15
	7==>7

	1,8,27==>58
	7,19==>31
	12==>12

	1,8,27,64==>125
	7,19,37==>61
	12,18==>24
	6==>6

uses dynamic programming to calculate differences


=end



#produce some terms of the pattern
for n in 1..$terms
	$series.push 1-n+n**2-n**3+n**4-n**5+n**6-n**7+n**8-n**9+n**10
end

$differences=[]
$differences[0]=[]
$sum=0

for available_terms in 1..50
	$differences[0].push $series[available_terms-1]
	for i in 1..available_terms-1
		#puts $differences.inspect
		#puts "#{i-1} #{available_terms-i}"
		diff=$differences[i-1].last - $differences[i-1][$differences[i-1].length-2]
		#puts diff
		break if diff==0
		$differences[i]=[] if $differences[i].nil?
		$differences[i].push diff
	end
	#puts $differences.inspect

	#find the next term
	diff=$differences.last.last
	diff=0 if available_terms==1
	#print "#{diff}  "
	next_term=$differences.first.last
	for i in ($differences.length-2).downto(1)
		diff+=$differences[i].last
	#	print "#{diff}   "
	end
	next_term+=diff
	#puts next_term+diff
	#puts
	#puts "#{next_term}    #{$series[available_terms]}"

	#check if equal to actual value
	if next_term==$series[available_terms]
		#puts 'got it'
		break
	else
		$sum+=next_term
	end

end
t2=Time.now
puts "Sum of FITs: #{$sum}"
puts 'Time taken: '+'%0.2f'%((t2-t1)*1000)+ 'ms'