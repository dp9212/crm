package cn.yysg.crm.service;

import java.util.List;

import cn.yysg.crm.domain.Department;

public interface IDepartmentService extends IBaseService<Department>{
	//员工添加编辑时部门下拉单
	
	List<Department> getDept();
	
	List<Department> getTreeData();

}
