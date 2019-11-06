#!ruby
#product sum numbers
=begin

k=2: 4 = 2 × 2 = 2 + 2
k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6   

k=7: 12 = 1 × 1 × 1 × 1 × 1 x 3 × 4 = 1 + 1 + 1 + 1 + 1 + 3 + 4
k=8: 12 = 1 × 1 × 1 × 1 × 1 x 2 x 2 x 3 = 1 + 1 + 1 + 1 + 1 + 2 + 2 + 3
k=9: 15 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 3 × 5 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 3 + 5
k=10:16 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 4 x 4 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 4 + 4
k=11:16 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 2 x 2 x 4 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 4
k=12:16 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 2 x 2 x 2 x 2 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 2 + 2
k=13:18 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 2 x 3 x 3 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 3 + 3
k=14:20 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 2 x 2 x 5 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 5
k=15:24 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 3 x 8 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 3 + 8
k=16:24 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 1 x 4 x 6 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 4 + 6
k=17:24 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 1 x 2 x 2 x 6 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 6
k=18:24 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 1 x 1 x 2 x 3 x 4 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 3 + 4
k=19:24 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 1 x 1 x 2 x 2 x 2 x 3 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 2 + 3
k=20:28 = 1 × 1 × 1 × 1 × 1 x 1 x 1 x 1 × 1 x 1 x 1 x 1 x 1 x 1 x 1 x 1 x 1 x 2 x 2 x 7 = 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 2 + 2 + 7


$current=4
$prime_factors={}

$primes=[]

$size=25000
for i in 0..$size
    $primes[i]=true
end
$primes[0]=false
$primes[1]=false

for i in 2..$size
    next if not $primes[i]
    j=i+i
    while j <$size       
        $primes[j]=false
        j+=i
    end
end
#current contains an array containing the current 
def check digits,sum,factors,current
    #puts "#{digits} #{sum} #{factors.inspect} #{current.inspect}"
    if factors.size==0
        if digits==current.size and (current.inject(0) { |mem, var| mem+var })==sum        
          #  puts 1
            return true        
        else 
          #  puts 2
            return false
        end
    end
    threads=[]
    res=nil
    for i in 0..factors.size-1
        
        #select a factor from the list
        
        
        if factors.size > digits-current.size
            current2=current.clone
            current2[current2.size-1]*=factors[i]        
            factors2=factors.clone
            factors2.delete_at(i)
            if  res.nil? and check digits , sum , factors2,current2
                #return true
                res=true
            end
        end
        if res.nil? and  current.last !=1 and current.size < digits
            current3=current.clone            
            current3.push 1
            current3[current3.size-1]*=factors[i]
            factors3=factors.clone
            factors3.delete_at(i)
            if check digits , sum , factors3,current3
                #return true
                res=true
            end            
        end
    
    
    end
    
    if not res.nil?
       # puts 123
        return true
    end

    false
end


def find_prime_factors numX
    num=numX
    i=2
    factors=[]    
    while num!=1        
        break if not $prime_factors[num].nil?
        if num%i==0
            num/=i
            factors.push i
        else
            i+=1
            while not $primes[i]
                i+=1
            end
        end
    end
    if num!=1
        factors+=$prime_factors[num]
    end
    $prime_factors[numX]=factors
end




def find_product_sum(k)
    $current=k+1
    while $current < $size        
      #  puts "#{k} #{$current}"
        for i in 2..$prime_factors[$current].size
            number_of_1s=k-i  #number_of_1s
            sum = $current - number_of_1s
          #  puts "#{k} #{i} #{sum}"
            
            if check  i , sum,$prime_factors[$current].clone,[1]
            #    puts 123
                return $current
            end
           # exit
        end
        $current+=1
        while $primes[$current]
            $current+=1
        end
    end
end

for i in 2..24000
    find_prime_factors i
end


for k in 2..1000
   puts "#{k} #{find_product_sum k}"
end
=end


#try 2
max =24000
$max =24000
$min_prod_sum=[]
for i in 2..max
    $min_prod_sum[i]=2*i
end

def make_minimum digits,sum,product
    return if product > $max
    #puts "#{product} #{sum} #{digits}"
    k= product-sum +digits
    return if k >12000
    #puts k
    $min_prod_sum[k] = ($min_prod_sum[k] > product ? product : $min_prod_sum[k])
end


def recursive_loop digits,product,sum
    make_minimum digits,sum,product
    return if digits==14
    for a in 2..$max/product        
        recursive_loop(digits+1,product*a,sum+a)
    end
end



for a in 2..max/2
    for b in 2..max/a
       p1 =a*b
       s1=a+b       
       recursive_loop 2,p1,s1      
    end
end

res= $min_prod_sum[2..12000].uniq.inject(0) { |mem, var| mem+var }
puts res





































