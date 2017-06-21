package cn.yysg.crm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.EmployeeMapper;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.service.IPermissionService;

@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee> implements IEmployeeService {
	@Autowired
	private EmployeeMapper employeeMapper;
	@Autowired
	private IPermissionService permissionService;

	@Override
	protected BaseMapper<Employee> getMapper() {
		return employeeMapper;
	}
	//登录
	@Override
	public Employee login(String username, String password) {
		Employee employee = employeeMapper.findByUserName(username);
		if(null!=employee){
			if(employee.getPassword().equals(password)){
				return employee;
			}
		}
		return null;
	}
	
	@Override
	public Employee findManager(Employee employee) {
		return employeeMapper.findManager(employee);
	}
	

	//离职
	@Override
	public void leave(Long id) {
		employeeMapper.leave(id);
	}
	
	//获取当前用户的权限
	@Override
	public List<String> getPermissions(Long id) {
		
		return employeeMapper.findUserPermissions(id);
	}
	
	@Override
	public boolean hasPermission(Long id, String permissionName) {
		// 先通过权限的名字查询权限对象
		Permission permission = permissionService.findByName(permissionName);
		// 如果没查到说明不需要权限拦截,那么直接通过\
		if (null == permission) return true;
		// 如果有说明需要判断权限:
		Map<String, Long> map = new HashMap<String, Long>();
		map.put("employeeId", id);
		map.put("permissionId", permission.getId());
		int totalPermission = employeeMapper.findPermissionTotal(map);
		// 直接查询用户拥有指定的权限的结果条数>0 说明有权限
		// employeeMapper.findUserPermissions(id);//该用于拥有的所有权限
		if (totalPermission > 0) {
			return true;
		}
		return false;
	}

}
