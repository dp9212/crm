package cn.yysg.crm.service.test;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.PotentialCustomer;
import cn.yysg.crm.service.IPotentialCustomerService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class PotentialCustomerServiceTest {

  @Autowired
  IPotentialCustomerService potentialCustomerService;

  @Test
  public void getAll() throws Exception {
    System.out.println(potentialCustomerService.getClass());
    List<PotentialCustomer> list = potentialCustomerService.getAll();
    for (PotentialCustomer potentialCustomer : list) {
		System.out.println(potentialCustomer);
	}
    System.out.println(list.size());
  }

  @Test
  public void save() throws Exception {
    PotentialCustomer potentialCustomer = new PotentialCustomer();
    
    potentialCustomer.setInputTime(new Date());
    potentialCustomer.setRemark("aaaa");
    potentialCustomer.setLinkMan("aaaaa");
    potentialCustomer.setLinkManTel("130090009090");
     potentialCustomer.setName("大同府");
    potentialCustomerService.save(potentialCustomer);
  }

}
