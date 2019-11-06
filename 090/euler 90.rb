#!ruby
# 0 1 2 3 4 5 6 8 9
t1=Time.now
$squares = [[0,1],[0,4],[0,6],[1,6],[2,5],[3,6],[4,6],[8,1]]
#check if all square numbers can be formed from the combination
def check_square (comb1, comb2)
	contains_squares =true
	#01 04 09 16 25 36 49 64 81 
	for i in 0..$squares.size-1
		if not((comb1.include? $squares[i][0] and comb2.include? $squares[i][1]) or
		 (comb2.include? $squares[i][0] and comb1.include? $squares[i][1])) 
			contains_squares = false
			break
		end
	end
	contains_squares
end

def replace_9_with_6(arr)
	if arr.last==9
		arr[arr.size-1]=6
	end
	arr.sort
end

array = [0,1,2,3,4,5,6,7,8,9]


#generate all possible combinations
combinations = array.combination(6).to_a

size = combinations.size

count =0 
for i in 0..size-1
	comb1 = replace_9_with_6(combinations[i])
	
	for j in i+1..size-1
		comb2 = replace_9_with_6(combinations[j])
		count+=1 if check_square( comb1 , comb2)
		
	end
end
puts count


t2 =Time.now
puts 'Time elapsed: ' + '%0.2f'%((t2-t1)*1000) +" ms"
