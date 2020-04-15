package demo;

import static com.github.drinkjava2.jdbpro.JDBPRO.noNull;
import static com.github.drinkjava2.jdbpro.JDBPRO.param;
import static com.github.drinkjava2.jdbpro.JDBPRO.ques;

import javax.sql.DataSource;

import org.h2.jdbcx.JdbcConnectionPool;

import com.github.drinkjava2.jdialects.annotation.jdia.UUID25;
import com.github.drinkjava2.jdialects.annotation.jpa.Id;
import com.github.drinkjava2.jsqlbox.ActiveEntity;
import com.github.drinkjava2.jsqlbox.DB;
import com.github.drinkjava2.jsqlbox.DbContext;

public class Demo implements ActiveEntity<Demo> {
	@Id
	@UUID25
	private String id;

	private String name;

	public String getId() {
		return id;
	}

	public Demo setId(String id) {
		this.id = id;
		return this;
	}

	public String getName() {
		return name;
	}

	public Demo setName(String name) {
		this.name = name;
		return this;
	}

	public static void main(String[] args) {
		DataSource ds = JdbcConnectionPool // 这个示例使用h2内存数据库
				.create("jdbc:h2:mem:DBNameJava8;MODE=MYSQL;DB_CLOSE_DELAY=-1;TRACE_LEVEL_SYSTEM_OUT=0", "sa", "");
		DbContext ctx = new DbContext(ds);
		ctx.setAllowShowSQL(true); // 开启SQL日志输出
		DbContext.setGlobalDbContext(ctx); // 设定全局DbContext
		ctx.quiteExecute(ctx.toDropAndCreateDDL(Demo.class)); // 从实体创建DDL，创建表格
		Demo h = new Demo().setName("Foo").insert().putField("name", "张三").update(" and name<>", ques("李四"));
		System.out.println(DB.iQueryForString("select name from demo where name=?", param("李四"),
				noNull(" or name like ?", "%", "张", "%"), " or name=?", param("赵五")));
		h.delete(); // 删除实体
		ctx.executeDDL(ctx.toDropDDL(Demo.class)); // 删除表格
	}
}