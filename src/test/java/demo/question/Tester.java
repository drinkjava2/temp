package demo.question;

import org.junit.Assert;
import org.junit.Test;

import com.github.drinkjava2.jbeanbox.BeanBox;
import com.github.drinkjava2.jbeanbox.JBEANBOX;

public class Tester {
	public static String color = "red"; // read from file
	public static Class<?> car = Car1.class; // read from file

	public static abstract class Car {
		public String color;
	}

	public static class Car1 extends Car {
		public Car1(String color) {
			this.color = color;
		}
	}

	public static class Car2 extends Car {
		public Car2(String color) {
			this.color = color;
		}
	}

	public static class CarConfig extends BeanBox {
		{
			this.injectConstruct(car, String.class, color);
		}
	}

	@Test
	public void text() {
		Car car = JBEANBOX.getBean(CarConfig.class);
		Assert.assertEquals("red", car.color);
	}
}