package cn.yysg.crm.query;

import java.util.Date;

public class GuaranteeQuery extends BaseQuery{

	private Date beginDate; //查询起始时间
	
	private Date endDate; //查询结束时间
	
	private String q;
	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
}
