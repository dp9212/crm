package cn.yysg.crm.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.CustomerResourcePool;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.query.CustomerResourcePoolQuery;
import cn.yysg.crm.service.ICustomerResourcePoolService;
import cn.yysg.crm.service.ICustomerService;
import cn.yysg.crm.service.ICustomerTransferService;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/customerResourcePool")
public class CustomerResourcePoolController {
	@Autowired
	private ICustomerService customerService;
	@Autowired
	private ICustomerTransferService customerTransferService;
	@Autowired
	private ICustomerResourcePoolService customerResourcePoolService;
	
	@Autowired
	private IEmployeeService employeeService;
	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "customerResourcePool/list";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public Map json(CustomerResourcePoolQuery baseQuery) {
		  Map<String,Object> map =new HashMap();
		  map.put("total", customerResourcePoolService.getTotal(baseQuery));
		  map.put("rows", customerResourcePoolService.getRows(baseQuery));
		 
		  return map;
	  }
	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(CustomerResourcePool customerResourcePool) {
		customerResourcePool.setInputUser(new Employee(5L));
		
		try {
			if (customerResourcePool.getId() == null) {
				customerResourcePoolService.save(customerResourcePool);
			} else {
				customerResourcePoolService.update(customerResourcePool);
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
				customerResourcePoolService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	@RequestMapping("/parentData")
	@ResponseBody
	public List<SystemDictionaryItem> parentSystemDictionaryItemData(Long id) {
		List<SystemDictionaryItem>list=new ArrayList();
		SystemDictionaryItem item=new SystemDictionaryItem();
		item.setId(-1L);
		item.setName("请选择");
		list.add(item);
		list.addAll(customerResourcePoolService.queryItemsById(id));
		return list;
	
	
	}
}
