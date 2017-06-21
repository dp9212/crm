package cn.yysg.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.CustomerResourcePool;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface CustomerResourcePoolMapper extends BaseMapper<CustomerResourcePool> {
	@Select("select id,name from  t_system_dictionary_item where parent_id=#{id}")
	List<SystemDictionaryItem>queryItemsById(Long id);
	@Select("select count(*) from t_customertransfer")
	Long getCount();
}

