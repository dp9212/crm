package cn.yysg.crm.domain;

import java.util.ArrayList;
import java.util.List;

public class Department {

	private Long id;
	private String name;// 部门名称,非空
	private String sn;// 部门编号,非空
	private String dirPath;// 部门路径，用来查询所有后代部门
	private Employee manager;// 部门经理
	private Department parent;// 上级部门
	private List<Department> children = new ArrayList<Department>();// 子部门

	public Department() {
	}

	public Department(Long id, String name, String sn, String dirPath, Employee manager, Department parent,
			List<Department> children) {
		this.id = id;
		this.name = name;
		this.sn = sn;
		this.dirPath = dirPath;
		this.manager = manager;
		this.parent = parent;
		this.children = children;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSn() {
		return sn;
	}
	public String getText() {
		return name;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getDirPath() {
		return dirPath;
	}

	public void setDirPath(String dirPath) {
		this.dirPath = dirPath;
	}

	public Employee getManager() {
		return manager;
	}

	public void setManager(Employee manager) {
		this.manager = manager;
	}

	public Department getParent() {
		return parent;
	}

	public void setParent(Department parent) {
		this.parent = parent;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		return "Department [id=" + id + ", name=" + name + ", sn=" + sn + ", dirPath=" + dirPath + "]";
	}

}
