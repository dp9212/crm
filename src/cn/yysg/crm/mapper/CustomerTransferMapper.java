package cn.yysg.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.CustomerTransfer;
import cn.yysg.crm.domain.Employee;

public interface CustomerTransferMapper extends BaseMapper<CustomerTransfer> {
	@Select("select * from t_employee o  JOIN t_customer c on c.seller_id=o.id where c.id=#{id}")
	 List<Employee> queryOld(Long id);
	
}

