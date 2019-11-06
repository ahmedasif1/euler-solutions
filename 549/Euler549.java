
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

public class Euler549 {

	boolean[] numberBit;
	final static int SIEVE_LIMIT = 100000000;
	int[] firstEncounter = new int[SIEVE_LIMIT + 1];

	private void findPrimesWithSieve() {
		numberBit = new boolean[SIEVE_LIMIT + 1];
		numberBit[0] = numberBit[1] = false;

		for (int i = 2; i <= SIEVE_LIMIT; ++i) {
			numberBit[i] = true;
			firstEncounter[i] = 0;
		}

		for (int i = 2; i <= SIEVE_LIMIT; ++i) {
			if (numberBit[i]) {
				int j = i + i;
				while (j <= SIEVE_LIMIT) {
					if (firstEncounter[j] == 0) {
						firstEncounter[j] = i;
					}
					numberBit[j] = false;
					j += i;
				}
			}
			if(i>2) {
				i+=1;
			}
		}
	}

	private Map<Integer, Integer> findPrimeFactors(final int value) {
		Map<Integer, Integer> primeFactors = new HashMap<Integer, Integer>();
		int n = value;
		while (n!=1) {

			if (numberBit[n]) {
				primeFactors.put(n, 1); // if found prime
				break;
			} else {
				int divisor = firstEncounter[n];

				int count = 0;
				do {
					if(divisor==0) {
						System.out.println(value);
						System.out.println(n);
						System.out.println(divisor);
					}
					n = n / divisor;
					count += 1;
				} while (n!=1 && n % divisor == 0);
				
				if (count > 0) {
					primeFactors.put(divisor, count);
				}
			}
		}
		return primeFactors;
	}

	private int foo(int num, int power) {
		int result = num;
		for(int i=1;i<power;) {
			int temp = result+num;
			while(temp!=1 && temp%num == 0) {
				temp = temp/num;
				i+=1;
			}
			result =result+num;
		}
		return result;
	}
	
	private int findMinFactorialValue(Map<Integer, Integer> map) {
		int result = -1;
		for(Integer primeFactor: map.keySet()) {
			int power = map.get(primeFactor);
			int foo = foo(primeFactor,power);
			result = foo > result ? foo : result;
		}
		return result;
	}
	
	
	private void solve() {
		long startTime = System.currentTimeMillis();
		int n = 100000000;
		System.out.println("Euler 549 - Divisibility of factorials");
		findPrimesWithSieve();
		BigInteger sum = new BigInteger("0");
		System.out.println("Sieve Completed");
		for (int i = 2; i <= n; ++i) {
			Map<Integer, Integer> primeFactors = findPrimeFactors(i);
			long factValue = findMinFactorialValue(primeFactors);
			sum = sum.add(BigInteger.valueOf(factValue));
		}
		System.out.println(sum);
		long endTime = System.currentTimeMillis();
		System.out.println("Duration: " + (endTime-startTime)/1000 +"(s)");
	}

	public static void main(String[] args) {
		new Euler549().solve();
	}
}
