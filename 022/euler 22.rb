#!ruby
t1 = Time.now

names =[]
File.open("p022_names.txt", "r") do |file| 
	string = file.read
	names = string.split(",").map { |word| word.delete('"') }.sort
end
#puts names

name_score_sum=0
minus_Value = 'A'.ord() - 1
for i in 0..names.size-1
	#puts names[i].split('').inspect
	numeric = names[i].split('').map{|v|v.ord-minus_Value}
	#puts numeric.inspect
	name_score = (i+1)*numeric.inject(0){|mem,var|mem+=(var)}
	name_score_sum +=name_score
end
puts name_score_sum



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"