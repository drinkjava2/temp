package demo.jbeanbox;

import java.util.Properties;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import com.github.drinkjava2.jbeanbox.JBEANBOX;

import demo.jbeanbox.DataSourceConfig.H2DataSourceCfg;

/** Use jBeanBox + SpringTx do transaction */
public class Tester {
	static {
		DataSourceTransactionManager dm = new DataSourceTransactionManager();
		dm.setDataSource(JBEANBOX.getBean(H2DataSourceCfg.class));
		Properties props = new Properties();
		props.put("insert*", "PROPAGATION_REQUIRED");
		TransactionInterceptor aop = new TransactionInterceptor(dm, props);
		JBEANBOX.ctx().addContextAop(aop, "demo.jbeanbox.*", "insert*");
	}

	private JdbcTemplate dao = new JdbcTemplate(JBEANBOX.getBean(H2DataSourceCfg.class));

	public void insertUser() {
		dao.execute("insert into users (username) values ('User2')");
		Assert.assertEquals(2, (int) dao.queryForObject("select count(*) from users", Integer.class));
		System.out.println(1 / 0);
	}

	@Test
	public void doTest() {
		Tester tester = JBEANBOX.getBean(Tester.class);
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