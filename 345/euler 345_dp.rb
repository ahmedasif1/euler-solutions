#!ruby
t1=Time.now
require 'set'
$solutions=[]
MAX_SOL_FOR_POINT = 75
class Solution
	attr_accessor :sum
	attr_accessor :set
	def initialize
		@sum=0
	end
end

$matrix=
[
[  7, 53,183,439,863,497,383,563, 79,973,287, 63,343,169,583],
[627,343,773,959,943,767,473,103,699,303,957,703,583,639,913],
[447,283,463, 29, 23,487,463,993,119,883,327,493,423,159,743],
[217,623,  3,399,853,407,103,983, 89,463,290,516,212,462,350],
[960,376,682,962,300,780,486,502,912,800,250,346,172,812,350],
[870,456,192,162,593,473,915, 45,989,873,823,965,425,329,803],
[973,965,905,919,133,673,665,235,509,613,673,815,165,992,326],
[322,148,972,962,286,255,941,541,265,323,925,281,601, 95,973],
[445,721, 11,525,473, 65,511,164,138,672, 18,428,154,448,848],
[414,456,310,312,798,104,566,520,302,248,694,976,430,392,198],
[184,829,373,181,631,101,969,613,840,740,778,458,284,760,390],
[821,461,843,513, 17,901,711,993,293,157,274, 94,192,156,574],
[ 34,124,  4,878,450,476,712,914,838,669,875,299,823,329,699],
[815,559,813,459,522,788,168,586,966,232,308,833,251,631,107],
[813,883,451,509,615, 77,281,613,459,205,380,274,302, 35,805]]


# [  7, 53,183,439,863],
# [497,383,563, 79,973],
# [287, 63,343,169,583],
# [627,343,773,959,943],
# [767,473,103,699,303]]






$max_sum=0
$max_col=0
def initialize_solutions
	$solutions[0]=[]
	for i in 0..$matrix.size-1

		$solutions[0][i] = []
		solution = Solution.new
		solution.sum = $matrix[0][i]
		solution.set = Set.new
		solution.set.add(i)
		$solutions[0][i].push(solution)
	end
end

initialize_solutions()

def add_solution_array(row,col,prev_solution)
	#calculate sum
	sum = $matrix[row][col] + prev_solution.sum
	if $max_sum < sum
		$max_sum = sum
		$max_col = col
	end
	solution = Solution.new 
	solution.sum = sum
	solution.set = prev_solution.set.dup
	solution.set.add(col)
	$solutions[row][col].push(solution)
	$solutions[row][col].sort!{ |x,y| y.sum<=>x.sum }
	$solutions[row][col] = $solutions[row][col][0..MAX_SOL_FOR_POINT]
end

for row in 1..$matrix.size-1 #for each row
	$solutions[row]=[]
	#threads=[]
	
	for col in 0..$matrix.size-1 #for each column
		col_current = col
	#	threads<<Thread.new(col){|col_current|
		$solutions[row][col_current]=[]
	
		for cols_previous in 0..$matrix.size-1 #for each column of previous row
	
			next if cols_previous == col_current #skip if same column
	#		puts "#{row} #{col} #{cols_previous}"
			for prev_solution in 0..$solutions[row-1][cols_previous].size-1 #for each solution of selected column of previous row
				#puts $solutions[row-1][cols_previous][prev_solution].inspect
				next if $solutions[row-1][cols_previous][prev_solution].set.include?(col_current) #skip if col is already present in set
				add_solution_array(row,col_current,$solutions[row-1][cols_previous][prev_solution])
			end
			
		end
	#}	
	end
	#threads.each { |thr| thr.join }
end

puts $max_sum

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
