package cn.yysg.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Department;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.DepartmentMapper;
import cn.yysg.crm.service.IDepartmentService;

@Service
public class DepartmentServiceImpl extends BaseServiceImpl<Department> implements IDepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;

	@Override
	public List<Department> getTreeData() {
		return departmentMapper.getTreeData();
	}

	@Override
	protected BaseMapper<Department> getMapper() {
		return departmentMapper;
	}

	//员工添加编辑时部门下拉单
	@Override
	public List<Department> getDept() {
		return departmentMapper.getDept();
	}

}
