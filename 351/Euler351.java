import java.util.ArrayList;
import java.util.List;

public class Euler351 {

	boolean primes[];
	int[] smallestDivisor;

	private void generatePrimes(int limit) {
		primes = new boolean[limit + 1];
		smallestDivisor = new int[limit + 1];
		for (int i = 2; i <= limit; ++i) {
			primes[i] = true;
		}
		int sqrt = (int) Math.sqrt(limit);

		for (int i = 2; i <= sqrt; ++i) {
			if (primes[i]) {
				int j = i * i;
				do {
					primes[j] = false;
					if (smallestDivisor[j] == 0) {
						smallestDivisor[j] = i;
					}
					j += i;
				} while (j <= limit);
			}
			if (i % 2 == 1) {
				i += 1;
			}
		}

	}

	private List<Integer> getPrimeFactors(int num) {
		List<Integer> primeFactors = new ArrayList<Integer>();
		while (num != 1) {
			int divisor = smallestDivisor[num];
			if (divisor == 0) {// prime
				primeFactors.add(num);
				break;
			} else {
				primeFactors.add(divisor);
			}
			while (num % divisor == 0) {
				num /= divisor;
			}
		}
		return primeFactors;
	}

	private long countCoPrimes(int num, int limit) {
		List<Integer> primeFactors = getPrimeFactors(num);
//		System.out.println("num: " + num + " limit:" + limit);
		long count = 0;
		for (int i = 0; i < primeFactors.size(); ++i) {
			count += traversePrimeFactors(-1 * primeFactors.get(i), primeFactors, i, limit);
		}
//		System.out.println(count);
		return Math.abs(count);
	}

	private long traversePrimeFactors(int product, List<Integer> primeFactors, int index, int limit) {
		long sum = limit / product;
//		System.out.println(product);
		for (int i = index + 1; i < primeFactors.size(); ++i) {
			sum += traversePrimeFactors(product * -1 * primeFactors.get(i), primeFactors, i, limit);
		}
		return sum;
	}

	private void solve() {
		long startTime = System.currentTimeMillis();
		int limit = 100000000;
		generatePrimes(limit);
		long endTime = System.currentTimeMillis();
		System.out.println("Euler 357");
		System.out.println("Primes generated in: " + (endTime - startTime) + " (ms)");

		int hexagonOrder = 100000000;
		long hiddenPointsInTriangle = hexagonOrder - 1;

		for (int x = 2; x < hexagonOrder; ++x) {
			int pointsAbove = hexagonOrder - x;
			hiddenPointsInTriangle += countCoPrimes(x, pointsAbove);

		}
		endTime = System.currentTimeMillis();

		System.out.println(hiddenPointsInTriangle * 6);
		System.out.println("Time Elapsed: " + (endTime - startTime)/1000 + " (s)");
	}

	public static void main(String[] args) {
		new Euler351().solve();
	}
}
