package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Contract;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.ContractMapper;
import cn.yysg.crm.service.IContractService;

@Service
public class ContractServiceImpl extends BaseServiceImpl<Contract> implements IContractService {

	@Autowired
	private ContractMapper contractMapper;
	@Override
	protected BaseMapper<Contract> getMapper() {
		return contractMapper;
	}
}
	

