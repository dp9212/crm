package cn.yysg.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Contract;
import cn.yysg.crm.query.ContractQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IContractService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/contract")
public class ContractController {
	@Autowired
	private IContractService contractService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "contract/list";
	}
	@RequestMapping("/data")
	public String data() {
		return "contract/data";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public PageList<Contract> json(ContractQuery cq) {
		  return contractService.getPageList(cq);
	  }
	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Contract contract) {
		try {
			if (contract.getId() == null) {
				contractService.save(contract);
			} else {
				contractService.update(contract);
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
		try {
			if (id != null) {
				contractService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	
	@RequestMapping("/getListData")
	@ResponseBody
	public List<Contract> getListData(){
		return contractService.getAll();
	}
}
