#!ruby
t1 = Time.now
#sum of digits of 2^1000

puts (2**1000).to_s.split('').inject(0) { |mem, var| mem+=var.to_i }


t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"