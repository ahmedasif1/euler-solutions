#!ruby
t1=Time.now
require 'matrix'

=begin
uses a markov model of monopoly
transition matrix for

state = number_of_doubles*40 +location
120 by 120 matrix transition matrix

=end

$dice=4
$matrix=Matrix[]

for doubles in 0..2
	for location in 0..39
		array=[]
		120.times{array.push 0.0}
		if location==30
			$matrix=Matrix.rows($matrix.to_a<<array)
			next
		end

		for dice1 in 1..$dice
			for dice2 in 1..$dice
				if dice1==dice2 and doubles==2
					array[10]+=1
					next
				end
				d=(dice1==dice2) ? doubles+1 :0
				loc=(location+dice1+dice2)%40
				if loc==30
					array[d*40+10]+=1
				elsif loc==2 or loc==17 or loc==33
					array[d*40+0]+=1.0/16
					array[d*40+10]+=1.0/16
					array[d*40+loc]+=14.0/16
				elsif loc==7 or loc==22 or loc==36
					array[d*40+0]+=1.0/16
					array[d*40+10]+=1.0/16
					array[d*40+5]+=1.0/16
					array[d*40+11]+=1.0/16
					array[d*40+39]+=1.0/16
					array[d*40+24]+=1.0/16
					array[d*40+loc-3]+=1.0/16
					if loc==7
						array[d*40+15]+=2.0/16
						array[d*40+12]+=1.0/16
					elsif loc==22
						array[d*40+25]+=2.0/16
						array[d*40+28]+=1.0/16
					elsif loc==36
						array[d*40+5]+=2.0/16
						array[d*40+12]+=1.0/16
					end	
					array[d*40+loc]+=6.0/16
				else
					array[d*40+loc]+=1
				end
			end
		end
		sum=array.inject(0) { |mem, var| mem=mem+var }
		array=array.map{|v|v/sum}
		$matrix=Matrix.rows($matrix.to_a<<array)
	end
end
#puts $matrix



vec = Matrix.row_vector($matrix.row(0).to_a)

for i in 0..45
	vec=vec*$matrix
end

arr=[]
40.times{arr.push 0.0}
for d in 0..2
	for i in 0..39
		arr[i]+=vec[0,d*40+i]
	end
end
h={}
for i in 0..39
	h[arr[i]]=i
end
h=Hash[h.sort_by{|k,v|k}.reverse]

i=0
h.each do |k,v|
	puts v
	i+=1
	break if i==3
end

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"

