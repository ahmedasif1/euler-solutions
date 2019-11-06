#!ruby
t1=Time.now
LIMIT = 30
array=[]
array.push(nil)
class CountsEndingIn
	attr_accessor :leave,:ontime,:absent

	def initialize
	end

	def sum
		leave + ontime + absent
	end

	def leave_ontime
		leave + ontime
	end
end

day1 = CountsEndingIn.new
day1.leave=1
day1.absent=1
day1.ontime=1

day2 = CountsEndingIn.new
day2.leave=2
day2.absent=3
day2.ontime=3

day3 = CountsEndingIn.new
day3.leave=4
day3.absent=7
day3.ontime=8
array.push(day1)
array.push(day2)
array.push(day3)


for day in 4..LIMIT
	dayCounts = CountsEndingIn.new
	dayCounts.ontime = array[day-1].sum
	dayCounts.absent = array[day-1].leave_ontime + array[day-2].leave_ontime
	dayCounts.leave =  array[day-1].leave + array[day-2].leave + array[day-3].leave

	array.push(dayCounts)
	#puts "#{day}  #{dayCounts.leave + dayCounts.absent + dayCounts.ontime}"
end

puts "Count #{array[LIMIT].sum}"

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"