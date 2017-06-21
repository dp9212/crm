package cn.yysg.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.ContractItem;
import cn.yysg.crm.query.ContractItemQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IContractItemService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/contractitem")
public class ContractItemController {
	
	
	@Autowired
	private IContractItemService contractItemService;
	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "contractitem/list";
	} 

	
	@RequestMapping("/json")
	@ResponseBody
	public PageList<ContractItem> json(ContractItemQuery cq) {
		return contractItemService.getPageList(cq);
	}
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(ContractItem contractItem) {
		try {
			if (contractItem.getId() == null) {
				contractItemService.save(contractItem);
			} else {
				contractItemService.update(contractItem);
			}
			return new JsonResult();
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
	@RequestMapping("/get")
	@ResponseBody
	public JsonResult get(ContractItem contractItem){
		if (contractItem.getId() == null) {
			contractItemService.get(contractItem.getId());
		}
		return new JsonResult();
	}

	// 处理delete
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id) {
		try {
			if (id != null) {
				contractItemService.delete(id);
				return new JsonResult();
			} else {
				return new JsonResult("没有传入对应id");
			}
		} catch (Exception e) {
			return new JsonResult("异常：" + e.getMessage());
		}
	}
}
