package cn.yysg.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.query.EmployeeQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	@Autowired
	private IEmployeeService employeeService;
	
	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "employee/list";
	}

	// 从列表页面发出ajax请求获取json数据
	@RequestMapping("/json")
	@ResponseBody
	public PageList<Employee> json(EmployeeQuery eq) {
		//带分页数据
		return employeeService.getPageList(eq);
	}
	
//	@RequestMapping("/json")
//	@ResponseBody
//	public List<Employee> json() {
//		return employeeService.getAll();
//	}

	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Employee employee) {
		try {
			if (employee.getId() == null) {
				employeeService.save(employee);
			} else {
				employeeService.update(employee);
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
				employeeService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	//离职
	@RequestMapping("/leave")
	@ResponseBody
	  public JsonResult leave(Long id) {
	    try {
	      if (id != null) {
		employeeService.leave(id);
		return new JsonResult();
	      } else {
		return new JsonResult("没有传入对应id");
	    }
	  } catch (Exception e) {
	    return new JsonResult("异常：" + e.getMessage());
	  }
	}

}
