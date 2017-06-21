package cn.yysg.crm.query;

import cn.yysg.crm.domain.Employee;

public class CustomerTransferQuery extends BaseQuery{
	
	


public CustomerTransferQuery() {
		super();
		// TODO Auto-generated constructor stub
	}

@Override
public void setSort(String sort) {
	if("customer".equals(sort)){
		this.sort="customer_id";
	}else if("transUser".equals(sort)){
		this.sort="transUser_id";
	}else if("oldSeller".equals(sort)){
	this.sort="oldSeller_id";
}
	super.setSort(this.sort);
}
}
	

