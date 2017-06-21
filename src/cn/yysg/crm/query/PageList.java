package cn.yysg.crm.query;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 封装EasyUi表格分页结果
 * @param <T>
 * 
 */
public class PageList<T> {
	private Integer total; //记录总数
	private List<T> rows = new ArrayList<T>(); //本页的数据记录
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	
}