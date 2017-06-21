package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.Employee;

public interface IEmployeeService extends IBaseService<Employee>{
	//登录
	Employee login(String username, String password);

	Employee findManager(Employee employee);

	//离职
	void leave(Long id);
	//获取当前用户的权限
	List<String> getPermissions(Long id);
	//判断用户是否具有指定权限
	boolean hasPermission(Long id, String permissionName);

}
