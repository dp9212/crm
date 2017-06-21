package cn.yysg.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.CustomerTraceHistory;
import cn.yysg.crm.domain.SystemDictionaryItem;

public interface CustomerTraceHistoryMapper extends BaseMapper< CustomerTraceHistory> {
	@Select("select id,name from  t_system_dictionary_item where parent_id=#{id}")
	List<SystemDictionaryItem>queryItemsById(Long id);
	@Select("delete from t_customertracehistory where customer_id=#{id}")
	void deleteByCustomerId(Long id);
}

