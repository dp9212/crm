package cn.yysg.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yysg.crm.domain.Department;
import cn.yysg.crm.query.DepartmentQuery;
import cn.yysg.crm.query.PageList;
import cn.yysg.crm.service.IDepartmentService;
import cn.yysg.crm.util.JsonResult;

@Controller
@RequestMapping("/department")
public class DepartmentController {
	@Autowired
	private IDepartmentService departmentService;

	// 显示列表页面
	@RequestMapping("/list")
	public String list() {
		return "department/list";
	}

	@RequestMapping("/json")
	@ResponseBody
	public PageList<Department> json(DepartmentQuery qo) {
		return departmentService.getPageList(qo);
	}

	@RequestMapping("/save")
	@ResponseBody
	public JsonResult save(Department department) {
		try {
			if (department.getId() == null) {
				departmentService.save(department);
			} else {
				departmentService.update(department);
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
				departmentService.delete(id);
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
	public List<Department> getListData(){
		return departmentService.getDept();
	}
	
	
	@RequestMapping("/getTreeData")
	@ResponseBody
	public List<Department> getTreeData(){
		return departmentService.getTreeData();
	}
}
