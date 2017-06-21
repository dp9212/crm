package cn.yysg.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 保修单明细
 * @author Administrator
 *
 */
public class GuaranteeItem {
	
	/**id主键*/
	private Long id;
	
	/**保修时间 非空*/
	private Date guaranteeTime;
	
	/**保修内容 非空*/
	private String guaranteeContent;
	
	/**是否解决*/
	private Boolean isSolve;
	
	/**该保修单明细所对应的保修单*/
	private Guarantee guarantee;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getGuaranteeTime() {
		return guaranteeTime;
	}

	@DateTimeFormat(pattern="yyyy-MM-dd")
	public void setGuaranteeTime(Date guaranteeTime) {
		this.guaranteeTime = guaranteeTime;
	}

	public String getGuaranteeContent() {
		return guaranteeContent;
	}

	public void setGuaranteeContent(String guaranteeContent) {
		this.guaranteeContent = guaranteeContent;
	}

	public Boolean getIsSolve() {
		return isSolve;
	}

	public void setIsSolve(Boolean isSolve) {
		this.isSolve = isSolve;
	}

	public Guarantee getGuarantee() {
		return guarantee;
	}

	public void setGuarantee(Guarantee guarantee) {
		this.guarantee = guarantee;
	}
	
}
