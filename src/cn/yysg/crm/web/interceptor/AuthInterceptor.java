package cn.yysg.crm.web.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.domain.Permission;
import cn.yysg.crm.query.PermissionQuery;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.service.IPermissionService;
import cn.yysg.crm.util.UserContext;

public class AuthInterceptor implements HandlerInterceptor{
	@Autowired
	private IEmployeeService employeeservice;
	@Autowired
	private IPermissionService permissionService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 1.对不需要拦截的控制器进行放行
		String url = request.getRequestURI();
		//if (url.endsWith("/employee/logout") || url.endsWith("/employee/login")) {
		if (url.endsWith("/logout") || url.endsWith("/login")) {
			return true;
		}
		//登录拦截
		Employee employee = UserContext.getSessionUser();
		if(employee==null){
			//response.sendRedirect("/login.jsp");
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		
		//获取当前用户正在访问的资源
		HandlerMethod handMethod;
		if(handler instanceof HandlerMethod){
			handMethod = (HandlerMethod)handler;
			String className = handMethod.getBeanType().getName();
			String classMethod = className+"."+handMethod.getMethod().getName();
			String allMethod  = className+".ALL";
			System.out.println(allMethod);
			//获取当前用户的所有资源
			List<String> userPermissions =  employeeservice.getPermissions(employee.getId());
			//获取所有需要拦截的资源
			List<String> allPermissions = new ArrayList<String>();
			PermissionQuery qo = new PermissionQuery();
			qo.setState(0);
			qo.setRows(Integer.MAX_VALUE);
			List<Permission> allPermissionsList = permissionService.getPageList(qo).getRows();
			for (Permission permission : allPermissionsList) {
				allPermissions.add(permission.getResource());
			}
			//判断拦截
			if(allPermissions.contains(classMethod) || allPermissions.contains(allMethod)){
				//是
				if(userPermissions.contains(classMethod) || userPermissions.contains(allMethod)){
					//放行
					return true;
				}else{
					boolean isAjax = false;
					String ajaxHeader = request.getHeader("X-Requested-With");
					if("XMLHttpRequest".equals(ajaxHeader)){
						isAjax = true;
					}
					if(isAjax){//ajax数据返回
						response.sendRedirect("/static/js/nopermission.json");
					}else{//普通的页面返回
						response.sendRedirect("/static/nopermission.jsp");
					}
					return false;
				}
			}
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}
	
}
