package cn.yysg.crm.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 客户开发计划实体类
 * @author DELL_
 *
 */
public class CustomerDevPlan {
	private Long id;
	//计划时间
	private Date planTime;
	//计划主题
	private String planSubject;
	//planDetails计划内容
	private String planDetails;
	//计划实施方式	planType
	private String planType;
	//potentialCustomer潜在客户
	private String potentialCustomer;
	//创建人	inputUser
	private String inputUser;
	//创建时间	inputTime
	private Date inputTime;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getPlanTime() {
		return planTime;
	}
	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}
	public String getPlanSubject() {
		return planSubject;
	}
	public void setPlanSubject(String planSubject) {
		this.planSubject = planSubject;
	}
	
	
	public String getPlanDetails() {
		return planDetails;
	}
	public void setPlanDetails(String planDetails) {
		this.planDetails = planDetails;
	}
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	public String getPotentialCustomer() {
		return potentialCustomer;
	}
	public void setPotentialCustomer(String potentialCustomer) {
		this.potentialCustomer = potentialCustomer;
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
		return "CustomerDevPlan [id=" + id + ", planTime=" + planTime + ", planSubject=" + planSubject
				+ ", planDetails=" + planDetails + ", planType=" + planType + ", potentialCustomer=" + potentialCustomer
				+ ", inputUser=" + inputUser + ", inputTime=" + inputTime + "]";
	}
	
}
