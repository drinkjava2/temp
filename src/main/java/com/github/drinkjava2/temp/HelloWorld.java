package com.github.drinkjava2.temp;

import static com.github.drinkjava2.jdbpro.JDBPRO.param;
import static com.github.drinkjava2.jdbpro.JDBPRO.ques;

import javax.sql.DataSource;

import org.h2.jdbcx.JdbcConnectionPool;

import com.github.drinkjava2.jdialects.annotation.jdia.UUID25;
import com.github.drinkjava2.jdialects.annotation.jpa.Id;
import com.github.drinkjava2.jsqlbox.ActiveEntity;
import com.github.drinkjava2.jsqlbox.DB;
import com.github.drinkjava2.jsqlbox.DbContext;

public class HelloWorld implements ActiveEntity<HelloWorld> {
	@Id
	@UUID25
	private String id;
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public HelloWorld setName(String name) {
		this.name = name;
		return this;
	}

	public static void main(String[] args) {
		DataSource ds = JdbcConnectionPool // 这个示例使用h2内存数据库
				.create("jdbc:h2:mem:DBNameJava8;MODE=MYSQL;DB_CLOSE_DELAY=-1;TRACE_LEVEL_SYSTEM_OUT=0", "sa", "");
		DbContext ctx = new DbContext(ds);
		ctx.setAllowShowSQL(true); // 开启SQL日志输出
		DbContext.setGlobalDbContext(ctx); // 设定全局上下文
		ctx.quiteExecute(ctx.toDropAndCreateDDL(HelloWorld.class));// 创建表格
		HelloWorld h = new HelloWorld().setName("Foo").insert().putField("name", "Hello jSqlBox").update();
		System.out.println(DB.iQueryForString("select name from HelloWorld where name like ?", param("H%"), " or name=",
				ques("1"), " or name =", ques("2")));
		h.delete();// 删除实体
		ctx.executeDDL(ctx.toDropDDL(HelloWorld.class));// 删除表格
	}
}
