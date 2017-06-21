package cn.yysg.crm.service.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.query.CustomerQuery;
import cn.yysg.crm.service.ICustomerService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CustomerServiceTest {

	@Autowired
	ICustomerService customerService;

	@Test
	public void getAll() throws Exception {
		System.out.println(customerService);
		Customer customer = customerService.get(13L);
		System.out.println(customer);
	}
	@Test
	public void getmoney() throws Exception {
		 List<Map<String, Object>> list = customerService.moneyData();
		StringBuffer sb=new StringBuffer();
		
		System.out.println(list);
		
		
		/*sb.append("[");
		for (Object[] objects : list) {
			
		
			System.out.println(objects.length);
		for (int j = objects.length-1; j >= 0; j--) {
			if(j==objects.length-1){
				sb.append("["+"\""+objects[j]+"\"");
			}else{
				sb.append(","+objects[j]+"]");
			}
			
			
		}
		
			
			sb.append(",");
		
		}
		sb.append("]");
		System.out.println(sb.toString());*/
	}
	@Test
	public void getMoneyList() throws Exception {
		   List<Map<String, Object>> moneyData = customerService.moneyData();
		System.out.println(moneyData);
	}
	@Test
	public void getOne() throws Exception {
		StringBuffer sb=new StringBuffer();
		List<Object[]> list=new ArrayList<>();
		list.add(new Object[]{"1","gao"});
		list.add(new Object[]{"2","xin"});
		list.add(new Object[]{"3","bu",});
		/*"[{1:\"gao\"}]"*/
		sb.append("[");
		for (int i = 0; i < list.size(); i++) {
			Object[] objects = list.get(i);
			/*sb.append("[{").append()*/
			System.out.println(objects.length);
		for (int j = objects.length-1; j >= 0; j--) {
			if(j==objects.length-1){
				sb.append("["+"\""+objects[j]+"\"");
			}else{
				sb.append(":"+objects[j]+"]");
			}
			
			
		}
		if(i==list.size()-1){
			
		}else{
			
			sb.append(",");
		}
		}
		sb.append("]");
		System.out.println(sb.toString());
	}

	@Test
	public void save() throws Exception {
		for (int i = 1; i <2; i++) {
			Customer customer = new Customer();
			customer.setAge(i);
			customer.setName("索隆22" + i);
			customer.setAddress("门牌" + i);
			customer.setEmail("sanzhi"+i+"@ni.com");
			customer.setGender(1);
			customer.setInputTime(new Date());
			customer.setTel("1234"+i);
			customer.setInputUser(new Employee(1L));
			customerService.save(customer);
		}
	}
	@Test
	public void update() throws Exception {
		Customer customer = new Customer();
		/*customer.setId(3L);*/
		customer.setAge(2);
		customer.setName("索zhahaa" + 2);
		customer.setAddress("门牌" + 1);
		customer.setEmail("sanzhi"+1+"@ni.com");
		customer.setGender(1);
		customer.setInputTime(new Date());
		customer.setTel("1234"+1);
		customer.setInputUser(new Employee(1L));
		customerService.save(customer);
	}
	@Test
	public void query() throws Exception {
		CustomerQuery query =new CustomerQuery();
		query.setKeyWord("索隆");
		query.setPage(1);
		System.out.println(customerService.getPageList(query).getTotal());
		System.out.println(customerService.getPageList(query).getRows().size());
	}
	@Test
	public void query2() throws Exception {
		CustomerQuery query =new CustomerQuery();
		query.setPage(1);
		System.out.println(customerService.getPageList(query).getTotal());
		System.out.println(customerService.getPageList(query).getRows());
	}
	
}
