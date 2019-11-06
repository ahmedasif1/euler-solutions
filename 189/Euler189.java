package com.euler.euler189;

import java.util.HashMap;
import java.util.Map;

public class Euler189 {

	Map<String, Long> stringCount;
	Map<String, Long> stringCountPrevious;

	static char[] colors = { 'R', 'G', 'B' };

	boolean compareWithParent(char myChar, int index, String parentString) {
		return parentString.charAt(index) != myChar;
	}

	void addCharacter(int row, String prevString, int rowLength, String currentStr) {
		if (currentStr.length() == rowLength) {
			Long prevCount = stringCount.get(currentStr);
			if (prevCount == null)
				prevCount = 0L;
			stringCount.put(currentStr, prevCount + stringCountPrevious.get(prevString));
			return;
		}

		for (int i = 0; i < colors.length; ++i) {
			boolean passed = true;
			if (row % 2 == 1) {// odd row, only check 1 parent
				if (!compareWithParent(colors[i], currentStr.length(), prevString)) {// color different from parent
					passed = false;
				}
			} else {// even numbered row, check 2 parents for middle ones
				if (currentStr.length() > 0) {// check left parent
					if (!compareWithParent(colors[i], currentStr.length() - 1, prevString)) {
						passed = false;
					}
				}
				if (currentStr.length() < rowLength - 1) {// check right parent
					if (!compareWithParent(colors[i], currentStr.length(), prevString)) {
						passed = false;
					}
				}
			}
			// if color is satisfied by both parents
			if (passed) {
				addCharacter(row, prevString, rowLength, currentStr + colors[i]);
			}
		}
	}

	void generateCombinations(int row) {
		int rowLength = row / 2 + 1;
		for (String prev : stringCountPrevious.keySet()) {
			addCharacter(row, prev, rowLength, "");
		}
	}

	long count() {
		long count = 0;
		for (Long counts : stringCountPrevious.values()) {
			count += counts;
		}
		return count;
	}

	/**
	 * Solve.<br>
	 * Algo Description:<br>
	 * Uses a type of dynamic programming<br>
	 * Stores combinations of previous row and the count of ways in which they can be produced<br>
	 * <br>
	 * For each combination of previous row:<br>
	 * 	<b>1. </b> Initiate a new empty string<br>
	 *  <b>2. </b> Add characters recursively depending on their presence in the parent<br>
	 *  <b>2. </b> When row gets completed, store and increment their count<br>
	 * Promote current counts to previous and repeat for each row similarly<br>
	 */
	void solve() {
		long startTime = System.currentTimeMillis();
		stringCountPrevious = new HashMap<String, Long>();
		stringCount = new HashMap<String, Long>();
		int maxRowCount = 8;
		int totalRows = 2 * maxRowCount - 1;
		stringCountPrevious.put("R", 1L);
		stringCountPrevious.put("G", 1L);
		stringCountPrevious.put("B", 1L);
		for (int i = 1; i < totalRows; ++i) {
			generateCombinations(i);
			Map<String, Long> tempMap = stringCountPrevious;
			stringCountPrevious = stringCount;
			tempMap.clear();
			stringCount = tempMap;
		}
		System.out.println("Euler 189: Tri-colouring a triangular grid");
		System.out.println("Solution: "+ count());
		long endTime = System.currentTimeMillis();
		System.out.println("Time Elapsed: " + (endTime - startTime)+"(ms)");
	}

	public static void main(String[] args) {
		new Euler189().solve();
	}
}
