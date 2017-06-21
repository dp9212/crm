package cn.yysg.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.PermissionMapper;
import cn.yysg.crm.service.IPermissionService;

@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission> implements IPermissionService{
	
	@Autowired
	private PermissionMapper permissionMapper;
	@Override
	protected BaseMapper<Permission> getMapper() {
		return permissionMapper;
	}
	@Override
	public Permission findByName(String permissionName) {
		return permissionMapper.findByName(permissionName);
	}
}
