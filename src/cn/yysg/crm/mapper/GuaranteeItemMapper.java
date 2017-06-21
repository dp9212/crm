package cn.yysg.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.GuaranteeItem;

public interface GuaranteeItemMapper extends BaseMapper<GuaranteeItem> {
	
	//根据明细所属的保修单来查询 
	List<GuaranteeItem> getGuaranteeItemById(Long id);
	
	//根据保修单id来删除下面的明细
	@Select("delete from t_guarantee_item where guarantee_id=#{id}")
	void deleteGuaranteeItemByGuaranteeId(Long id);
}
