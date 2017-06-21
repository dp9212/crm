package cn.yysg.crm.domain;

/**
 * 
 * 字典值
 * 
 */
public class SystemDictionaryItem {
	private Long id;
	private String name;// 名字
	private Integer sequence = 100;// 排序
	private String intro;// 简介
	private SystemDictionary parent; // 所属字典目录
	
	public SystemDictionaryItem() {
		// TODO Auto-generated constructor stub
	}
	public SystemDictionaryItem(Long id) {
		this.id=id;
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

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public SystemDictionary getParent() {
		return parent;
	}

	public void setParent(SystemDictionary parent) {
		this.parent = parent;
	}

}
