#!ruby
t1=Time.now
TILES = 1000000

#hash storing (4*n-4) 
$tiles_in_square={}
#holds count of possible arrangements of tiles in form of square lanimae
$square_lamina={}
#holds a hash of arrays such that {a=[x1,x2,x3],b=[x1..],..}
#holds sums of tiles contained in laminae if a/b is outer length
$history={}

#create a hash storing (4*n-4) 
# such that (4*n-4) <= tiles
def build_cache(tiles)
	limit=(tiles+4)/4
	for i in 3..limit
		$tiles_in_square[i] = 4*i-4
	end
end

build_cache(TILES)

#set to a large number, so it cant be used
$history[1]=[TILES]
$history[2]=[TILES]


for sq_len in 3..(TILES+4)/4

	$history[sq_len]=[]

	border_tiles = $tiles_in_square[sq_len]


	$history[sq_len][0]=border_tiles

	$square_lamina[border_tiles] = 0 if $square_lamina[border_tiles].nil?
	$square_lamina[border_tiles]+=1
	
	inner = sq_len-2

	$history[inner].each do |tiles|
		sum = tiles + border_tiles
		break if sum > TILES

		$square_lamina[sum] = 0 if $square_lamina[sum].nil?

		$square_lamina[sum]+=1

		$history[sq_len].push sum
	end
	
end

sum=0
#count the combinations x(key) tiles have if no.of combinations is 1..10
$square_lamina.each do |key,value|
	sum+=1 if value>=1 and value <=10
end
puts sum

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"