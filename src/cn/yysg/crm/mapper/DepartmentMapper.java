package cn.yysg.crm.mapper;

import java.util.List;

import cn.yysg.crm.domain.Department;

public interface DepartmentMapper extends BaseMapper<Department> {
	List<Department> getTreeData();

	List<Department> getDept();

}
