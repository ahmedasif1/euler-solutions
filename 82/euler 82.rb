#!ruby
$filename ='p082_matrix.txt'

# 3-way motion path sum
# From left column to right column
# Works for only a positive matrix
# Minimizes sums going from column 0 to last column
$sum_matrix
$matrix

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

def minimize sum,row,column
	replaced=true
	if sum + $matrix[row][column] <= $sum_matrix[row][column]
		$sum_matrix[row][column] = sum + $matrix[row][column]
	else
		replaced=false
	end
	replaced
end

def make_minimal_column(sum_from_left,column,row)
	#puts "minimalize start"

	sum = sum_from_left
	#go from row-1 to 0
	(row-1).downto(0) do |k|
		break if not minimize(sum,k,column)
		sum+=$matrix[k][column]
	end

	sum = sum_from_left
	#go from row+1 to last row
	for k in row+1..$matrix.size-1
		break if not minimize(sum,k,column)
		sum+=$matrix[k][column]
	end
	#puts "minimalize end"
end


def find_minimal_path_sum
	#sum_matrix -- for holding sums of path up the minimal particular point
	$sum_matrix = Array.new($matrix.size){Array.new($matrix.size)}
	#populate the sums with a straight path from left to right
	for i in 0..$matrix.size-1
		for j in 0..$matrix.size-1
			$sum_matrix[i][j] = j==0 ? $matrix[i][j] :  $matrix[i][j] + $sum_matrix[i][j-1]
		end
	end
	for i in 1..$matrix.size-1 #for each column
		for j in 0..$matrix.size-1 #for each row

			sum_from_left = i==1 ? $matrix[j][i-1] : $sum_matrix[j][i-1]

			next if not minimize(sum_from_left,j,i) or i==$matrix.size-1

			make_minimal_column($sum_matrix[j][i],i,j)
		end
	end
	$sum_matrix.transpose[$sum_matrix.size-1].min
end
t1=Time.now
result=nil
#create_matrix_from_file('test_matrix.txt')
create_matrix_from_file($filename)

result = find_minimal_path_sum


t2=Time.now
puts 'Euler 82:'
puts "Result of Three-way minimal path sum : #{result}"
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"