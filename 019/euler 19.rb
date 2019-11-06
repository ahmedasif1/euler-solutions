#!ruby
t1 = Time.now
#How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)
# 0 Sunday	# 1 Monday	# 2 Tuesday	# 3 Wednesday	# 4 Thursday	# 5 Friday	# 6 Saturday
$days_in_month =[]
$days_in_month[0]=31
$days_in_month[1]=28
$days_in_month[2]=31
$days_in_month[3]=30
$days_in_month[4]=31
$days_in_month[5]=30
$days_in_month[6]=31
$days_in_month[7]=31
$days_in_month[8]=30
$days_in_month[9]=31
$days_in_month[10]=30
$days_in_month[11]=31
def is_leap_year(year)
	leap = year%4==0
	if year%100==0
		leap = year%400==0
	end
end

def get_days_month(month,year)
	if month==1 && is_leap_year(year)
		return $days_in_month[month]+1
	else
		return $days_in_month[month]
	end
end


starting_year = 1900
ending_year = 2000
day_count=0
day = 1
month = 0
sundays =0
year = starting_year
loop do
	sundays+=1 if day==0 and year>starting_year
	day+=get_days_month(month,year)
	day = day%7
	month+=1
	month=month%12
	year+=1 if month==0
	break if year>ending_year
end

puts sundays

t2=Time.now
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"