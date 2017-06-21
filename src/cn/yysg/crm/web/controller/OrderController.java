package cn.yysg.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Order;
import cn.yysg.crm.query.OrderQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IOrderService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private IOrderService orderService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "order/list";
	}
	@RequestMapping("/data")
	public String data() {
		return "order/data";
	}

	// 从列表页面发出ajax请求获取json数据
	  @RequestMapping("/json")
	  @ResponseBody
	  public PageList<Order> json(OrderQuery cq) {
		  return orderService.getPageList(cq);
	  }
	// Map:{"success":true,"msg":"xxxxx"}
	// JsonResult:{"success":true,"msg":"xxxxx"}
	// 处理save
	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Order order) {
		try {
			if (order.getId() == null) {
				orderService.save(order);
			} else {
				orderService.update(order);
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
				orderService.delete(id);
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
	public List<Order> getListData(){
		return orderService.getAll();
	}
}
