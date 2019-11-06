import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Euler105 {

	static int[] bitmasks = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096 };

	 /**
	 * The Class Subset.
	 * Created for subset handling
	 */
	private class Subset {
		private int bitmap;
		private int sum;
		private int count;

		public Subset(int bmap, int sum, int count) {
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

		public int getBitmap() {
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
			return new Subset((this.bitmap | bitmasks[index]), getSum() + number, getCount() + 1);
		}
	}
	public static void main(String[] args)  {
		new Euler105().readFromFile();
	}
	
	List<List<Integer>> sets = new ArrayList<>(); 
	
	private boolean addSubsets(Subset[] subsets, int index, int number) {
		int limit = (int) Math.pow(2, index);
		//create a set with only 1 elememt -> number
		subsets[limit - 1] = new Subset(bitmasks[index], number, 1);
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

	private long createSubsetsAndVerify(List<Integer> set) {
		boolean verified = true;
		long sum = set.get(0);
		Subset[] subsets = new Subset[(int) Math.pow(2, set.size())];
		subsets[0] = new Subset(bitmasks[0], set.get(0), 1);
		
		for(int i = 1; verified && i < set.size();++i) {
			verified = addSubsets(subsets, i, set.get(i));
			sum+=set.get(i);
		}
		return verified ? sum :0;
	}
	
	private void convertAndStore(String[] numbers) {
		sets.add(new ArrayList<>(numbers.length));
		for(String s: numbers) {
			sets.get(sets.size()-1).add(Integer.parseInt(s));
		}
	}
	
	private void readFromFile() {
		try(BufferedReader bufferedReader = new BufferedReader(new FileReader("p105_sets.txt"))){
			String s = null;
			while((s = bufferedReader.readLine())!=null) {
				String[] numbers = s.split(",");
				convertAndStore(numbers);
			}
			bufferedReader.close();
			long startTime = System.currentTimeMillis();
			long sum = 0;
			for(List<Integer> set:sets) {
				sum+=createSubsetsAndVerify(set);
			}
			long endTime = System.currentTimeMillis();
			System.out.println("Euler 105:");
			System.out.println("Sum:" + sum);
			System.out.println("Time Elapsed:" + (endTime - startTime) + " (ms)");
			
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}
}
