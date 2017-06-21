package cn.yysg.crm.domain;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ContractItem {
	private Long id;
	private Contract contract;	//所属合同
	private Date payTime = new Date();		//支付时间
	private BigDecimal money;	//支付金额
	private Boolean isPayment;	//是否支付
	private BigDecimal scal;	//所占比例
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public Contract getContract() {
		return contract;
	}
	public void setContract(Contract contract) {
		this.contract = contract;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getPayTime() {
		return payTime;
	}
	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	public Boolean getIsPayment() {
		return isPayment;
	}
	public void setIsPayment(Boolean isPayment) {
		this.isPayment = isPayment;
	}
	public BigDecimal getScal() {
		return scal;
	}
	public void setScal(BigDecimal scal) {
		this.scal = scal;
	}
	@Override
	public String toString() {
		return "ContractItem [id=" + id + ", payTime=" + payTime + ", money=" + money + ", isPayment=" + isPayment
				+ ", scal=" + scal + "]";
	}
	
}
