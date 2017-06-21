package cn.yysg.crm.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface ICustomerService extends IBaseService<Customer>{
	List<SystemDictionaryItem>queryItemsById(Long id);
	Customer data(Long id);
	Long getCount();

	List<Map<String,Object>> moneyData();
	 public InputStream download(String[] head, List<String[]> datas) throws Exception;


}
