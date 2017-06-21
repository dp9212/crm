package cn.yysg.crm.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.domain.Role;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.RoleMapper;
import cn.yysg.crm.service.IRoleService;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {
	
	@Autowired
	RoleMapper roleMapper;

	@Override
	protected BaseMapper<Role> getMapper() {
		// TODO Auto-generated method stub
		return roleMapper;
	}

	@Override
	public void saveRoleAndPermission(Role role) {
		// TODO Auto-generated method stub
		this.save(role);
		Long roleId = role.getId();
		Map<String,Long> rpMap;
		List<Permission> permissions=role.getPermissions();
		List<Map<String, Long>> rpMapList=new ArrayList<>();
		for (Permission permission : permissions) {
			rpMap=new HashMap<String,Long>();
			rpMap.put("roleId", roleId);
			rpMap.put("permissionId", permission.getId());
			rpMapList.add(rpMap);
		}
		roleMapper.saveRoleAndPermission(rpMapList);
	}

}
