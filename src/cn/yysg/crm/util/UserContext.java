package cn.yysg.crm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.yysg.crm.domain.Employee;

//处理session
public class UserContext {
	private static final String SESSION_IN_USER = "LOGINUSER";
	
	
	public static HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	}
	//将登录用户放入session中
	public static void setSessionUser(Employee employee){
		getRequest().getSession().setAttribute(UserContext.SESSION_IN_USER, employee);
	}
	//拿到session中的用户(登陆后)
	public static Employee getSessionUser(){
		Object object = getRequest().getSession().getAttribute(UserContext.SESSION_IN_USER);
		if(object!=null){
			return (Employee)object;
		}else{
			return null;
		}
	}
	//注销
	public static void remove(HttpSession session) {
		session.removeAttribute(SESSION_IN_USER);
	}
}
