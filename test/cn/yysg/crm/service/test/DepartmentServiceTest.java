package cn.yysg.crm.service.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yysg.crm.domain.Department;
import cn.yysg.crm.service.IDepartmentService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class DepartmentServiceTest {

	@Autowired
	IDepartmentService departmentService;

	@Test
	public void getAll() throws Exception {
		System.out.println(departmentService.getClass());
		List<Department> list = departmentService.getAll();
		System.out.println(list.size());
	}

	@Test
	public void save() throws Exception {
		for (int i = 1; i <=5; i++) {
			Department department = new Department();
			department.setName("department" + i);
			department.setSn("No." + i);
			department.setDirPath("" + i);
			departmentService.save(department);
		}
	}
	
}
