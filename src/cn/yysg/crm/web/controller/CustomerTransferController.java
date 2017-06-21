package cn.yysg.crm.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.CustomerTransfer;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.query.CustomerTransferQuery;
import cn.yysg.crm.service.ICustomerService;
import cn.yysg.crm.service.ICustomerTransferService;
import cn.yysg.crm.util.JsonResult;
import cn.yysg.crm.util.UserContext;

@Controller
@RequestMapping("/customerTransfer")
public class CustomerTransferController {
	@Autowired
	private ICustomerTransferService customerTransferService;
	@Autowired
	private ICustomerService customerService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "customerTransfer/list";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public Map json(CustomerTransferQuery baseQuery) {
		  Map<String,Object> map =new HashMap();
		  System.out.println("-----------");
		  map.put("total", customerTransferService.getTotal(baseQuery));
		  map.put("rows", customerTransferService.getRows(baseQuery));
		 
		  return map;
	  }
	  
	  
	  @RequestMapping("/getAllCustomer")
	  @ResponseBody
	  public List<Customer> getALlCustomer(CustomerTransferQuery baseQuery) {
		  System.out.println("-----------------"+customerService.getAll());
		  List<Customer> list = customerService.getAll();
		  return list;
	  }
	  @RequestMapping("/queryOld")
	  @ResponseBody
	  public List<Employee> getALlOld(CustomerTransfer customerTransfer,Long id) {
		  System.out.println();
		  List<Employee> list = customerTransferService.queryOld(id);
		  return list;
	  }
	  
	  
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(CustomerTransfer customerTransfer) {
	/*	System.out.println("============"+customerTransfer);
		
		
		if(customerTransfer.getCustomer().getId()==null){
			customer =new Customer();
		}else{
			customer = customerService.get(customerTransfer.getCustomer().getId());;
		}
		customer.setInputUser(UserContext.getSessionUser());
		customer.setName(customerTransfer.getCustomer().getName());
		customer.setInputTime(new Date());
		customer.setSeller(customerTransfer.getNewSeller());*/
		customerTransfer.setTransUser(UserContext.getSessionUser());
		Customer customer = customerService.get(customerTransfer.getCustomer().getId());;
		
		
		customer.setSeller(customerTransfer.getNewSeller());
		try {
			if (customerTransfer.getId() == null) {
				
				customerTransferService.save(customerTransfer);
			} else {
				
				customerTransferService.update(customerTransfer);
			}
			customerService.update(customer);
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
				customerTransferService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	
}
