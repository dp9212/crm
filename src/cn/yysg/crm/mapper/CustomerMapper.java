package cn.yysg.crm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface CustomerMapper extends BaseMapper<Customer> {
	@Select("select id,name from  t_system_dictionary_item where parent_id=#{id}")
	List<SystemDictionaryItem>queryItemsById(Long id);

	@Select("select * from  t_customer where id=#{id}")
	Customer data(Long id);

	@Select("select count(*) from t_customertransfer")
	Long getCount();
	

	 List<Map<String,Object>> moneyData();

}

