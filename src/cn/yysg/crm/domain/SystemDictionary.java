package cn.yysg.crm.domain;

import java.util.List;

/**
 * 
 * 字典目录
 * 
 */
public class SystemDictionary {
	private Long id;
	private String sn;// 序号
	private String name;// 名字
	private String intro;// 简介
	private Integer state = 1;// 状态:1:正常(默认),-1:作废
	private List<SystemDictionaryItem> items; //字典目录值
	
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

	public void setName(String name) {
		this.name = name;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public List<SystemDictionaryItem> getItems() {
		return items;
	}

	public void setItems(List<SystemDictionaryItem> items) {
		this.items = items;
	}

	
}
