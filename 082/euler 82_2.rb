#!ruby
$filename ='p082_matrix.txt'

# 3-way motion path sum
# From left column to right column
# Works for only a positive matrix
# Uses dynamic programming
$matrix
$final_sums
$down_sums
$right_sums
$up_sums

def create_matrix_from_file filename
	$matrix = []
	File.open(filename, "r") do |file|
		#open line by line
		file.each_line do |line|
			#split one line with ',' and convert string to integer
			row=line.split(',').map { |a| a.to_i }
			#push a non-empty row in matrix
			$matrix.push(row) if not row.empty?
		end
	end
end


def minimize_sums_in_column column
	move_down(column)
	move_up(column)
end

def move_down column
	$up_sums[0][column] = $right_sums[0][column] = $final_sums[0][column+1] + $matrix[0][column]
	for row in 1..$matrix.size-1
		$right_sums[row][column] = $final_sums[row][column+1] + $matrix[row][column]
		$up_sums[row][column] = [$up_sums[row-1][column],$right_sums[row-1][column]].min + $matrix[row][column]
	end
end

def move_up column
	$down_sums.last[column] = $final_sums.last[column+1] + $matrix.last[column]
	$final_sums.last[column] = [$right_sums.last[column],$up_sums.last[column]].min
	minimum = $final_sums.last[column]
	($matrix.size-2).downto 0 do |row|
		$down_sums[row][column] = [$down_sums[row+1][column],$right_sums[row+1][column]].min + $matrix[row][column]
		$final_sums[row][column]=[$right_sums[row][column],$up_sums[row][column],$down_sums[row][column]].min
		minimum  = [minimum,$final_sums[row][column]].min
	end
	minimum
end

def create_matrix_and_initialize
	#create_matrix_from_file('test_matrix.txt')
	create_matrix_from_file($filename)
	$final_sums = Array.new($matrix.size) { Array.new($matrix.size)}
	$right_sums = Array.new($matrix.size) { Array.new($matrix.size)}
	$down_sums = Array.new($matrix.size) { Array.new($matrix.size)}
	$up_sums = Array.new($matrix.size) { Array.new($matrix.size)}
	for i in 0..$final_sums.size-1
		$final_sums[i][$matrix.size-1] = $matrix[i][$matrix.size-1]
	end
end

t1=Time.now
result=nil
create_matrix_and_initialize()
($matrix.size-2).downto 0  do |col|
	result = minimize_sums_in_column col
end


t2=Time.now
puts 'Euler 82:'
puts "Result of Three-way minimal path sum : #{result}"
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"