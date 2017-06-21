package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.ContractItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.ContractItemMapper;
import cn.yysg.crm.service.IContractItemService;

@Service
public class ContractItemServiceImpl extends BaseServiceImpl<ContractItem> implements IContractItemService {

	@Autowired
	private ContractItemMapper contractItemMapper;
	@Override
	protected BaseMapper<ContractItem> getMapper() {
		return contractItemMapper;
	}
	
}
