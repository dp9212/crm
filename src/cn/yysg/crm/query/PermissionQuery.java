package cn.yysg.crm.query;


public class PermissionQuery extends BaseQuery{
	private Long roleId;
	private Integer state;
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	
}
