#!ruby
# Euler 205
#Peter has 9 four sided die (1,2,3,4)
#Colin has 6 six sided die (1,2,3,4,5,6)
#Both throw
#Find probability of Peter wins in 7 decimal places

$scores ={}
PETER = "Peter"
COLIN = "Colin"
$DIE ={}

def factorial(n)
	(1..n).inject(1,:*)
end

def find_permutations array
	number_count = array.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }

	# http://stackoverflow.com/questions/9560335/ruby-hash-to-array-of-values
	repeated_factorial = number_count.values.inject(1) {|result, element| result*factorial(element)}

	factorial(array.length)/repeated_factorial
end

def throw_die(number_of_dies_remaining,person,throws,last_throw)
	if number_of_dies_remaining == 0
		sum = throws.inject(0){|mem,val|mem+=val}
		#puts "Throws: #{throws.inspect}  Permutations #{find_permutations(throws)}"
		$scores[person][sum]=0 if $scores[person][sum].nil?
		$scores[person][sum]+=find_permutations(throws)
	else
		for face in last_throw..$DIE[person].last
			new_throws = Array.new(throws)
			new_throws.push(face)
			throw_die(number_of_dies_remaining-1,person,new_throws,face)
		end
	end
end
t1=Time.now

$scores[PETER] = {}
$scores[COLIN] = {}
$DIE[PETER] = [1,2,3,4]
$DIE[COLIN] = [1,2,3,4,5,6]
total_combinations={}
throw_die(9,PETER,[],1)
throw_die(6,COLIN,[],1)
#puts "Peter: #{$scores[PETER].inspect}"

#puts "Score: #{$scores[COLIN].inspect}"
total_combinations[PETER] = 4**9
total_combinations[COLIN] = 6**6

peter_beat_count = 0
$scores[PETER].keys.each do |peter_score|
	$scores[COLIN].keys.each do |colin_score|
		break if colin_score >= peter_score
		#puts "Peter score #{peter_score}    Colin score #{colin_score}"
		peter_beat_count+=$scores[PETER][peter_score] * $scores[COLIN][colin_score]
	end
end

puts "Euler 205"
puts "Probability = #{'%0.7f'%(peter_beat_count/(total_combinations[PETER]*1.0*total_combinations[COLIN]))}"
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"