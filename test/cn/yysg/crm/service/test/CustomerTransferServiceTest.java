package cn.yysg.crm.service.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.service.ICustomerTransferService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CustomerTransferServiceTest {

	@Autowired
	ICustomerTransferService customerTransferService;

	@Test
	public void getAll() throws Exception {
		System.out.println(customerTransferService.queryOld(1l));
	}

	@Test
	public void save() throws Exception {
	/*	for (int i = 1; i <50; i++) {
			customerTransfer customerTransfer = new customerTransfer();
			customerTransfer.setCustomer(new Customer(1L));
			customerTransfer.setRemark("追踪情况"+i);
			customerTransfer.setTitle("扫黄调查"+i);
			customerTransfer.setTraceResult(1);
			customerTransfer.setTraceTime(new Date());
			customerTransfer.setTraceType(new SystemDictionaryItem(10L));
			customerTransfer.setTraceUser(new Employee(8L));
			
			customerTransferService.save(customerTransfer);
		}*/
	}
	@Test
	public void update() throws Exception {
		/*customerTransfer customerTransfer = new customerTransfer();
		customerTransfer.setId(3L);
		customerTransfer.setCustomer(new Customer(1L));
		customerTransfer.setRemark("追踪情况--");
		customerTransfer.setTitle("扫黄调查--");
		customerTransfer.setTraceResult(1);
		customerTransfer.setTraceTime(new Date());
		customerTransfer.setTraceType(new SystemDictionaryItem(10L));
		customerTransfer.setTraceUser(new Employee(8L));
		customerTransferService.update(customerTransfer);*/
	}
	@Test
	public void query() throws Exception {
		System.out.println(customerTransferService.getAll());
	}
	@Test
	public void query2() throws Exception {
	}
	
}
