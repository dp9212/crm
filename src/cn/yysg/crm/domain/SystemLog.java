package cn.yysg.crm.domain;

import java.util.Date;

public class SystemLog {
	private Long id;
	private Employee opUser;
	private Date opTime;
	private String opIp;
	private String function;//员工保存操作信息
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Employee getOpUser() {
		return opUser;
	}
	public void setOpUser(Employee opUser) {
		this.opUser = opUser;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getOpIp() {
		return opIp;
	}
	public void setOpIp(String opIp) {
		this.opIp = opIp;
	}
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	
}
