package cn.yysg.crm.service.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.Employee;
import cn.yysg.crm.service.IEmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class EmployeeServiceTest {

	@Autowired
	IEmployeeService employeeService;

	@Test
	public void getAll() throws Exception {
		List<Employee> list = employeeService.getAll();
		for (Employee employee : list) {
			System.out.println(employee);
		}
	}
	
	@Test
	public void save() throws Exception {
		for (int i = 1; i <= 50; i++) {
			Employee employee = new Employee();
			employee.setUsername("name"+i);
			employee.setRealName("rname"+i);
			employee.setPassword("pwd"+i);
			employee.setTel("13123");
			employeeService.save(employee);
		}
	}

}
