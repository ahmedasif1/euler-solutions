
public class Euler357 {
/*
* Euler problem 357
*/
    final static int LIMIT = 100000000;
            
    boolean[] primes = null;
    int limit=10;
    
    public static void main(String[] args) {
        long t1= System.currentTimeMillis();
        
        new Euler357().euler357(LIMIT);
        long t2= System.currentTimeMillis();
        System.out.println("Time Elapses: "+(t2-t1)+ " ms");
    }
    
    //generate primes up till limit using Sieve of Eratosthenes
    //uptil limit
    public void generatePrimes(){
        primes = new boolean[limit+1];
        
        int maxIndex = (int)Math.sqrt(limit);
        
        primes[0]=primes[1]=false;
        
        for (int i = 2; i < limit ; i++) {
            primes[i]=true;
        }
        for (int i = 0; i < maxIndex; i++) {
            if(primes[i]){
                int multiple = i*i;
                while (multiple < limit ){
                    primes[multiple]=false;
                    multiple+=i;
                }
            }
        }
    }
    
    public void euler357(int limit){
        this.limit = limit+1;
        
        generatePrimes();
        
        limit-=1;
        long sum =1;
        for (int product=2;product < this.limit;product+=2 ){
            boolean primeGenerating =true;
            for (int factor = 1;factor<=Math.sqrt(product);++factor){
                //is a factor of number
                if(product%factor==0 && !primes[product/factor+factor]){
                    primeGenerating = false;
                    break;
                }
            }
            if (primeGenerating){
                sum+=product;
            }
        }
        System.out.println(sum);
    }
    
}
