package cn.yysg.crm.service.test;

import java.util.Date;
import java.util.List;

import javax.xml.crypto.Data;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.CustomerDevPlan;
import cn.yysg.crm.service.ICustomerDevPlanService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CustomerDevPlanServiceTest {

  @Autowired
  private ICustomerDevPlanService customerDevPlanService;

  @Test
  public void getAll() throws Exception {
//	  customerDevPlanService.getAll();
    System.out.println(customerDevPlanService.getClass());
    List<CustomerDevPlan> list = customerDevPlanService.getAll();
    System.out.println(list.size());
  }

  @Test
  public void save() throws Exception {
    CustomerDevPlan customerDevPlan = new CustomerDevPlan();
    customerDevPlan.setId(2L);
    customerDevPlan.setInputUser("诠笃");
    customerDevPlan.setInputTime(new Date());
   customerDevPlan.setPlanTime(new Date());
    
    // employee.setName("employee");
    customerDevPlanService.save(customerDevPlan);
//    customerDevPlanService.delete(3L);;
//    customerDevPlanService.update(customerDevPlan);;
  }
  @Test
  public void TestDate(){
	  Date date=new Date();
//	  date="yy:mm:dd";
	    System.out.println(date);
  }
}
