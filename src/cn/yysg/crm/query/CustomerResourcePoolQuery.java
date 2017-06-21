package cn.yysg.crm.query;

public class CustomerResourcePoolQuery extends BaseQuery{
	private String name;
	private Integer gender;
	private Integer age;
	private Long seller_id;
	private Long inputuser_id;
	
@Override
	public String toString() {
		return "CustomerQuery [name=" + name + ", gender=" + gender + ", age=" + age + ", seller_id=" + seller_id
				+ ", inputuser_id=" + inputuser_id + "]";
	}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public Integer getGender() {
	return gender;
}

public void setGender(Integer gender) {
	this.gender = gender;
}

public Integer getAge() {
	return age;
}

public void setAge(Integer age) {
	this.age = age;
}

public Long getSeller_id() {
	return seller_id;
}

public void setSeller_id(Long seller_id) {
	this.seller_id = seller_id;
}

public Long getInputuser_id() {
	return inputuser_id;
}

public void setInputuser_id(Long inputuser_id) {
	this.inputuser_id = inputuser_id;
}

public CustomerResourcePoolQuery(String name, Integer gender, Integer age, Long seller_id, Long inputuser_id) {
		super();
		this.name = name;
		this.gender = gender;
		this.age = age;
		this.seller_id = seller_id;
		this.inputuser_id = inputuser_id;
	}

public CustomerResourcePoolQuery() {
		super();
		// TODO Auto-generated constructor stub
	}

@Override
public void setSort(String sort) {
	if("seller".equals(sort)){
		this.sort="seller_id";
	}else if("inputUser".equals(sort)){
		this.sort="inputuser_id";
	}else if("salaryLevel".equals(sort)){
	this.sort="salaryLevel_id";
}
	super.setSort(this.sort);
}
}
	

