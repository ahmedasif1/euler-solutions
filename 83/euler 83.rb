#!ruby
$filename ='p082_matrix.txt'
require 'set'

# 4-way motion path sum
# From top-left to bottom-right
# Works for only a positive matrix
# Uses dijkstra
$matrix
$queue=Set.new
$matrix_of_nodes
$visited
class Node
	attr_accessor :row, :col, :distance,:previous
	def initialize(row,col,distance)
		@distance=distance
		@row = row
		@col=col
		@previous = nil
	end

	def <=>(another)
		@distance <=> another.distance
	end
end

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

def check_min_distance node_src,node_dest
	result = false
	if not node_dest.nil? and node_src.previous != node_dest and node_dest.distance > node_src.distance +  $matrix[node_dest.row][node_dest.col]
		result = true
	else
		result = false
	end
	result
end

def get_node(row,col)
	if row>=0 and row<=$matrix_of_nodes.size-1 and col>=0 and col<=$matrix_of_nodes.size-1
		return $matrix_of_nodes[row][col]
	end
	nil
end

def dijkstra
	$matrix_of_nodes[0][0].distance = $matrix[0][0]
	distance = nil
	#add source in MinQueue
	$queue.add $matrix_of_nodes[0][0]
	
	while true

		#Extract Min
		currentNode = $queue.min
		$queue.delete(currentNode)
		
		if  currentNode.row == $matrix.size-1 and currentNode.col == $matrix.size-1
			# puts currentNode.inspect
			distance = currentNode.distance
			break
		end
		break if currentNode.nil?
		# puts currentNode.inspect
		#get neighbours
		for neighbours in 1..4
			case neighbours
			when 1#above
				neighbour = get_node(currentNode.row-1,currentNode.col)
			when 2#below
				neighbour = get_node(currentNode.row+1,currentNode.col)
			when 3#right
				neighbour = get_node(currentNode.row,currentNode.col+1)
			when 4#left
				neighbour = get_node(currentNode.row,currentNode.col-1)		
			end

			if check_min_distance(currentNode,neighbour)
				neighbour.distance = currentNode.distance + $matrix[neighbour.row][neighbour.col]
				neighbour.previous = currentNode
				$queue.add neighbour
			end
		end
	end
	distance
end

def create_matrix_and_initialize
	# create_matrix_from_file('test_matrix.txt')
	create_matrix_from_file($filename)
	$matrix_of_nodes = Array.new($matrix.size) { Array.new($matrix.size)}
	for i in 0..$matrix.size-1
		for j in 0..$matrix.size-1
			node = Node.new(i,j,Float::INFINITY)
			$matrix_of_nodes[i][j] = node
		end
	end
end

t1=Time.now

create_matrix_and_initialize()
result=nil
result  = dijkstra
t2=Time.now
puts 'Euler 83:'
puts "Result of Four-way minimal path sum : #{result}"
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"