#!ruby
t1 = Time.now
limit = 100

sum_of_squares = (1..limit).to_a.inject(0) { |mem, var| mem+=var**2 }
square_of_sum = ((limit)*(limit+1)/2)**2
puts (square_of_sum - sum_of_squares).abs

t2 = Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"