package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.GuaranteeItem;

public interface IGuaranteeItemService extends IBaseService<GuaranteeItem> {

	//根据明细所属的保修单来查询 
	List<GuaranteeItem> getGuaranteeItemById(Long id);
	
	//根据保修单id来删除下面的明细
	void deleteGuaranteeItemByGuaranteeId(Long id);
}
