package com.euler;

import java.math.BigInteger;

public class Euler106 {
	static String alphas = "abcdefghijklmnopqrstuvwxyz";


	/**
	 * Binomial.
	 *
	 * @param N the n
	 * @param K the k
	 * @return the n Choose r
	 */
	static BigInteger binomial(final int N, final int K) {
		BigInteger ret = BigInteger.ONE;
		for (int k = 0; k < K; k++) {
			ret = ret.multiply(BigInteger.valueOf(N - k)).divide(BigInteger.valueOf(k + 1));
		}
		return ret;
	}

	private static int checkIfEqualityCheckRequired(String subset, int setSize) {
		// create new String
		String subset2 = "";
		for (int i = 0; i < setSize; ++i) {
			if (!subset.contains(String.valueOf(alphas.charAt(i)))) {
				subset2 = subset2 + alphas.charAt(i);
			}
		}
		int count = 0;
		for (int i = 0; i < subset.length(); ++i) {
			count += subset.charAt(i) < subset2.charAt(i) ? 1 : 0;
		}
		return count != subset.length() ? 1 : 0;
	}

	private static int addElementToSet(String subset, int subsetSize, int setSize, int index, int lastValue) {
		if (subset.length() == subsetSize) {
			return checkIfEqualityCheckRequired(subset, setSize);
		}
		int count = 0;
		for (int value = lastValue + 1; value <= setSize - (subsetSize - index); ++value) {
			count += addElementToSet(subset + alphas.charAt(value), subsetSize, setSize, index + 1, value);
		}
		return count;
	}

	private static int findSetsRequiringChecking(int subsetSize, int setSize) {
		return addElementToSet("a", subsetSize, setSize, 1, 0);
	}

	public static void main(String[] args) {
		//In this problem, S(B)!=S(C) needs to be checked only
		long startTime = System.currentTimeMillis();
		int setSize = 12;
		int totalCount = 0;
		//As these are sets, subset of size 1 are not used as no 2 elements have same value
		for (int subsetSize = 2; subsetSize <= setSize / 2; ++subsetSize) {
			int usedSetSize = subsetSize * 2;
			//find combination count in which usedSetSize elements can be selected from set of size setSize
			int nCr = binomial(setSize, usedSetSize).intValue();
			//find count of sets which need to be checked from sum equality
			int count = findSetsRequiringChecking(subsetSize, usedSetSize);
			//calculate the subset pairs of size subsetSize which needs checking
			int product = nCr*count;
			totalCount += product;
//			System.out.println("SubsetSize: " + subsetSize);
//			System.out.println("nCr: " + nCr);
//			System.out.println("Subset pairs: " + count);
//			System.out.println("Product:"+nCr*count);

		}
		long endTime = System.currentTimeMillis();
		System.out.println("Euler 106: Special subset sum - meta testing");
		System.out.println("Solution: "+totalCount);
		System.out.println("Time Elapsed: " + (endTime - startTime) + "(ms)");
	}
}
