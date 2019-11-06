#!ruby
#uses dynamic programming 
t1=Time.now

same=[1,1,1,1,1,1,1,1,1,1]
inc=[0,0,0,0,0,0,0,0,0,0]
dec=[0,0,0,0,0,0,0,0,0,0]
bouncy=[0,0,0,0,0,0,0,0,0,0]


limit=100 #number of digits
bouncy_number_count=0 #count bouncy numbers at each number of digit
numbers=10**limit
for digits in 2..limit
		#temporary arrays
		new_bouncy=[0,0,0,0,0,0,0,0,0,0]
		new_inc=[0,0,0,0,0,0,0,0,0,0]
		new_dec=[0,0,0,0,0,0,0,0,0,0]
		new_same=[1,1,1,1,1,1,1,1,1,1]
	for starting in 0..9

		new_bouncy[starting]=bouncy.inject(0) { |mem, var| mem+=var }

		new_same[starting]=same[starting]
		new_inc[starting]=inc[starting..9].inject(0) { |mem, var| mem+=var }
		new_inc[starting]+=same[(starting+1)..9].inject(0) { |mem, var| mem+=var } if starting < 9

		new_dec[starting]=dec[0..starting].inject(0) { |mem, var| mem+=var } 
		new_dec[starting]+=same[0..(starting-1)].inject(0) { |mem, var| mem+=var }if starting > 0


		new_bouncy[starting]+=inc[0..(starting-1)].inject(0) { |mem, var| mem+=var } if starting > 0
		new_bouncy[starting]+=dec[(starting+1)..9].inject(0) { |mem, var| mem+=var } if starting  <9
		#puts new_bouncy[starting] if starting==0
	end

	bouncy=new_bouncy
	dec=new_dec
	inc=new_inc
	same=new_same
	bouncy_number_count+= bouncy[1..9].inject(0){|m,v|m+=v}
end
t2=Time.now

puts (numbers-bouncy_number_count-1)
puts "Time " +'%0.2f'%((t2-t1)*1000) +'ms'