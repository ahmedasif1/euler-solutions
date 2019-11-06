

import java.util.ArrayList;

public class Euler103 {

	private static int[] bitmasks = { 1, 2, 4, 8, 16, 32, 64, 128, 256 };

	/**
	 * The Class Subset.
	 * Created for subset handling
	 */
	private class Subset {
		private byte bitmap;
		private int sum;
		private int count;

		public Subset(byte bmap, int sum, int count) {
			this.bitmap = bmap;
			this.sum = sum;
			this.count = count;
		}

		@Override
		public String toString() {
			return "Subset [bitmap=" + bitmap + ", sum=" + sum + ", count=" + count + "]";
		}

		public int getCount() {
			return count;
		}

		public byte getBitmap() {
			return bitmap;
		}

		public int getSum() {
			return sum;
		}

		private boolean isDisjoint(Subset subset) {
			return (getBitmap() & subset.getBitmap()) == 0;
		}

		public boolean satisfiesConditions(Subset subset) {
			boolean satisfies = true;
			if(this.isDisjoint(subset)) {
				satisfies = this.isDisjoint(subset) && getSum() != subset.getSum();
				satisfies = satisfies && ((getSum() > subset.getSum() && getCount() >= subset.getCount())
						|| ((getSum() < subset.getSum() && getCount() <= subset.getCount())));
			}
			return satisfies;
		}

		public Subset createNewSetWith(int number, int index) {
			return new Subset((byte) (this.bitmap | bitmasks[index]), getSum() + number, getCount() + 1);
		}
	}

	private boolean addSubsets(Subset[] subsets, int index, int number) {
		int limit = (int) Math.pow(2, index);
		//create a set with only 1 elememt -> number
		subsets[limit - 1] = new Subset((byte) bitmasks[index], number, 1);
		for (int i = 0; i < limit-1; ++i) {
			//create new sets
			subsets[limit + i] = subsets[i].createNewSetWith(number, index);
		}
		

		for (int i = 0; i < limit - 1; ++i) { //old sets
			for (int j = limit-1; j < 2 * limit - 2; ++j) {//new sets
				if (!subsets[i].satisfiesConditions(subsets[j])) {//check condition satisfaction
					return false;
				}
			}
		}
		return true;
	}

	private static int N = 7;
	private static int minSum = 1000000;
	private static ArrayList<Integer> list = new ArrayList<Integer>();
	
	
	private int getListSum(ArrayList<Integer> arr) {
		return arr.stream().mapToInt(Integer::valueOf).sum();
	}
	private int recursiveAdd(Subset[] subsets, int index, int startValue, int maxValue) {
		if(index == N ) {
			//if all numbers added, then return
			return subsets[subsets.length-2].getSum();
		}

		for(int i = startValue; i < maxValue; ++i) {
			//if sum of numbers in current list exceeds minsum, return a large value
			if(getListSum(list) > minSum) {
				return minSum + 1;
			}
			//add current number to existing and create new sets as well (true if optimum special property satisfies)
			if (addSubsets(subsets, index, i)) {
				list.add(i);
				int currentSum = recursiveAdd(subsets, index + 1, i + 1, index == 2 ? i + startValue : maxValue );
				if(currentSum < minSum) {
					//set min sum
					minSum = currentSum;
					System.out.println(minSum);
					System.out.println(list);

				}
				list.remove(list.size()-1);
			}

		}
		return minSum;
	}
	
	
	private void solve() {
		long startTime = System.currentTimeMillis();
		//create array to store subsets
		Subset[] subsets = new Subset[(int) Math.pow(2, N)];
		//As per problem analysis, for optimum set, value of first was below 25 
		for (int first = 1; first < 25; ++first) {
			//add the first value in set
			subsets[0] = new Subset((byte) bitmasks[0], first, 1);
			//add in below list for tracking purposes
			list.add(first);
			//add further numbers to set recursively
			recursiveAdd(subsets,1,first+1,50);
			list.remove(list.size()-1);
		}
		long endTime = System.currentTimeMillis();
		System.out.println("Elapsed Time:" + (endTime-startTime)+" (ms)");
	}

	public static void main(String[] args) {
		new Euler103().solve();
	}
}
