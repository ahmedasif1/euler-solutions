#!ruby
=begin

def recurse k,arr,count,result
  #puts "#{k } #{count} #{result} #{arr.inspect}"
    return result if count >= result
    
  
    #threads=[]
    for i in 0..arr.size-1
    #for i in (arr.size-1).downto(0) 
          
        
            
            
        #for j in (i).downto(0)
        for j in i..arr.size-1
            #t=result 
            
            
         #   puts "#{i} #{j}"
            
            arr2=arr.clone
            #puts "#{i} #{j} #{k } #{count} #{result} #{arr2.inspect}"
            num=arr2[i]+arr2[j]
            if not arr2.include? num
                if num > k
                    break
                elsif num==k
                    #puts 123
                    #t=(t > count ? count : t)
                    return count
                else
                    arr2.push num
             #       puts 'here'
                    temp=recurse k,arr2,count+1,result
                    
                    result=(temp < result ? temp : result)
                    
                end                
            end
            #result=(result < t ? result : t)    
         
        end    
        
    end
    
    
    result
end



def efficient_expo k
    return 0 if k==1
    return 1 if k==2
    arr=[1]
    recurse k,arr,1, (1.5*Math.log(k,2)).to_i

end

for i in 1..100
    puts "#{i} #{efficient_expo i}"
end

#puts efficient_expo 150

end
=end


#try 2 with dp
=begin
require 'set'
$memoization={}
$result=[]
$memoization[1]=[SortedSet.new]
$memoization[1][0].add 1
$result[1]=0
$sum=0
$last_smallest=1

def init i
    j=$last_smallest
    $result[i]=(Math.log(i,2)*1.9).to_i
    $memoization[i]=[]
    k=i-j
    for l in 0..$memoization[j].size-1            
        for m in 0..$memoization[k].size-1
            new_set=$memoization[j][l]+$memoization[k][m]
            new_set.add i
            if new_set.size-1 < $result[i]
                $memoization[i]=[new_set]
                $result[i]=new_set.size-1
            elsif new_set.size-1 == $result[i]
                $memoization[i].push new_set
            end
        end
    end
end


for i in 2..200
    #init i
    $result[i]=(Math.log(i,2)*1.5).to_i
    $memoization[i]=[]
    for j in 1..i/2
        k=i-j
        next if $result[j] >=$result[i] or $result[k] >=$result[i]
        for l in 0..$memoization[j].size-1            
            for m in 0..$memoization[k].size-1
                new_set=$memoization[j][l]+$memoization[k][m]
                new_set.add i
                if new_set.size-1 < $result[i]
                    $memoization[i]=[new_set]
                    $result[i]=new_set.size-1
                elsif new_set.size-1 == $result[i]
                    $memoization[i].push new_set
                end
            end
        end


    end
    if $result[i]<$result[i-1]
        $last_smallest=i
    end
    $sum+=$result[i]
    puts "#{i} #{$result[i]}"
end
puts $sum

=end

#try 3 with mathblog

$limit=200
$sum=0
$result=[0,0]
def go_deep steps,array    
    #puts array.last
    if steps >20
        return
    end
    if array.last > $limit
        return
    end
    $result[array.last]=steps if $result[array.last].nil?
    if $result[array.last] >= steps
        $result[array.last]=steps
    else
        return
    end

    
    double= array.last+array.last
    if double <= $limit
        a=array.clone
        a.push double
    #    puts 'recursion 1'
        go_deep steps+1,a
    end
    for j in 0..array.size-2
        n=array[j]+array.last
        if n <= $limit
            b=array.clone
            b.push n
    #        puts 'recursion 2'
            go_deep steps+1,b
        end
    end
end

$result[1]=0
array=[1]
go_deep 0,array
#puts $result

puts "Euler 122"
print "Minimal Exponentiation Path Sum(1-200): "
puts $result.inject(0) { |mem, var|mem+var  }



