package cn.yysg.crm.service.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import cn.yysg.crm.domain.Customer;
import cn.yysg.crm.domain.SystemDictionaryItem;
import cn.yysg.crm.mapper.BaseMapper;
import cn.yysg.crm.mapper.CustomerMapper;
import cn.yysg.crm.service.ICustomerService;

@Service
public class CustomerServiceImpl extends BaseServiceImpl<Customer> implements ICustomerService {

	@Autowired
	private CustomerMapper customerMapper;
	@Override
	protected BaseMapper<Customer> getMapper() {
		return customerMapper;
	}
	@Override
	public List<SystemDictionaryItem> queryItemsById(Long id) {
		// TODO Auto-generated method stub
		return customerMapper.queryItemsById(id);
	}

	@Override
	public Customer data(Long id) {
		return customerMapper.data(id);
		// TODO Auto-generated method stub
		
	}

	@Override
	public Long getCount() {
		// TODO Auto-generated method stub
		return customerMapper.getCount();
	}
	@Override
	public List<Map<String,Object>> moneyData() {
		// TODO Auto-generated method stub
		return customerMapper.moneyData();
	}
	@Override
	public InputStream download(String[] head, List<String[]> datas) throws Exception {
		SXSSFWorkbook wb=new SXSSFWorkbook();
		Sheet sheet = wb.createSheet();
		Row createRow = sheet.createRow(0);
		for(int i=0;i<head.length;i++){
			Cell createCell = createRow.createCell(i);
			createCell.setCellValue(head[i]);
		}
		
		for(int rownum=0;rownum<datas.size();rownum++){
			Row row = sheet.createRow(rownum+1);
			String[]data=datas.get(rownum);
			for(int column=0;column<data.length;column++){
				Cell cell = row.createCell(column);
				cell.setCellValue(data[column]);
			}
		}
		ByteArrayOutputStream outputStream =new ByteArrayOutputStream();
		wb.write(outputStream);	
		outputStream.close();
		wb.close();
	return new ByteArrayInputStream(outputStream.toByteArray());
}
	
	
}
