package cn.yysg.crm.service;


import cn.yysg.crm.domain.Guarantee;
import cn.yysg.crm.query.GuaranteeQuery;
import cn.yysg.crm.query.PageList;

public interface IGuaranteeService extends IBaseService<Guarantee> {

	//根据合同id来删除保修单
	void deleteByContractId(Long id);
	
	//通过合同单号来查询出该合同的明细
	Long getGuaranteeIdByContract(Long id);

	
	
}
