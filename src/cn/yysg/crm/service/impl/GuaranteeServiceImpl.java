package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Guarantee;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.GuaranteeMapper;
import cn.yysg.crm.query.GuaranteeQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IGuaranteeService;

@Service
public  class GuaranteeServiceImpl extends BaseServiceImpl<Guarantee> implements IGuaranteeService {

	@Autowired
	private GuaranteeMapper guaranteeMapper;
	
	@Override
	protected BaseMapper<Guarantee> getMapper() {
		// TODO Auto-generated method stub
		return guaranteeMapper;
	}

	@Override
	public void deleteByContractId(Long id) {
		// TODO Auto-generated method stub
		guaranteeMapper.deleteByContractId(id);
	}

	@Override
	public Long getGuaranteeIdByContract(Long id) {
		// TODO Auto-generated method stub
		return guaranteeMapper.getGuaranteeIdByContract(id);
	}

	


}
