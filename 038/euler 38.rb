#!ruby
t1 = Time.now

PANADIGITAL = '123456789'
LIMIT = 100000
def is_panadigital(str)
	str=str.to_s.split('').sort.join()
	str==PANADIGITAL
end

largest = 0
for i in 1..LIMIT

	if i.to_s.size==i.to_s.split('').uniq.size
		str = i.to_s
		str2 = str
		for j in 2..10
			str2.concat((i*j).to_s)
			break if str2.size>PANADIGITAL.size or str2.size != str2.split('').uniq.size
			if is_panadigital(str2)
				largest = [largest,str2.to_i].max
			end
		end
	end
end

puts largest
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"