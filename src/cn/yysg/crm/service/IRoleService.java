package cn.yysg.crm.service;

import cn.yysg.crm.domain.Role;

public interface IRoleService extends IBaseService<Role>{
	//保存角色时保持权限关联到中间表
	void saveRoleAndPermission(Role role);

}
