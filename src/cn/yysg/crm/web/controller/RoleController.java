package cn.yysg.crm.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.domain.Role;
import cn.yysg.crm.query.RoleQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IRoleService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "role/list";
	}

	// 从列表页面发出ajax请求获取json数据
	@RequestMapping("/json")
	@ResponseBody
	public PageList<Role> json(RoleQuery qo) {
		
		return roleService.getPageList(qo);
	}


	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Role role) {
		try {
			if (role.getId() == null) {
				roleService.saveRoleAndPermission(role);
			} else {
				roleService.update(role);
			}
			return new JsonResult();
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}

	// 处理delete
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id) {
		try {
			if (id != null) {
				roleService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
}
