import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Euler622 {

	private void generatePrimes() {
		primes = new boolean[SIEVE_LIMIT + 1];
		for (int i = 2; i <= SIEVE_LIMIT; ++i) {
			primes[i] = true;
		}
		int sqrt = (int) Math.sqrt(SIEVE_LIMIT);
		for (int i = 2; i <= sqrt; ++i) {
			if (primes[i]) {
				int j = i + i;
				while (j <= SIEVE_LIMIT) {
					primes[j] = false;
					j += i;
				}
			}
			if (i > 2) {
				++i;
			}
		}
	}

	private int countRiffleShuffles(long deckSize) {
//		System.out.println(deckSize);
		BigInteger dSize = BigInteger.valueOf(deckSize);
		int shuffles = 0;
		BigInteger i = BigInteger.ONE;
		do {
			i = i.multiply(BigInteger.valueOf(2)).mod(dSize.subtract(BigInteger.ONE));

			++shuffles;
		} while (!i.equals(BigInteger.ONE));

		return shuffles;
	}

	private void findPrimeFactors() {
		BigInteger _2powerK = BigInteger.valueOf(2);
		_2powerK = _2powerK.pow(k).subtract(BigInteger.ONE);// 2^k -1
		long sqrt = (long) Math.sqrt(_2powerK.doubleValue());
		primeFactors = new ArrayList<Integer>();
		for (int i = 2; i <= sqrt; ++i) {
			if (primes[i]) {
				BigInteger temp = BigInteger.valueOf(i);
				while (_2powerK.mod(temp).equals(BigInteger.ZERO)) {
					primeFactors.add(i);
					_2powerK = _2powerK.divide(temp);
					if (_2powerK.longValue() <= SIEVE_LIMIT && primes[_2powerK.intValue()]) {
						primeFactors.add(_2powerK.intValue());
						return;
					}
				}
			}
			if (_2powerK.equals(BigInteger.ONE)) {
				break;
			}
		}

	}

	// prime factors from (2^60 -1)
	private boolean[] primes;
	private final int SIEVE_LIMIT = 1000000;
	private List<Integer> primeFactors;
	private int k;
	private BigInteger sum = BigInteger.ZERO;

	private int calculateProducts(int index, long product) {
		int count = 1;

		int shuffles = countRiffleShuffles(product + 1);
//		System.out.println("Deck Size:" + (product + 1) + " Shuffles:" + shuffles);

		if (shuffles == k) {
			sum = sum.add(BigInteger.valueOf(product + 1));
		}

		if (index < primeFactors.size() - 1 && primeFactors.get(index) == primeFactors.get(index + 1)) {
			count += calculateProducts(index + 1, primeFactors.get(index) * product);
		} else {

			for (int i = index + 1; i < primeFactors.size(); ++i) {
				count += calculateProducts(i, primeFactors.get(i) * product);
			}

		}

		return count;
	}

	/**
	 * next index of a card after perfect shuffle is<br>
	 * n = half of deck
	 * 
	 * if in first half<br>
	 * <b>2*i</b><br>
	 * in second half<br>
	 * <b>2 * (i%n) +1 </b><br>
	 * <b>2 * ( i % n ) + 2(1/2) </b><br>
	 * <b>2 * ( i % n + 1/2 )</b><br>
	 * <b>2 * ( i % ( n - 1/2 ) )</b><br>
	 * <b>2 * i % ( 2n -1 ) </b>----> can also be used for 1st half since nothing
	 * being added after taking the mod
	 * 
	 * After k shuffles, a card will be back to its initial position <br>
	 * <b>2 ** k * i % (2n-1) == i </b><br>
	 * <b>2 ** k % (2n-1) == 1 </b><br>
	 * <b>2 ** k == 1 mod (2n-1)</b><br>
	 * <b>2 ** k - 1 == 0 mod(2n-1)</b> ----> 2**k - 1 is is a multiple of 2n-1 <br>
	 * <br>
	 * Solution: <br>
	 * <ul>
	 * <li>Find all prime factors of 2**k -1</li>
	 * <li>Create all factors of 2**k -1 using the prime factors found</li>
	 * <li>Calculate the minimum perfect shuffles required for each factor (f+1)
	 * since f = 2n-1</li>
	 * <li>If riffle shuffles are ===k, add to sum</li>
	 * </ul>
	 */
	private void solve() {
		System.out.println("Euler 622 - Riffle Shuffles");
		long startTime = System.currentTimeMillis();
		generatePrimes();
		k = 60;
		findPrimeFactors();
		for (int i = 0; i < primeFactors.size(); ++i) {
			calculateProducts(i, primeFactors.get(i));
		}
		System.out.println(sum);

		long endTime = System.currentTimeMillis();
		System.out.println("Time Elapsed: " + (endTime - startTime) + " (ms)");
	}

	public static void main(String[] args) {
		new Euler622().solve();
	}
}
