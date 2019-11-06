#!ruby
t1=Time.now
$score=[]
darts=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25]

def add_score num
	$score[num]=0 if $score[num].nil?
	$score[num]+=1
end

for i in 0..21
	for j in i..21
		for k in 1..21		
			#single double double			
			add_score(darts[i]+2*darts[j]+2*darts[k])			
			next if j==0
			#double single double
			add_score(2*darts[i]+darts[j]+2*darts[k])  if i!=j

			#single triple double
			add_score(darts[i]+3*darts[j]+2*darts[k])  if j!=21
			#triple single double
			add_score(3*darts[i]+darts[j]+2*darts[k])  if i!=j and i!=21 and i!=0

			#double triple double
			add_score(2*darts[i]+3*darts[j]+2*darts[k]) if j!=21 and i!=0
			#triple double double
			add_score(3*darts[i]+2*darts[j]+2*darts[k])  if i!=j  and i!=21 and i!=0

			#double double double
			add_score(2*darts[i]+2*darts[j]+2*darts[k]) if i!=0
			#single single double
			add_score(darts[i]+darts[j]+2*darts[k]) if i!=0
			#triple triple double
			add_score(3*darts[i]+3*darts[j]+2*darts[k])if i!=21 and j!=21 and i!=0
		end
	end
end

sum=0
for i in 0..99
	next if $score[i].nil?
	sum+=$score[i]	
end
t2=Time.now
puts "Ways to checkout less than 100: #{sum}"
puts 'Time elapsed: ' + '%0.2f'%((t2-t1)*1000) +' ms'