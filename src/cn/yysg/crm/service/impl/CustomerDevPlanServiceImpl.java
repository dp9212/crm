package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.CustomerDevPlan;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.CustomerDevPlanMapper;
import cn.yysg.crm.service.ICustomerDevPlanService;
@Service
public class CustomerDevPlanServiceImpl extends BaseServiceImpl<CustomerDevPlan> implements ICustomerDevPlanService {
	@Autowired
	private CustomerDevPlanMapper customerDevPlanMapper;
	@Override
	protected BaseMapper<CustomerDevPlan> getMapper() {
		// TODO Auto-generated method stub
		return customerDevPlanMapper;
	}

}
