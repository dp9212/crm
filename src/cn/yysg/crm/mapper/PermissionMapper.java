package cn.yysg.crm.mapper;

import cn.yysg.crm.domain.Permission;

public interface PermissionMapper extends BaseMapper<Permission>{
	//通过权限名查找权限
	Permission findByName(String name);

}
