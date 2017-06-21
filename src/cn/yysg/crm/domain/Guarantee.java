package cn.yysg.crm.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 保修单
 * @author Administrator
 *
 */
public class Guarantee {
	
	/**主键*/
	private Long id;
	
	/**保修单号*/
	private String sn;
	
	/**保修客户customer_id  非空*/
	private Customer customer;
	
	/**质保到期时间*/
	private Date guaranteeTime;
	
	/**保修单所属合同 contract_id*/
	private Contract contract;
	
	/**一个保修单里有多个保修单明细*/
	private List<GuaranteeItem> items = new ArrayList<GuaranteeItem>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getGuaranteeTime() {
		return guaranteeTime;
	}

	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setGuaranteeTime(Date guaranteeTime) {
		this.guaranteeTime = guaranteeTime;
	}
	
	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public List<GuaranteeItem> getItems() {
		return items;
	}

	public void setItems(List<GuaranteeItem> items) {
		this.items = items;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Override
	public String toString() {
		return "Guarantee [id=" + id + ", sn=" + sn + ", guaranteeTime=" + guaranteeTime + "]";
	}
	
}
