#!ruby
require 'benchmark'
=begin
Algorithm
As required rectangles is 2 million
-------------------------
|  |  |  |  |  |  |  |  |
-------------------------
|  |  |  |  |  |  |  |  |
-------------------------
|  |  |  |  |  |  |  |  |
-------------------------
|  |  |  |  |  |  |  |  |
-------------------------

4x8
Each row ( 8+7+6+5+4+3+2+1)
Each col (4+3+2+1)

1 by 1 ==> 4*8 =32
1 by 2 ==> 4*7
1 by 3 ==> 4*6
1 by 4 ==> 4*5
1 by 5 ==> 4*4
1 by 6 ==> 4*3
1 by 7 ==> 4*2
1 by 8 ==> 4*1

2 by 1 ==> 3*8
2 by 2 ==> 3*7
so on...


for a 1 row rectangle
	the nearest columns are 2000	 
	as (n)(n+1)/2=2 million
	   n^2 = 2* 2 million
	   n=2000

start rows from 1 
	  cols from 2000
loop
	increment row
	find column that minimizes difference from 2 million using binary search
end
=end

def count_rectangles(row,col)
	(row*(row+1))*(col*(col+1))/4
end
	required = 2000000
	min_diff = 19283012
	min_rows=0
	min_cols=0
	previous_cols = 2000
	cols =2000
	rows =1

time  = Benchmark.realtime do 

	while rows<=cols
		diff = (count_rectangles(rows,cols) -required).abs
		if diff < min_diff
			min_diff =diff
			min_rows =rows
			min_cols = cols
		end
		rows+=1
		cols/=2
			
		#going to nearest using binary search balancing
		right_cols = previous_cols
		left_cols = cols

		while true

			left_diff = count_rectangles(rows,left_cols) - required
			right_diff = count_rectangles(rows,right_cols) - required

			half_diff = count_rectangles(rows,(left_cols+right_cols)/2) - required

			if left_cols==(right_cols-1) or left_cols==right_cols
				if (left_diff).abs < (right_diff).abs
					cols = left_cols
				else
					cols = right_cols
				end
				break
			end
			if half_diff > 0
				right_cols = (left_cols+1+right_cols)/2
			else
				left_cols = (left_cols+right_cols)/2
			end
		end 
		previous_cols =cols
	end
end
puts "Dimension: #{min_rows} x #{min_cols}"
puts "Rectangles: #{count_rectangles(min_rows,min_cols)}"
puts "Area: #{min_rows*min_cols}"
puts "Time taken: #{time*1000 }ms"