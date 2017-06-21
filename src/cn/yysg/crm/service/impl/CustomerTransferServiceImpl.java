package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.CustomerTransfer;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.CustomerTransferMapper;
import cn.yysg.crm.service.ICustomerTransferService;

@Service
public class CustomerTransferServiceImpl extends BaseServiceImpl< CustomerTransfer> implements ICustomerTransferService {

	@Autowired
	private  CustomerTransferMapper  customerTransferMapper;
	@Override
	protected BaseMapper<CustomerTransfer> getMapper() {
		return customerTransferMapper;
	}
	@Override
	public List<Employee> queryOld(Long id) {
		// TODO Auto-generated method stub
		return customerTransferMapper.queryOld(id);
	}

	
	
	
	
}
