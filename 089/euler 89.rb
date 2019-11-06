#!ruby
$values ={}

$values['M'] =1000
$values['D']=500
$values['C']=100
$values['L']=50
$values['X']=10
$values['V']=5
$values['I']=1

filename ='p089_roman.txt'

def get_value string
#	puts "#{string}  ==> #{string.length}"
	result=0
	i=0
	while i < string.length
		if (string[i]=='I' and i+1 < string.length and (string[i+1]=='X' or string[i+1]=='V') ) or (string[i]=='X' and i+1 < string.length and (string[i+1]=='L' or string[i+1]=='C')) or (string[i]=='C' and i+1 < string.length and (string[i+1]=='D' or string[i+1]=='M'))
			result+=$values[string[i+1]] -$values[string[i]]
			i+=1
		else
			result+=$values[string[i]]
		end
		i+=1
	end
	result
end


def minimum_roman_chars num
	characters = 0
	if num >=1000
		characters+=num/1000
		num=num%1000
	end

	if num >=900
		characters+=2
		num-=900
	end

	if num >=500
		characters+=1
		num-=500
	end
	if num >=400
		characters+=2
		num-=400
	end
	if num>=100
		characters+=num/100
		num=num%100
	end
	if num>=90
		characters+=2
		num-=90
	end
	if num>=50
		characters+=1
		num-=50
	end
	if num>=40
		characters+=2
		num-=40
	end
	if num>=10
		characters+=num/10
		num=num%10
	end
	if num>=9
		characters+=2
		num-=9
	end
	if num>=5
		characters+=1
		num-=5
	end
	if num >=4
		characters+=2
		num-=4
	end
	characters+=num
end

t1=Time.now

result=0
File.open(filename) do |f|
	f.each_line do |l|
		result += l.chomp.length - minimum_roman_chars(get_value(l.chomp))
	end
end
t2 =Time.now

puts result

puts 'Time elapsed: ' + '%0.2f'%((t2-t1)*1000)
=begin
puts "#{(get_value 'MDCCCXXIIII')}" + "   #{minimum_roman_chars(get_value('MDCCCXXIIII'))}" 
puts "#{get_value 'MMMMDCLXXII'}" + "   #{minimum_roman_chars(get_value('MMMMDCLXXII'))}" 
=end