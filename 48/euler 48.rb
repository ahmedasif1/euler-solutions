#!ruby
t1 = Time.now
MODULUS = 10000000000

def multiplyMod(a,b)
	(a*b)%MODULUS
end

def addMod(a,b)
	(a+b)%MODULUS
end

#(a^a)%n
def modexp(a)
	result = 1
	a.times do
		result = multiplyMod(result,a)
	end
	result
end


sum = 0
for i in 1..1000
	sum = addMod(sum,modexp(i))
end
puts sum
t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"