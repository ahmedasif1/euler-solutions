#!ruby
t1 = Time.now
red_length = 2
green_length = 3
blue_length = 4
def fact n
	return 1 if n==0
	n*fact(n-1)
end
total_area = 50

sum=0
for i in 0..(total_area/blue_length)
	sp1 = total_area - i*blue_length
	for j in 0..(sp1/green_length)
		sp2 = sp1 - j*green_length
		for k in 0..(sp2/red_length)
			sp3 = sp2 - k*red_length
			sum+=fact(i+j+k+sp3)/fact(i)/fact(j)/fact(k)/fact(sp3)

		end
	end
end
t2=Time.now
puts "Ways : #{sum}"
puts 'Time elapsed: ' +'%0.2f'%((t2-t1)*1000) + ' ms'
