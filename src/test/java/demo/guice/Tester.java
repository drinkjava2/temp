package demo.guice;

import java.util.Properties;

import javax.sql.DataSource;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Key;
import com.google.inject.matcher.Matchers;
import com.google.inject.name.Names;

/** Use jBeanBox + SpringTx do transaction */
public class Tester {
	static Injector injector;
	static {
		DataSourceTransactionManager dm = new DataSourceTransactionManager();
		Properties props = new Properties();
		props.put("insert*", "PROPAGATION_REQUIRED");
		TransactionInterceptor aop = new TransactionInterceptor(dm, props);
		injector = Guice.createInjector(new GuiceCfg(),
				binder -> binder.bindInterceptor(Matchers.subclassesOf(Tester.class), Matchers.any(), aop));
		dm.setDataSource(injector.getInstance(Key.get(DataSource.class, Names.named("H2"))));
	}

	private JdbcTemplate dao = new JdbcTemplate(injector.getInstance(Key.get(DataSource.class, Names.named("H2"))));

	public void insertUser() {
		dao.execute("insert into users (username) values ('User2')");
		Assert.assertEquals(2, (int) dao.queryForObject("select count(*) from users", Integer.class));
		System.out.println(1 / 0);
	}

	@Test
	public void doTest() {
		Tester tester = injector.getInstance(Tester.class);
		tester.dao.execute("drop table if exists users");
		tester.dao.execute("create table users(username varchar(30))");
		tester.dao.execute("insert into users (username) values ('User1')");
		try {
			tester.insertUser();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Assert.assertEquals(1, (int) dao.queryForObject("select count(*) from users", Integer.class));
	}

}