package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.GuaranteeItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.GuaranteeItemMapper;
import cn.yysg.crm.service.IGuaranteeItemService;

@Service
public class GuaranteeItemServiceImpl extends BaseServiceImpl<GuaranteeItem> implements IGuaranteeItemService {

	@Autowired
	private GuaranteeItemMapper guaranteeItemMapper;
	
	@Override
	protected BaseMapper<GuaranteeItem> getMapper() {
		// TODO Auto-generated method stub
		return guaranteeItemMapper;
	}

	@Override
	public List<GuaranteeItem> getGuaranteeItemById(Long id) {
		// TODO Auto-generated method stub
		return guaranteeItemMapper.getGuaranteeItemById(id);
	}

	@Override
	public void deleteGuaranteeItemByGuaranteeId(Long id) {
		// TODO Auto-generated method stub
		guaranteeItemMapper.deleteGuaranteeItemByGuaranteeId(id);
	}


}
