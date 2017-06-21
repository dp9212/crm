package cn.yysg.crm.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.CustomerTransfer;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.domain.JXLExcelView;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.query.CustomerQuery;
import cn.yysg.crm.service.ICustomerResourcePoolService;
import cn.yysg.crm.service.ICustomerService;
import cn.yysg.crm.service.ICustomerTraceHistoryService;
import cn.yysg.crm.service.ICustomerTransferService;
import cn.yysg.crm.service.IEmployeeService;
import cn.yysg.crm.util.JsonResult;
import cn.yysg.crm.util.UserContext;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Autowired
	private ICustomerService customerService;
	@Autowired
	private ICustomerTransferService customerTransferService;
	
	@Autowired
	private IEmployeeService employeeService;
	
	@Autowired
	private ICustomerResourcePoolService customerResourcePoolService;
	@Autowired
	private ICustomerTraceHistoryService customerTraceHistoryService;
	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "customer/list";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public Map json(CustomerQuery baseQuery) {
		  Map<String,Object> map =new HashMap();
		  map.put("total", customerService.getTotal(baseQuery));
		  map.put("rows", customerService.getRows(baseQuery));
		 
		  return map;
	  }
	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Customer customer) {
		customer.setInputUser(new Employee(5L));
		
		try {
			if (customer.getId() == null) {
				customerService.save(customer);
			} else {
				customerService.update(customer);
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
		Customer customer = customerService.get(id);
		try {
			if (id != null) {
				customerTraceHistoryService.deleteByCustomerId(customer.getId());
				customerService.delete(id);
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
		list.addAll(customerService.queryItemsById(id));
		return list;
	}

	
	@RequestMapping("/data")
	@ResponseBody
	public List<Customer> data(Long id) {
		try {
			List<Customer>list=new ArrayList();
			Customer data = customerService.data(id);
			System.out.println(data);
			list.add(customerService.data(id));
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/transfer")
	@ResponseBody
	public JsonResult dataTransfer(CustomerTransfer customerTransfer,Long id) {
		/*Employee findManager = employeeService.findManager(UserContext.getSessionUser());*/
		try {
			
			Customer customer = customerService.get(id);
			Employee employee = employeeService.get(customerTransfer.getNewSeller().getId());
			customerTransfer.setOldSeller(customer.getSeller());
			customer.setSeller(employee);
			customerService.update(customer);
			customerTransfer.setId(customerService.getCount()+1);
			customerTransfer.setTransTime(new Date());
			customerTransfer.setCustomer(customer);
			customerTransfer.setNewSeller(employee);
			customerTransfer.setTransUser(UserContext.getSessionUser());
			customerTransferService.save(customerTransfer);
			
			/*customerTransfer.setOldSeller();*/
			return new JsonResult();
			/*}else{
				return new JsonResult("你无权利操作");
			}*/
		} catch (Exception e) {
			
			e.printStackTrace();
			return new JsonResult("出错"+e.getMessage());
		}
		
	}
	@RequestMapping("/changeState")
	@ResponseBody
	public JsonResult changeState(Long id) {
		try {
		Customer customer = customerService.get(id);
		if(customer.getState()==1){
			return new JsonResult("已放入资源池");
		}
		customer.setState(1);
		customerService.update(customer);
		customerResourcePoolService.save(customer.getCustomerResourcePool());
		
			return new JsonResult();
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	@RequestMapping("/moneyData")
	@ResponseBody
	public String moneyData() {
		/*List<Object[]> list = customerService.moneyData();
		StringBuffer sb=new StringBuffer();
		
		sb.append("[");
		for (int i = 0; i < list.size(); i++) {
			Object[] objects = list.get(i);
			System.out.println(objects.length);
		for (int j = objects.length-1; j >= 0; j--) {
			if(j==objects.length-1){
				sb.append("["+"\""+objects[j]+"\"");
			}else{
				sb.append(","+objects[j]+"]");
			}
			
		}
		if(i==list.size()-1){
			
		}else{
			
			sb.append(",");
		}
		}
		sb.append("]");
		System.out.println(sb.toString());*/
		return "1";
	}
	
	

	  @RequestMapping(value="/dcExcel",method=RequestMethod.GET)  
	    public ModelAndView toDcExcel(ModelMap model, HttpServletRequest request,CustomerQuery baseQuery){  
		  String[]head=new String[]{"名字","邮箱","年龄","薪水"};
		  
			List<String[]>datas=new ArrayList<String[]>();
			List<Customer> list = customerService.getRows(baseQuery);
			
	        //测试数据没有用到  
			model.put("list", list);
	         
	       return new ModelAndView(new JXLExcelView(), model);   
	   }  
}
