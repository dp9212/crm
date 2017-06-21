package cn.yysg.crm.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 替在客户实类
 * @author DELL_
 *
 */
public class PotentialCustomer {
	private Long id;//ID
	private String name;
	//客户来源
	private String customerSource;
	//successRate客户发发的潜在可能？%
	private int successRate;
	//对客户的简要描述
	private String remark;
	//linkMan客户方联人
	private String linkMan;
	//联系电话
	private String  linkManTel;
	//inputUser创建 人
	private String inputUser;
	//inputTime创建时间
	private Date inputTime;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCustomerSource() {
		return customerSource;
	}
	public void setCustomerSource(String customerSource) {
		this.customerSource = customerSource;
	}
	public int getSuccessRate() {
		return successRate;
	}
	public void setSuccessRate(int successRate) {
		this.successRate = successRate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkManTel() {
		return linkManTel;
	}
	public void setLinkManTel(String linkManTel) {
		this.linkManTel = linkManTel;
	}
	public String getInputUser() {
		return inputUser;
	}
	public void setInputUser(String inputUser) {
		this.inputUser = inputUser;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getInputTime() {
		return inputTime;
	}
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}
	@Override
	public String toString() {
		return "PotentialCustomer [id=" + id + ", name=" + name + ", customerSource=" + customerSource
				+ ", successRate=" + successRate + ", remark=" + remark + ", linkMan=" + linkMan + ", linkManTel="
				+ linkManTel + ", inputUser=" + inputUser + ", inputTime=" + inputTime + "]";
	}
	
	
}
