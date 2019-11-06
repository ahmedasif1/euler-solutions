import java.util.concurrent.TimeUnit;

public class Euler150 {

	static final int NUMBERS_TO_GENERATE = 500500;
	static final int TRIANGLE_SIZE =1000;
	static final int OLD_SUM = 1;
	static final int ORG_NUM = 0;
	static final int SUM = 2;
	static final int MAX_TRIANGLE_SIZE = 1000;

	//3 indexes for keeping old sum, sum and actual number
	long[][][] triangleMatrix = new long[TRIANGLE_SIZE][TRIANGLE_SIZE][3];
	/**
	 * Generate numbers into 3d matrix.
	 */
	void generateNumbers() {

		int numberInRow = 0;
		int rowSize = 1;
		final long twoPow19 = (long) Math.pow(2, 19);
		final long twoPow20 = (long) Math.pow(2, 20);
		long t = 0;
		for (int k = 1; k <= NUMBERS_TO_GENERATE; ++k) {
			t = (615949 * t + 797807) % twoPow20;

			long num = t - twoPow19;

			triangleMatrix[rowSize - 1][numberInRow][ORG_NUM] = num;
			triangleMatrix[rowSize - 1][numberInRow][OLD_SUM] = num;
			triangleMatrix[rowSize - 1][numberInRow][SUM] = num;

			numberInRow++;

			if (numberInRow == rowSize) {
				rowSize++;
				numberInRow = 0;
			}
		}
	}

	long calculateMinimumSum() {
		long minimumSum = Long.MAX_VALUE;
		//increase size in loop
		for (int triangleSize = 2; triangleSize < MAX_TRIANGLE_SIZE; ++triangleSize) {
			//move from top to the bottom row
			for (int triangleStartRow = 0; triangleStartRow <= MAX_TRIANGLE_SIZE - triangleSize
					+ 1; ++triangleStartRow) {

				// if sum was calculated in last iteration but cannot be calculated now due to absence of more rows at the bottom, then
				// copy sum in old sum
				if (triangleStartRow == MAX_TRIANGLE_SIZE - triangleSize + 1) {
					for (int triangleIndex = 0; triangleIndex < triangleStartRow + 1; ++triangleIndex) {
						triangleMatrix[triangleStartRow][triangleIndex][OLD_SUM] = triangleMatrix[triangleStartRow][triangleIndex][SUM];
					}

				} else {
					for (int triangleIndexInRow = 0; triangleIndexInRow < triangleStartRow + 1; ++triangleIndexInRow) {
						int requiredSize = triangleSize - 1;

						long sum = triangleMatrix[triangleStartRow][triangleIndexInRow][ORG_NUM];

						sum += (triangleMatrix[triangleStartRow + 1][triangleIndexInRow][SUM]
								+ triangleMatrix[triangleStartRow + 1][triangleIndexInRow + 1][SUM]);

						// remove the common part from the 2 sub triangles
						if (requiredSize > 1) {
							sum -= triangleMatrix[triangleStartRow + 2][triangleIndexInRow + 1][OLD_SUM];
						}

						triangleMatrix[triangleStartRow][triangleIndexInRow][OLD_SUM] = triangleMatrix[triangleStartRow][triangleIndexInRow][SUM];
						triangleMatrix[triangleStartRow][triangleIndexInRow][SUM] = sum;

						if (sum < minimumSum) {
							minimumSum = sum;
						}
					}
				}
			}
		}
		return minimumSum;
	}

	public static void main(String[] args) {
		System.out.println("Euler 150 :");
		long start = System.nanoTime();
		Euler150 euler150 = new Euler150();
		euler150.generateNumbers();

		System.out.println("Minimum Sum: " + euler150.calculateMinimumSum());

		long end = System.nanoTime();
		System.out.println("Elapsed Time (ms): " + TimeUnit.NANOSECONDS.toMillis(end - start));
	}
}
