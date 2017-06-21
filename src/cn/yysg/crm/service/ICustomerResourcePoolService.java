package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.CustomerResourcePool;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface ICustomerResourcePoolService extends IBaseService<CustomerResourcePool>{
	List<SystemDictionaryItem>queryItemsById(Long id);
	Long getCount();
}
