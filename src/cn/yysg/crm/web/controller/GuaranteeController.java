package cn.yysg.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.annotation.PermissionResource;
import cn.yysg.crm.domain.Guarantee;
import cn.yysg.crm.query.GuaranteeQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IContractService;
import cn.yysg.crm.service.IGuaranteeItemService;
import cn.yysg.crm.service.IGuaranteeService;
import cn.yysg.crm.util.JsonResult;

@PermissionResource(permissionName="售后管理",menuName="保修单")
@Controller
@RequestMapping("/guarantee")
public class GuaranteeController {

	@Autowired
	private IGuaranteeService guaranteeService;
	
	@Autowired
	private IContractService contractService;
	
	@Autowired
	private IGuaranteeItemService guaranteeItemService;
	
	/**
	 * 显示页面，不需要添加数据
	 * @return
	 */
	@RequestMapping("/list")
	public String list(){

		return "/guarantee/list";
	}

	
	/**
	 * @return 返回json数据
	 */
	@RequestMapping("/json")
	@ResponseBody
	public PageList<Guarantee> json(GuaranteeQuery baseQuery) {
		//带分页数据
		PageList findByQuery = guaranteeService.getPageList(baseQuery);
		return findByQuery;
	}

	//Ajax删除
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id) {
		try {
			//先删除明细
			guaranteeItemService.deleteGuaranteeItemByGuaranteeId(id);
			guaranteeService.delete(id);
			return new JsonResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult("删除出现异常：" + e.getMessage());
		}
	}
	//Ajax删除
		@RequestMapping("/save")
		@ResponseBody
		public JsonResult save(Guarantee guarantee) {
			try {
				//先删除明细
				guaranteeService.save(guarantee);
				return new JsonResult();
			} catch (Exception e) {
				e.printStackTrace();
				return new JsonResult("保存出现异常：" + e.getMessage());
			}
		}
}
