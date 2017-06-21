package cn.yysg.crm.mapper;

import java.util.List;

import cn.yysg.crm.query.BaseQuery;

public interface BaseMapper<T> {

	void save(T t);
	void update(T t);
	void delete(Long id);
	T get(Long id);
	List<T> getAll();
	//分页 每页显示条数
	List<T> getRows(BaseQuery baseQuery);
	//分页 总条数
	int getTotal(BaseQuery baseQuery);

}
