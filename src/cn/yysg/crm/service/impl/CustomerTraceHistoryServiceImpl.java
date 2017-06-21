package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.CustomerTraceHistory;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.CustomerMapper;
import cn.yysg.crm.mapper.CustomerTraceHistoryMapper;
import cn.yysg.crm.service.ICustomerTraceHistoryService;

@Service
public class CustomerTraceHistoryServiceImpl extends BaseServiceImpl<CustomerTraceHistory> implements ICustomerTraceHistoryService {

	@Autowired
	private CustomerTraceHistoryMapper customerTraceHistoryMapper;
	@Override
	protected BaseMapper<CustomerTraceHistory> getMapper() {
		return customerTraceHistoryMapper;
	}
	@Override
	public List<SystemDictionaryItem> queryItemsById(Long id) {
		// TODO Auto-generated method stub
		return customerTraceHistoryMapper.queryItemsById(id);
	}
	@Override
	public void deleteByCustomerId(Long id) {
		customerTraceHistoryMapper.delete(id);
		
	}
	

}
