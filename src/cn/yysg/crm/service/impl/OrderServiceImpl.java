package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Order;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.OrderMapper;
import cn.yysg.crm.service.IOrderService;

@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements IOrderService{

	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	protected BaseMapper<Order> getMapper() {
		return null;
	}



}
