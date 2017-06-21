package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.CustomerTraceHistory;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface ICustomerTraceHistoryService extends IBaseService<CustomerTraceHistory>{
	List<SystemDictionaryItem>queryItemsById(Long id);
	void deleteByCustomerId(Long id);
}
