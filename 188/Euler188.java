package com.euler;

import java.math.BigInteger;

public class Euler188 {
	public static void main(String[] args) {
		//mod pow converges
		BigInteger a = new BigInteger("1777");
		BigInteger b = new BigInteger("1777");
		BigInteger m = new BigInteger("100000000");
		for (int i = 0; i < 1884; ++i) {
			BigInteger value = a.modPow(b, m);
			System.out.println(b);
			if(value.equals(b)) {
				break;
			}
			b = value;
		}
	}
}
