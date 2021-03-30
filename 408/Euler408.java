import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

public class Euler408 {
	static int LIMIT = 10000000;
	static int MODULUS = 1000000007;
	SortedSet<Integer> squares = new TreeSet<>();
	List<Integer> factorials = new ArrayList<Integer>();
	int previousFactMax = 0;
	List<Point> inadmissiblePoints = new ArrayList<>();
	HashMap<Integer, Integer> inverseCache = new HashMap<>();
	int counter = 0;
	Point zeroZero = new Point(0, 0);

	class Point {
		int x, y;
		Point mirror;
		Integer admissiblePathsCount = null;

		Point(int x, int y) {
			this.x = x;
			this.y = y;
		}

		@Override
		public boolean equals(Object p) {
			if (p == null || !(p instanceof Point)) {
				return false;
			}

			return this.x == ((Point) p).x && this.y == ((Point) p).y;
		}

	}

	private void generateSquares(long limit) {
		int num = 1;
		while (true) {
			int square = num * num;
			if (square > limit) {
				break;
			}
			squares.add(square);
			num += 1;
		}
	}

	private void generateFactorialCache(Integer limit) {
		if (factorials.size() == 0) {
			factorials.add(1);
		}
		for (long i = this.previousFactMax + 1; i <= limit; ++i) {
			factorials.add(multiplyMod(factorials.get((int) (i - 1)), i).intValue());
		}
		previousFactMax = limit.intValue();
	}
	private static long modulus(long value, long n) {
		if (value % n < 0) {
			return (value % n) + n; 
		}
		return value % n;
	}
	private Long extendedGcd(long a, long n) {
		long t = 1;
		long r = a;
		long old_t = 0;
		long old_r = n;
		while (true) {
			if (r == 0) {
				break;
			}
			long q = old_r / r;
			long temp = r;
			r = old_r - q * r;
			old_r = temp;
			temp = t;
			t = old_t - q * t;
			old_t = temp;
		}
		if (old_r > 1) {
			return null;
		}
		return modulus(old_t, n);
	}

	private Long multiplicativeInverse(long a) {
		return extendedGcd(a, MODULUS);
	}

	private Long multiplyMod(long num1, long num2) {
		return modulus(num1 * num2, MODULUS);
	}

	private Long minusMod(long num1, long num2) {
		return modulus(num1 - num2, MODULUS);
	}

	private int factMod(int num) {
		if (factorials.size() <= num) {
			generateFactorialCache(num);
		}
		return factorials.get(num);
	}

	private int find_all_paths_from_source_to_destination(Point sourcePoint, Point destPoint) {
		int deltaX = destPoint.x - sourcePoint.x;
		int deltaY = destPoint.y - sourcePoint.y;
		int denominator = multiplyMod(factMod(deltaX), factMod(deltaY)).intValue();
		int numerator = factMod(deltaX + deltaY);
		Integer inverse = null;

		if (inverseCache.containsKey(denominator)) {
			inverse = inverseCache.get(denominator);
		} else {
			inverse = multiplicativeInverse(denominator).intValue();
			inverseCache.put(denominator, inverse);
		}
		
		return multiplyMod(numerator, inverse).intValue();

	}

	private int find_all_admissible_paths_though_this_point(Point point, Point destination) {
		int count = 0;
		Point pointX = point;
		if (point.mirror != null) {
			pointX = point.mirror;
		}
		if (pointX.admissiblePathsCount == null) {
			count = find_admissible_paths_till_destination(pointX);
		} else {
			count = pointX.admissiblePathsCount;
		}
		int between = find_all_paths_from_source_to_destination(point, destination);

		return multiplyMod(between, count).intValue();
	}

	private int find_admissible_paths_till_destination(Point destination) {
		int result = -1;
		if (destination.admissiblePathsCount != null) {
			result = destination.admissiblePathsCount;
		} else {
			int total_paths_till_destination = find_all_paths_from_source_to_destination(zeroZero, destination);
			long in_admissible_paths = 0;
			for (Point inadmissible : inadmissiblePoints) {
				if (destination.equals(inadmissible) || (destination.x < inadmissible.x)
						|| (destination.y < inadmissible.y)) {
					if (destination.x < inadmissible.x) {
						break;
					}
				} else {

					in_admissible_paths += find_all_admissible_paths_though_this_point(inadmissible, destination);
				}
			}
			result = minusMod(total_paths_till_destination, in_admissible_paths).intValue();
			destination.admissiblePathsCount = result;
		}

		return result;
	}

	private void generateCache() {
		generateSquares(LIMIT * 2);
		System.out.println("Squares generated");
		generateFactorialCache(LIMIT * 2 + 1);
		System.out.println("Factorials cache generated");

		Object[] squaresArray = squares.toArray();
		Arrays.sort(squaresArray);
		for (int i = 0; i < squaresArray.length; ++i) {
			if ((int) squaresArray[i] > LIMIT) {
				break;
			}
			for (int j = i; j < squaresArray.length; ++j) {
				if ((int) squaresArray[j] > LIMIT) {
					break;
				}
				int x = (int) squaresArray[i];
				int y = (int) squaresArray[j];
				int sum = x + y;
				if (squares.contains(sum)) {
					Point point = new Point(x, y);
					Point mirror = new Point(y, x);
					point.mirror = mirror;
					inadmissiblePoints.add(point);
					inadmissiblePoints.add(mirror);
				}
			}
		}
		Collections.sort(inadmissiblePoints, new Comparator<Point>() {

			@Override
			public int compare(Point arg0, Point arg1) {
				return arg0.x - arg1.x;
			}
		});
		System.out.println("Inadmissible points: " + inadmissiblePoints.size());
	}

	private void solve() {
		Point destination = new Point(LIMIT, LIMIT);
		
		System.out.println(find_admissible_paths_till_destination(destination));
	}

	public static void main(String[] args) {
		System.out.println("Starting Euler 408: Admissible paths through a grid");
		Euler408 instance = new Euler408();
		long startTime = System.nanoTime();
		instance.generateCache();
		long endTime = System.nanoTime();
		long duration = (endTime - startTime) / 1000000; // divide by 1000000 to get milliseconds.
		System.out.println("Cache generation time: " + duration + " ms");
		instance.solve();
		endTime = System.nanoTime();
		duration = (endTime - startTime) / 1000000;
		System.out.println("Total time taken: " + duration + " (ms)");
	}
}
