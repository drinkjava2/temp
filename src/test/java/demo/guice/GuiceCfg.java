package demo.guice;

import javax.sql.DataSource;

import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.google.inject.Singleton;
import com.google.inject.name.Named;
import com.zaxxer.hikari.HikariDataSource;

public class GuiceCfg extends AbstractModule {
	@Provides
	@Singleton
	@Named("H2")
	DataSource H2DataSourceCfg() {
		HikariDataSource ds = hikariCPCfg();
		ds.setJdbcUrl("jdbc:h2:mem:DB2;MODE=MYSQL;DB_CLOSE_DELAY=-1;TRACE_LEVEL_SYSTEM_OUT=0");
		ds.setDriverClassName("org.h2.Driver");
		ds.setUsername("sa");
		ds.setPassword("");
		return ds;
	}

	@Provides
	@Singleton
	@Named("MySql")
	DataSource MySqlDataSourceCfg() {
		HikariDataSource ds = hikariCPCfg();
		ds.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/mysqltest?rewriteBatchedStatements=true&useSSL=false");
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUsername("root");
		ds.setPassword("yourpwd");
		return ds;
	}

	@Provides
	@Singleton
	HikariDataSource hikariCPCfg() {
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
