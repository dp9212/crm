package cn.yysg.crm.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CustomerTraceHistory {
	private Long id;
	private String remark;//跟进的细节，如：QQ聊天记录等
	private String title;
	private Integer traceResult;
	private Date traceTime;
	private  SystemDictionaryItem traceType;//邀约上门、电话、短信、邮件等
	private Customer customer;//跟进的哪一个客户
	private Employee traceUser;//跟进人
	public CustomerTraceHistory() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustomerTraceHistory(Long id, String remark, String title, Integer traceResult, Date traceTime,
			SystemDictionaryItem traceType, Customer customer, Employee traceUser) {
		super();
		this.id = id;
		this.remark = remark;
		this.title = title;
		this.traceResult = traceResult;
		this.traceTime = traceTime;
		this.traceType = traceType;
		this.customer = customer;
		this.traceUser = traceUser;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getTraceResult() {
		return traceResult;
	}
	public void setTraceResult(Integer traceResult) {
		this.traceResult = traceResult;
	}
	@JsonFormat(pattern="yyyy-MM-dd")
	public Date getTraceTime() {
		return traceTime;
	}
	public void setTraceTime(Date traceTime) {
		this.traceTime = traceTime;
	}
	public SystemDictionaryItem getTraceType() {
		return traceType;
	}
	public void setTraceType(SystemDictionaryItem traceType) {
		this.traceType = traceType;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getTraceUser() {
		return traceUser;
	}
	public void setTraceUser(Employee traceUser) {
		this.traceUser = traceUser;
	}
	@Override
	public String toString() {
		return "CustomerTraceHistory [id=" + id + ", remark=" + remark + ", title=" + title + ", traceResult="
				+ traceResult + ", traceTime=" + traceTime + "]";
	}
	

}
