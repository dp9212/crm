package cn.yysg.crm.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CustomerResourcePool {

	
	private Long id;
	// 基本资料
	private String name;
	// 0男 1女 2未知
	private Integer gender;
	// 年龄
	private Integer age;
	// 联系方式
	private String tel;
	private String email;
	private String qq;
	private String wechat;
	private String address;
	private Date inputTime = new Date();

	private Employee seller;// 营销人员
	private Employee inputUser;// 创建人
	// 扩展信息
	private SystemDictionaryItem job;// 客户职业
	private SystemDictionaryItem source;// 客户来源
	private SystemDictionaryItem salaryLevel; // 薪资等级

	public CustomerResourcePool(long id) {
		this.id=id;
	}

	public CustomerResourcePool() {
		super();
		// TODO Auto-generated constructor stub
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	public Date getInputTime() {
		return inputTime;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public SystemDictionaryItem getJob() {
		return job;
	}

	public void setJob(SystemDictionaryItem job) {
		this.job = job;
	}

	public SystemDictionaryItem getSource() {
		return source;
	}

	public void setSource(SystemDictionaryItem source) {
		this.source = source;
	}

	public SystemDictionaryItem getSalaryLevel() {
		return salaryLevel;
	}

	public void setSalaryLevel(SystemDictionaryItem salaryLevel) {
		this.salaryLevel = salaryLevel;
	}

	public Employee getInputUser() {
		return inputUser;
	}

	public void setInputUser(Employee inputUser) {
		this.inputUser = inputUser;
	}

	public Employee getSeller() {
		return seller;
	}

	public void setSeller(Employee seller) {
		this.seller = seller;
	}

	@Override
	public String toString() {
		return "CustomerResourcePool [id=" + id + ", name=" + name + ", gender=" + gender + ", age=" + age + ", tel="
				+ tel + ", email=" + email + ", qq=" + qq + ", wechat=" + wechat + ", address=" + address
				+ ", inputTime=" + inputTime + ", seller=" + seller + ", inputUser=" + inputUser + ", job=" + job
				+ ", source=" + source + ", salaryLevel=" + salaryLevel + "]";
	}

	

	
	
	
}
