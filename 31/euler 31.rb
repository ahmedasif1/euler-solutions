#!ruby
require 'set'
t1 = Time.now

TARGET = 200
COINS = [1,2,5,10,20,50,100,200]
set = Set.new
def count_combination_of_coins(prev_coin,sum)
	count = 0
	for coin_index in prev_coin..COINS.size-1
		if sum+COINS[coin_index] == TARGET
			count+=1
		elsif sum+COINS[coin_index] > TARGET
			break
		else
			count+=count_combination_of_coins(coin_index,sum+COINS[coin_index])
		end
	end
	count
end



puts count_combination_of_coins(0,0)



t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"