package cn.yysg.crm.mapper;

import java.util.List;
import java.util.Map;

import cn.yysg.crm.domain.Role;

public interface RoleMapper extends BaseMapper<Role>{
	void createRolePermission(List<Map<String, Long>> rpList);
	void deleteRolePermission(Long roleId);
	void saveRoleAndPermission(List<Map<String, Long>> rpMapList);
}
