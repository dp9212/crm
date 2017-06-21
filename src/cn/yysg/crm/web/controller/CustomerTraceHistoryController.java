package cn.yysg.crm.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.CustomerTraceHistory;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.query.CustomerTraceHistoryQuery;
import cn.yysg.crm.service.ICustomerService;
import cn.yysg.crm.service.ICustomerTraceHistoryService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController {
	@Autowired
	private ICustomerTraceHistoryService customerTraceHistoryService;
	@Autowired
	private ICustomerService customerService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "customerTraceHistory/list";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public Map json(CustomerTraceHistoryQuery baseQuery) {
		  Map<String,Object> map =new HashMap();
		  map.put("total", customerTraceHistoryService.getTotal(baseQuery));
		  map.put("rows", customerTraceHistoryService.getRows(baseQuery));
		 
		  return map;
	  }
	  
	  
	  @RequestMapping("/getAllCustomer")
	  @ResponseBody
	  public List<Customer> getALlCustomer(CustomerTraceHistoryQuery baseQuery) {
		  System.out.println("-----------------"+customerService.getAll());
		  List<Customer> list = customerService.getAll();
		  return list;
	  }
	  
	  
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(CustomerTraceHistory customerTraceHistory) {
		try {
			if (customerTraceHistory.getId() == null) {
				customerTraceHistoryService.save(customerTraceHistory);
			} else {
				customerTraceHistoryService.update(customerTraceHistory);
			}
			return new JsonResult();
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	
	@RequestMapping("/saveHistory")
	@ResponseBody
	public JsonResult saveHistory(CustomerTraceHistory customerTraceHistory,Long id) {
		System.out.println("======"+id);
		Customer customer = customerService.get(id);
		System.out.println(customer);
		if(customer.getState()==0){
			return new JsonResult("正在跟踪");
		}
		try {
		customer.setState(0);
		customerTraceHistory.setCustomer(customer);
		customerService.update(customer);
		System.out.println("===="+customerTraceHistory.getId());
				customerTraceHistoryService.save(customerTraceHistory);
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
				customerTraceHistoryService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	@RequestMapping("/getAllTraceItem")
	@ResponseBody
	public List<SystemDictionaryItem> getAllTraceItem(Long id) {
		List<SystemDictionaryItem>list=new ArrayList();
		SystemDictionaryItem item=new SystemDictionaryItem();
		item.setId(-1L);
		item.setName("请选择");
		list.add(item);
		list.addAll(customerTraceHistoryService.queryItemsById(id));
		return list;
	}
}
