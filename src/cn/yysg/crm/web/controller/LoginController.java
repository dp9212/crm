package cn.yysg.crm.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.util.JsonResult;
import cn.yysg.crm.util.UserContext;

@Controller
public class LoginController {
	@Autowired
	private IEmployeeService employeeService;
	
	// 显示登录界面
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}

	//登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult checkLogin(String username,String password){
		//通过service方法完成登录验证
		Employee employee = employeeService.login(username,password);
		JsonResult result = new JsonResult();
		if(null==employee){
			result.setSuccess(false).setMsg("登录失败,请检查用户名或者密码！");
		}else{
			result.setSuccess(true).setMsg("登录成功");
			//当前用户放入session
			UserContext.setSessionUser(employee);
		}
		return result;
	}
	//注销
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session){
		UserContext.remove(session);
		return "login";
	}
}
