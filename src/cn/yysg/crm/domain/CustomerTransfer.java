package cn.yysg.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CustomerTransfer {
	private Long id;
	private String transReason;
	private Date transTime;
	private Customer customer;
	private Employee transUser;
	private Employee oldSeller;
	private Employee newSeller;
	public CustomerTransfer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTransReason() {
		return transReason;
	}
	public void setTransReason(String transReason) {
		this.transReason = transReason;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date getTransTime() {
		return transTime;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public void setTransTime(Date transTime) {
		this.transTime = transTime;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	 
	
	public Employee getTransUser() {
		return transUser;
	}
 


	public void setTransUser(Employee transUser) {
		this.transUser = transUser;
	}



	public Employee getOldSeller() {
		return oldSeller;
	}
	public void setOldSeller(Employee oldSeller) {
		this.oldSeller = oldSeller;
	}
	public Employee getNewSeller() {
		return newSeller;
	}
	public void setNewSeller(Employee newSeller) {
		this.newSeller = newSeller;
	}



	public CustomerTransfer(Long id, String transReason, Date transTime, Customer customer, Employee transUser,
			Employee oldSeller, Employee newSeller) {
		super();
		this.id = id;
		this.transReason = transReason;
		this.transTime = transTime;
		this.customer = customer;
		this.transUser = transUser;
		this.oldSeller = oldSeller;
		this.newSeller = newSeller;
	}



	@Override
	public String toString() {
		return "CustomerTransfer [id=" + id + ", transReason=" + transReason + ", transTime=" + transTime
				+ ", customer=" + customer + ", transUser=" + transUser + ", oldSeller=" + oldSeller + ", newSeller="
				+ newSeller + "]";
	}

	
	
	

}
