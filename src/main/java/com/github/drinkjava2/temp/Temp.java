package com.github.drinkjava2.temp;

import com.github.drinkjava2.jdialects.Dialect;

public class Temp {
	public static void main(String[] args) {
		String s = Dialect.OracleDialect.getDdlFeatures().getDropTableString();
		System.out.println(s);
	}
}
