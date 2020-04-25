package demo;

import com.github.drinkjava2.jbeanbox.BeanBox;
import com.zaxxer.hikari.HikariDataSource;

public class DataSourceConfig {

	// Default DataSource
	public static class DataSource extends H2DataSourceCfg {

	}

	// H2
	public static class H2DataSourceCfg extends MySqlDataSourceBox {
		{
			injectValue("jdbcUrl", "jdbc:h2:mem:DB1;MODE=MYSQL;DB_CLOSE_DELAY=-1;TRACE_LEVEL_SYSTEM_OUT=0");
			injectValue("driverClassName", "org.h2.Driver");
		}
	}

	// MySql
	public static class MySqlDataSourceBox extends HikariCPCfg {
		public void config(HikariDataSource ds) {
			ds.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/mysqltest?rewriteBatchedStatements=true&useSSL=false");
			ds.setDriverClassName("com.mysql.jdbc.Driver");
			ds.setUsername("root");
			ds.setPassword("yourpwd");
		}
	}

	// HikariCP is a DataSource pool
	public static class HikariCPCfg extends BeanBox {
		public HikariDataSource create() {
			HikariDataSource ds = new HikariDataSource();
			ds.addDataSourceProperty("cachePrepStmts", true);
			ds.addDataSourceProperty("prepStmtCacheSize", 250);
			ds.addDataSourceProperty("prepStmtCacheSqlLimit", 2048);
			ds.addDataSourceProperty("useServerPrepStmts", true);
			ds.setMaximumPoolSize(3);
			ds.setConnectionTimeout(5000);
			return ds;
		}
	}

}
