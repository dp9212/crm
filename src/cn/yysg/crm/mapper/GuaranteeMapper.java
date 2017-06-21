package cn.yysg.crm.mapper;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.Guarantee;

public interface GuaranteeMapper extends BaseMapper<Guarantee> {
	
	//根据合同id来删除保修单
	@Select("delete from t_guarantee where contract_id = #{id};")
	void deleteByContractId(Long id);
	
	//通过合同单号来查询出该合同的明细
	Long getGuaranteeIdByContract(Long id);
	
	
}
