
public class Euler504 {

	private int[][] internalPoints;

	private int countInternalPoints(int x, int y) {
		int count = 0;
		int y_intercept = y;
		int gradientNumerator = (-y);
		int gradientDenominator = (x);
		for (int xCoord = 1; xCoord <= x; ++xCoord) {
			for (int yCoord = 1; yCoord <= y; ++yCoord) {
				if (((yCoord - y_intercept) * gradientDenominator) < (gradientNumerator * xCoord)) {
					count += 1;
				}
			}
		}
		return count;
	}

	private void createTriangle(int length) {
		for (int x = 2; x <= length; ++x) {
			for (int y = x; y <= length; ++y) {
				internalPoints[x][y] = countInternalPoints(x, y);
			}
		}
	}

	private int getInternalTriangles(int x, int y) {
		if (x > y) {
			return getInternalTriangles(y, x);
		} else
			return internalPoints[x][y];
	}

	private boolean isPerfectSquare(int n) {
//		System.out.println(n);
		int sqrt = (int) Math.sqrt(n);
		return (sqrt * sqrt) == n;
	}

	/*
	 * Create Quadrilateral
	 */
	private int traverseQuadrilaterals(int n) {
		int count = 0;
		// cycle through each side
		for (int i = 1; i <= n; ++i) {
			for (int j = 1; j <= n; ++j) {
				int currentCount = getInternalTriangles(i, j); // first triangle count
				for (int k = 1; k <= n; ++k) {
					currentCount += getInternalTriangles(j, k); // second triangle count
					for (int l = 1; l <= n; ++l) {
						// count for third and fourth triangle
						currentCount += getInternalTriangles(k, l);
						currentCount += getInternalTriangles(l, i);
						int latticePoints = currentCount + i + j + k + l + 1 - 4;
						if (isPerfectSquare(latticePoints)) {
							count += 1;
						}
						currentCount -= getInternalTriangles(k, l);
						currentCount -= getInternalTriangles(l, i);
					}
					currentCount -= getInternalTriangles(j, k);
				}
			}
		}
		return count;
	}

	private void solve() {
		int n = 100;
		long startTime = System.currentTimeMillis();
		// created for memoization
		internalPoints = new int[n + 1][];
		for (int i = 0; i <= n; ++i) {
			internalPoints[i] = new int[n + 1];
		}
		// count internal points for triangles
		createTriangle(n);

		System.out.println("Euler 504 - Square on the Inside");
		System.out.println(traverseQuadrilaterals(n));
		long endTime = System.currentTimeMillis();
		System.out.println("Time elapsed: " + (endTime - startTime) + "(ms)");
	}

	public static void main(String[] args) {
		new Euler504().solve();
	}
}
