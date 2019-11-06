#!ruby
$filename ='p081_matrix.txt'

# 2-way path sum
# From top-left corner to bottom-right corner
# Works for only a positive matrix


def create_matrix_from_file filename
	matrix = []
	File.open(filename, "r") do |file|
		#open line by line
		file.each_line do |line|
			#split one line with ',' and convert string to integer
			row=line.split(',').map { |a| a.to_i }
			#push a non-empty row in matrix
			matrix.push(row) if not row.empty?
		end
	end
	matrix
end

def find_minimal_path_sum matrix
	#sum_matrix -- for holding sums of path up the minimal particular point
	sum_matrix = Marshal.load(Marshal.dump(matrix))
	for i in 0..matrix.size-1
		for j in 0..matrix.size-1

			sum_matrix[i][j] = matrix[i][j]
			next if i == 0 and j == 0 

			arr=[]
			arr.push sum_matrix[i-1][j] if i > 0
			arr.push sum_matrix[i][j-1] if j > 0

			sum_matrix[i][j]  = matrix[i][j] += arr.min

		end
	end
	sum_matrix[sum_matrix.size-1][sum_matrix.size-1]
end
t1=Time.now
matrix = create_matrix_from_file($filename)
result = find_minimal_path_sum(matrix)
t2=Time.now
puts 'Euler 81:'
puts "Result of Two-way minimal path sum : #{result}"
puts "Time: "+'%0.2f'%((t2-t1)*1000)+ 'ms'