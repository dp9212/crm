package cn.yysg.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.SystemLog;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.query.SystemLogQuery;
import cn.yysg.crm.service.ISystemLogService;

@Controller
@RequestMapping("/systemLog")
public class SystemLogController {
	@Autowired
	private ISystemLogService systemLogService;
	
	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "systemLog/list";
	}

	// 从列表页面发出ajax请求获取json数据
	@RequestMapping("/json")
	@ResponseBody
	public PageList<SystemLog> json(SystemLogQuery eq) {
		//带分页数据
		return systemLogService.getPageList(eq);
	}
	
}
