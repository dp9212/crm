package cn.yysg.crm.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.service.IEmployeeService;

@Component//标签必须有，交给Spring管理
public class PermissionUtils {
	
		//静态成员字段注入不能。提供set方法注入
		private static IEmployeeService employeeService;
		
		@Autowired
		public void setEmployeeService(IEmployeeService employeeService) {
			PermissionUtils.employeeService = employeeService;
		}
		
		/**
		 * 提供一个静态方法,拼接两个字符串
		 */
		public static String append(String str1,String str2){
			return str1+str2;
		}
		
		/**
		 * 判断用户是否有权限
		 * @param permissionName
		 * @return
		 */
		public static boolean hasPermission(String permissionName){
			//System.out.println(permissionName);
			//实现判断当前登录用户是否有permissionName这个权限?
			if(null==permissionName || "".equals(permissionName)) return false;
			//获取当前登录用户
			Employee employee = UserContext.getSessionUser();
			if(null==employee) return false;
			//System.out.println(employeeService);
			//通过service的一个方法来判断用户是否有权限
			return employeeService.hasPermission(employee.getId(),permissionName);
		}
}
