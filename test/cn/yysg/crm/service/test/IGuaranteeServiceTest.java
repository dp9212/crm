package cn.yysg.crm.service.test;


import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.yysg.crm.domain.Guarantee;
import cn.yysg.crm.query.BaseQuery;
import cn.yysg.crm.query.GuaranteeQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IContractService;
import cn.yysg.crm.service.ICustomerService;
import cn.yysg.crm.service.IGuaranteeService;

public class IGuaranteeServiceTest extends BaseTest {

	@Autowired
	IGuaranteeService guaranteeService;
	
	@Autowired
	IContractService contractService;
	
	@Autowired
	ICustomerService customerService;
	
	@Test
	public void testName() throws Exception {
	}
	

	@Test
	public void testUpdate() {
		
	}

	@Test
	public void testDelete() {
	}

	@Test
	public void testGet() {
	}

	@Test
	public void testGetAll() {
		List<Guarantee> all = guaranteeService.getAll();
		for (Guarantee guarantee : all) {
			//System.out.println("!!!!!!!!"+guarantee);
		}
		
	}

	@Test
	public void testPagelist() throws Exception {
		GuaranteeQuery baseQuery= new GuaranteeQuery();
		PageList<Guarantee> pageList = guaranteeService.getPageList(baseQuery);
		//System.out.println(pageList);
	}
	@Test
	public void testFindByQuery() {
	}
	
	@Test
	public void testDate() {
	}
	
}
