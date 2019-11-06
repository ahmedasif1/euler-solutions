#!ruby
$operators=['-','+','*','/']



def count_max a,b,c,d
	array =[a,b,c,d]

	result_array=[]
	array.each do |a1|
		array.each do |a2|
			next if a1==a2
			array.each do |a3|
				next if a3==a2 or a3==a1
				array.each do |a4|
					next if a4==a1 or a4==a2 or a4==a3
				 	$operators.each do |op1|
				 		$operators.each do |op2|
				 			$operators.each do |op3|				 				
				 					r1=eval "#{a1*1.0} #{op1} #{a2*1.0} #{op2} #{a3*1.0} #{op3} #{a4*1.0}"
				 					result_array[r1]=true if r1!=Float::INFINITY and r1==r1.truncate and r1>=0				 								 				
				 					r1=eval "#{a1*1.0} #{op1} #{a2*1.0} #{op2} ( #{a3*1.0} #{op3} #{a4*1.0} )"
				 					result_array[r1]=true if r1!=Float::INFINITY and r1==r1.truncate and r1>=0
				 					r1=eval "#{a1*1.0} #{op1} ( #{a2*1.0} #{op2} #{a3*1.0} #{op3} #{a4*1.0} )"
				 					result_array[r1]=true if r1!=Float::INFINITY and  r1==r1.truncate and r1>=0
				 					r1=eval "#{a1*1.0} #{op1} ( #{a2*1.0} #{op2} #{a3*1.0} ) #{op3} #{a4*1.0}"
				 					result_array[r1]=true if  r1!=Float::INFINITY and r1==r1.truncate and r1>=0
				 					r1=eval "( #{a1*1.0} #{op1} #{a2*1.0}) #{op2} ( #{a3*1.0} #{op3} #{a4*1.0} )"
				 					result_array[r1]=true if  r1!=Float::INFINITY and r1==r1.truncate and r1>=0				 				
				 			end
				 		end 		
				 	end
				end
			end
		end
	end
	count=0
	for i in 1..result_array.size-1
		if result_array[i]
			count+=1
		else
			break
		end
	end
	count
end



max =9
array =[0,0,0,0]
result=0
for i in 1..max
	for j in i+1..max
		for k in j+1..max
			for l in k+1..max

				temp=count_max(i,j,k,l)
				
				if temp >result
					result=temp
					array=[i,j,k,l]
				end
			end
		end
	end
end

puts array.map{|v|v.to_s}.inject('') { |mem, var| mem+=var }