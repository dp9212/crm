package cn.yysg.crm.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.query.PermissionQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IPermissionService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/permission")
public class PermissionController {
	@Autowired
	private IPermissionService permissionService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "permission/list";
	}

	// 从列表页面发出ajax请求获取json数据
	@RequestMapping("/json")
	@ResponseBody
	public PageList<Permission> json(PermissionQuery qo) {
		qo.setState(0);
		return permissionService.getPageList(qo);
	}

	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Permission permission) {
		try {
			if (permission.getId() == null) {
				permissionService.save(permission);
			} else {
				permissionService.update(permission);
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
				permissionService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
}
