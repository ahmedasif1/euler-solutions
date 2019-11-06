#!ruby
t1 = Time.now
red_length = 2
green_length = 3
blue_length = 4
def fact n
	return 1 if n==0
	n*fact(n-1)
end
sum=0
space=50
i=0
while space >=red_length
	i+=1
	space-=red_length
	if space==0
		sum+=1
		break
	end
	sum+=fact(i+space)/fact(i)/fact(space)
end

space=50
i=0
while space >=green_length
	i+=1
	space-=green_length
	if space==0
		sum+=1
		break
	end
	sum+=fact(i+space)/fact(i)/fact(space)
end

space=50
i=0
while space >=blue_length
	i+=1
	space-=blue_length
	if space==0
		sum+=1
		break
	end
	sum+=fact(i+space)/fact(i)/fact(space)
end
t2=Time.now
puts "Ways : #{sum}"
puts 'Time elapsed: ' +'%0.2f'%((t2-t1)*1000) + ' ms'