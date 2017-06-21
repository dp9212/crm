package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.PotentialCustomer;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.PotentialCustomerMapper;
import cn.yysg.crm.service.IPotentialCustomerService;

@Service
public class PotentialCustomerServiceImpl extends BaseServiceImpl<PotentialCustomer> implements IPotentialCustomerService {
	@Autowired
	private PotentialCustomerMapper potentialCustomerMapper;
	@Override
	protected BaseMapper<PotentialCustomer> getMapper() {
		// TODO Auto-generated method stub
		return potentialCustomerMapper;
	}


	
	
}
