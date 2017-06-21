package cn.yysg.crm.web.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Menu;
import cn.yysg.crm.query.MenuQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IMenuService;
import cn.yysg.crm.util.JsonResult;
import cn.yysg.crm.util.UserContext;


@Controller
@RequestMapping("/menu")
public class MenuController {
	@Autowired
	private IMenuService menuService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "menu/list";
	}

	// 从列表页面发出ajax请求获取json数据
/*	@RequestMapping("/json")
	@ResponseBody
	public List<Menu> json(MenuQuery qo) {
		return menuService.getAll();
	}*/
	@RequestMapping("/json")
	@ResponseBody
	public PageList<Menu> json(MenuQuery qo) {
		return menuService.getPageList(qo);
	}
	@RequestMapping("/getUserMenu")
	@ResponseBody
	public List<Menu> json() {
		return menuService.getUserMenu(UserContext.getSessionUser().getId());
	}


	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Menu menu) {
		try {
			if (menu.getId() == null) {
				menuService.save(menu);
			} else {
				menuService.update(menu);
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
				menuService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
}
