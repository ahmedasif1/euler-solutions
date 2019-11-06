#!ruby
require 'set'
t1 =Time.now

$graph={}
$number_of_nodes=0
$array_of_sets=[]
$original_sum=0

def find_in_array_of_sets node
	for i in 0..$array_of_sets.size-1
		if not $array_of_sets[i].nil? and $array_of_sets[i].include? node
			return i
		end 
	end
end


#open file and read graph
File.open("p107_network.txt") do |f|
	node1 = 1
	f.each_line do |l|
		distances =	l.chomp.split(',')
		node2=0
		distances.each do |d|
			node2+=1
			next if node1 > node2 or d=='-'

			$graph[d.to_i]=[] if $graph[d.to_i].nil?			
			$graph[d.to_i].push "#{node1},#{node2}"
			$original_sum+=d.to_i
			
		end
		node1+=1
	end
	$number_of_nodes = node1-1
end



sum=0

for i in 1..40
	s=Set.new
	s.add i
	$array_of_sets.push s
end

$graph = Hash[$graph.sort]




flag=false

$graph.each do |d,array|

	array.each do |s|
		s2 =s.split ','
		set1_index = find_in_array_of_sets s2[0].to_i
		set2_index = find_in_array_of_sets s2[1].to_i
		if set1_index!=set2_index
			sum+=d
			$array_of_sets[set1_index]=$array_of_sets[set1_index]+$array_of_sets[set2_index]
			$array_of_sets[set2_index]=nil
			if $array_of_sets[set1_index].size ==$number_of_nodes
				flag=true
				break
			end
		end
	end
	break if flag
end
t2 =  Time.now
puts "Original sum of edges: #{$original_sum}"
puts "Minimal Spanning tree sum: #{sum}"
puts "Decrease in size: #{$original_sum -sum}"
print 'Time elapsed: '
puts "%0.2f"%((t2-t1)*1000) +' ms'

