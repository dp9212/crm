package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.SystemDictionary;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.SystemDictionaryMapper;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.query.SystemDictionaryQuery;
import cn.yysg.crm.service.ISystemDictionaryService;

@Service
public class SystemDictionaryServiceImpl extends BaseServiceImpl<SystemDictionary>  implements ISystemDictionaryService {
	@Autowired
	SystemDictionaryMapper mapper;
	
	@Override
	protected BaseMapper<SystemDictionary> getMapper() {
		// TODO Auto-generated method stub
		return mapper;
	}

	

	
}
