#!ruby
t1 = Time.now
#max sum from top to bottom
triangle=[
                           [75],
                         [95, 64],
                       [17, 47, 82],
                     [18, 35, 87, 10],
                    [20,  4, 82, 47, 65],
                  [19,  1, 23, 75,  3, 34],
                [88,  2, 77, 73,  7, 63, 67],
              [99, 65,  4, 28,  6, 16, 70, 92],
            [41, 41, 26, 56, 83, 40, 80, 70, 33],
          [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
        [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
      [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
    [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
  [63, 66,  4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
[04, 62, 98, 27, 23,  9, 70, 98, 73, 93, 38, 53, 60,  4, 23]
]
max_sums =[]
max_sums[0]=[]
max_sums[0][0] = triangle[0][0]
for row in 1..triangle.size-1
	max_sums[row]=[]
	for col in 0..triangle[row].size-1
		#check if top left exists
		sumLeft = 0
		sumRight = 0
		if col!=0
			sumLeft =max_sums[row-1][col-1] + triangle[row][col]
		end
		if col < triangle[row-1].size
			sumRight = max_sums[row-1][col] + triangle[row][col]
		end
		max_sums[row][col] = [sumRight,sumLeft].max
	end
	#puts row.inspect
end

puts max_sums.last.max

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"