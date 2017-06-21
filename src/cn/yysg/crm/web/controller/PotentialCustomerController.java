package cn.yysg.crm.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.PotentialCustomer;
import cn.yysg.crm.service.IPotentialCustomerService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/potentialCustomer")
public class PotentialCustomerController {
  @Autowired
  private IPotentialCustomerService potentialCustomerService;

  // 显示列表页面
  @RequestMapping("/list")
  public String list() {
    return "potentialCustomer/list";
  }

  // 从列表页面发出ajax请求获取json数据
  @RequestMapping("/json")
  @ResponseBody
  public List<PotentialCustomer> json() {
    return potentialCustomerService.getAll();
  }

  // Map:{"success":true,"msg":"xxxxx"}
  // JsonResult:{"success":true,"msg":"xxxxx"}
  // 处理save
  @RequestMapping("/save")
  @ResponseBody
  public JsonResult save(PotentialCustomer potentialCustomer) {
    try {
      if (potentialCustomer.getId() == null) {
//    	  potentialCustomer.setInputTime(new Date());
	potentialCustomerService.save(potentialCustomer);
      } else {
	potentialCustomerService.update(potentialCustomer);
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
	potentialCustomerService.delete(id);
	return new JsonResult();
      } else {
	return new JsonResult("没有传入对应id");
      }
    } catch (Exception e) {
      return new JsonResult("异常：" + e.getMessage());
    }
  }
}
