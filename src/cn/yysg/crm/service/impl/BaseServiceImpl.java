package cn.yysg.crm.service.impl;

import java.util.List;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.query.BaseQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IBaseService;

public abstract class BaseServiceImpl<T> implements IBaseService<T> {
	protected abstract BaseMapper<T> getMapper();
	@Override
	public void save(T t) {
		getMapper().save(t);
	}

	@Override
	public void update(T t) {
		getMapper().update(t);
	}

	@Override
	public void delete(Long id) {
		getMapper().delete(id);
	}

	@Override
	public T get(Long id) {
		return getMapper().get(id);
	}

	@Override
	public List<T> getAll() {
		return getMapper().getAll();
	}
	//分页对象(条数和数据)
	@Override
	public PageList<T> getPageList(BaseQuery baseQuery) {
		int totals = getMapper().getTotal(baseQuery);
		List<T> rows = getMapper().getRows(baseQuery);
		PageList<T> pageList = new PageList<T>();
		pageList.setRows(rows);
		pageList.setTotal(totals);
		return pageList;
	}

	public List<T> getRows(BaseQuery baseQuery){
		return getMapper().getRows(baseQuery);
	}
	public int getTotal(BaseQuery baseQuery){
		return getMapper().getTotal(baseQuery);
	}

}
