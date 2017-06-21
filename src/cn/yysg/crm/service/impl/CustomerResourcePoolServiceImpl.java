package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.CustomerResourcePool;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.CustomerResourcePoolMapper;
import cn.yysg.crm.service.ICustomerResourcePoolService;

@Service
public class CustomerResourcePoolServiceImpl extends BaseServiceImpl<CustomerResourcePool> implements ICustomerResourcePoolService {

	@Autowired
	private CustomerResourcePoolMapper customerResourcePoolMapper;
	@Override
	protected BaseMapper<CustomerResourcePool> getMapper() {
		return customerResourcePoolMapper;
	}
	@Override
	public List<SystemDictionaryItem> queryItemsById(Long id) {
		// TODO Auto-generated method stub
		return customerResourcePoolMapper.queryItemsById(id);
	}
	@Override
	public Long getCount() {
		// TODO Auto-generated method stub
		return customerResourcePoolMapper.getCount();
	}
	
	
}
