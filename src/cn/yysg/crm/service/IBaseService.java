package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.query.BaseQuery;
import cn.yysg.crm.query.PageList;

/**
 * 通用服务接口
 * @author admin
 *
 * @param <T>
 */
public interface IBaseService<T> {
	void save(T t);

	void update(T t);

	void delete(Long id);

	T get(Long id);

	List<T> getAll();
	//分页
	PageList<T> getPageList(BaseQuery baseQuery);
	List<T> getRows(BaseQuery baseQuery);
	int getTotal(BaseQuery baseQuery);
}

