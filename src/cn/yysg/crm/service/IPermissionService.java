package cn.yysg.crm.service;

import cn.yysg.crm.domain.Permission;

public interface IPermissionService extends IBaseService<Permission> {
	//通过权限名查找权限
	Permission findByName(String permissionName);
	
}
