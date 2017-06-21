package cn.yysg.crm.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import cn.yysg.crm.domain.Employee;

public interface EmployeeMapper extends BaseMapper<Employee> {
	//登录功能
	Employee findByUserName(String username);
	@Select("select * from t_employee o left join t_department d on"
			+ "o.id=d.manager_id where o.id=#{employee.id}")
	Employee findManager(Employee employee);

	//离职
	void leave(Long id);
	
	//获取当前用户的权限
	List<String> findUserPermissions(Long id);
	//通过权限id判断用户的权限数量
	int findPermissionTotal(Map<String, Long> map);

}
