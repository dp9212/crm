package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.CustomerTransfer;
import cn.yysg.crm.domain.Employee;

public interface ICustomerTransferService extends IBaseService<CustomerTransfer>{
	 List<Employee> queryOld(Long id);
}
