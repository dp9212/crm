package cn.yysg.crm.service.test;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.CustomerTraceHistory;
import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.service.ICustomerTraceHistoryService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CustomerTraceHistoryServiceTest {

	@Autowired
	ICustomerTraceHistoryService customerTraceHistoryService;

	@Test
	public void getAll() throws Exception {
		System.out.println(customerTraceHistoryService.getAll());
	}

	@Test
	public void save() throws Exception {
		for (int i = 1; i <50; i++) {
			CustomerTraceHistory customerTraceHistory = new CustomerTraceHistory();
			customerTraceHistory.setCustomer(new Customer(1L));
			customerTraceHistory.setRemark("追踪情况"+i);
			customerTraceHistory.setTitle("扫黄调查"+i);
			customerTraceHistory.setTraceResult(1);
			customerTraceHistory.setTraceTime(new Date());
			customerTraceHistory.setTraceType(new SystemDictionaryItem(10L));
			customerTraceHistory.setTraceUser(new Employee(8L));
			
			customerTraceHistoryService.save(customerTraceHistory);
		}
	}
	@Test
	public void update() throws Exception {
		CustomerTraceHistory customerTraceHistory = new CustomerTraceHistory();
		customerTraceHistory.setId(3L);
		customerTraceHistory.setCustomer(new Customer(1L));
		customerTraceHistory.setRemark("追踪情况--");
		customerTraceHistory.setTitle("扫黄调查--");
		customerTraceHistory.setTraceResult(1);
		customerTraceHistory.setTraceTime(new Date());
		customerTraceHistory.setTraceType(new SystemDictionaryItem(10L));
		customerTraceHistory.setTraceUser(new Employee(8L));
		customerTraceHistoryService.update(customerTraceHistory);
	}
	@Test
	public void query() throws Exception {
		System.out.println(customerTraceHistoryService.getAll());
	}
	@Test
	public void query2() throws Exception {
	}
	
}
