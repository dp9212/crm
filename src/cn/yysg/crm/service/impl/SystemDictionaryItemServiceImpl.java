package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Role;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.SystemDictionaryItemMapper;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.query.SystemDictionaryItemQuery;
import cn.yysg.crm.service.ISystemDictionaryItemService;

@Service
public class SystemDictionaryItemServiceImpl extends BaseServiceImpl<SystemDictionaryItem> implements ISystemDictionaryItemService {
	@Autowired
	SystemDictionaryItemMapper SystemDictionaryItemMapper;

	@Override
	protected BaseMapper<SystemDictionaryItem> getMapper() {
		// TODO Auto-generated method stub
		return SystemDictionaryItemMapper;
	}

	

	
}
