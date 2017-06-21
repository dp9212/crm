package cn.yysg.crm.query;

public class EmployeeQuery extends BaseQuery {
	private String id;
	//简单查询，接收前台传递的数据库字段
	private String dbSearcher;
	// 高级查询接收字段
	private String username;
	private String realName;
	private String tel;
	private String email;
	private Integer state;
	private Long departmentId;// 关联对象
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDbSearcher() {
		return dbSearcher;
	}

	public void setDbSearcher(String dbSearcher) {
		this.dbSearcher = dbSearcher;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

}
