#!ruby
asciis=[]
File.open("p059_cipher.txt", "r") do |file| 
	string = file.read
	asciis = string.split(",")
end

arr1=[]
arr2=[]
arr3=[]

for i in 0..255
	arr1.push 0
	arr2.push 0
	arr3.push 0
end


a='g'.ord

b='o'.ord

c='d'.ord
i=0	
result =0
while i <asciis.length
	print (a^Integer(asciis[i])).chr
	result+=a^Integer(asciis[i])
	if(i+1<asciis.length)
		print (b^Integer(asciis[i+1])).chr		
		result+=b^Integer(asciis[i+1])
	end
	if(i+2<asciis.length)
		result+=c^Integer(asciis[i+2])
		print (c^Integer(asciis[i+2])).chr
	end			
	i=i+3
end
puts 
puts result
