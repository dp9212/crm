package cn.yysg.crm.domain;

import java.util.ArrayList;
import java.util.List;

public class Menu {
	private Long id;
	private String sn;
	private String name;
	private String icon;// 图标
	private String intro;// 描述
	private String url;// 跳转地址
	
	private Menu parent;// 自关联id 数据库parent_id 单向多对一
	private List<Menu> children = new ArrayList<Menu>();// 子菜单

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getName() {
		return name;
	}
	
	public String getText() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		return "Menu [id=" + id + ", sn=" + sn + ", name=" + name + ", icon=" + icon + ", intro=" + intro + ", url="
				+ url + "]";
	}

}
