package cn.yysg.crm.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.yysg.crm.domain.Guarantee;
import cn.yysg.crm.domain.GuaranteeItem;
import cn.yysg.crm.query.GuaranteeItemQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IGuaranteeItemService;
import cn.yysg.crm.service.IGuaranteeService;
import cn.yysg.crm.util.JsonResult;


@Controller
@RequestMapping("/guaranteeItem")
public class GuaranteeItemController {

	@Autowired
	private IGuaranteeItemService guaranteeItemService;
	
	@Autowired
	private IGuaranteeService guaranteeService;
	
	//获取保修单管理页面展开列的保修单id
	private Long guaranteeId;
	
	/**
	 * 显示页面，不需要添加数据
	 * @return
	 */
	@RequestMapping("/list")
	public String list(Long id){
		this.guaranteeId=id;
		HttpSession session = getSession();
		session.setAttribute("ID_IN_SESSION", id);
		return "/guaranteeItem/list";
	}

	
	/**
	 * @param baseQuery 
	 * @return 返回json数据
	 */
	@RequestMapping("/json")
	@ResponseBody
	public PageList<GuaranteeItem> json(GuaranteeItemQuery baseQuery) {
		PageList<GuaranteeItem> pageList = guaranteeItemService.getPageList(baseQuery);
		return pageList;
		
	};
	
	/**
	 *  点击弹出对话框保存按钮发出保存请求
	 * @param employee
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(GuaranteeItem guaranteeItem) {
		try {
			HttpSession session = getSession();
			Long guaranteeItemId = (Long)session.getAttribute("ID_IN_SESSION");
			Guarantee guarantee = guaranteeService.get(guaranteeItemId);
			if (guaranteeItem.getId() == null) {
				System.out.println("保存之前");
				guaranteeItem.setGuarantee(guarantee);
				guaranteeItemService.save(guaranteeItem);
				System.out.println("保存之后");
			} else {
				guaranteeItemService.update(guaranteeItem);
			}
			return new JsonResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult("保存出现异常：" + e.getMessage());
		}
	}
	

	//Ajax删除
	@RequestMapping("/delete")
	@ResponseBody
	public JsonResult delete(Long id) {
		try {
			guaranteeItemService.delete(id);
			return new JsonResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult("删除出现异常：" + e.getMessage());
		}
	}
	
	//两个方法，用于springmvc把值放入session中，以及取值
	public static HttpSession getSession() { 
	    HttpSession session = null; 
	    try { 
	        session = getRequest().getSession(); 
	    } catch (Exception e) {} 
	        return session; 
	} 
	    
	public static HttpServletRequest getRequest() { 
	    ServletRequestAttributes attrs =(ServletRequestAttributes) RequestContextHolder.getRequestAttributes(); 
	    return attrs.getRequest(); 
	}
}
