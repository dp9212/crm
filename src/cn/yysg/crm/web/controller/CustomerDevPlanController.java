package cn.yysg.crm.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.CustomerDevPlan;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.service.ICustomerDevPlanService;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/customerDevPlan")
public class CustomerDevPlanController {
  @Autowired
  private ICustomerDevPlanService customerDevPlanService;

  // 显示列表页面
  @RequestMapping("/list")
  public String list() {
    return "customerDevPlan/list";
  }

  // 从列表页面发出ajax请求获取json数据
  @RequestMapping("/json")
  @ResponseBody
  public List<CustomerDevPlan> json() {
    return customerDevPlanService.getAll();
  }

  // Map:{"success":true,"msg":"xxxxx"}
  // JsonResult:{"success":true,"msg":"xxxxx"}
  // 处理save
  @RequestMapping("/save")
  @ResponseBody
  public JsonResult save(CustomerDevPlan customerDevPlan) {
    try {
      if (customerDevPlan.getId() == null) {
//    	  customerDevPlan.setInputTime(new Date());
	customerDevPlanService.save(customerDevPlan);
      } else {
	customerDevPlanService.update(customerDevPlan);
//	customerDevPlanService.update(t);
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
	customerDevPlanService.delete(id);
	return new JsonResult();
      } else {
	return new JsonResult("没有传入对应id");
      }
    } catch (Exception e) {
      return new JsonResult("异常：" + e.getMessage());
    }
  }
}
