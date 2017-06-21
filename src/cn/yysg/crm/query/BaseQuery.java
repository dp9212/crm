package cn.yysg.crm.query;

/**
 * 查询分页对象
 * 
 * @author admin
 *
 */
public class BaseQuery {

	

	private Integer page = 1; // 当前页
	private Integer rows = 10; // 分页大小
	private String keyWord;// 搜索关键字
	protected String order = "asc";
	protected String sort = "o.id";


	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public BaseQuery() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	// 起始页
	public int getBegin() {
		return (page - 1) * rows;
	}

	// 尾页
	public int getEnd() {
		return rows;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	@Override
	public String toString() {
		return "BaseQuery [page=" + page + ", rows=" + rows + ", keyWord=" + keyWord + ", order=" + order + ", sort="
				+ sort + "]";
	}

	
}