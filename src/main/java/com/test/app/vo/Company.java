package com.test.app.vo;

public class Company {
	private String com_id;
	private String com_pwd;
	private int com_num;
	private String com_name;
	private String com_mgrName;
	private String com_address;
	private String com_zipcode;
	private String com_phone;
	private String com_email;

	// setter, getter, toString
	public String getCom_id() {
		return com_id;
	}

	public void setCom_id(String com_id) {
		this.com_id = com_id;
	}

	public String getCom_pwd() {
		return com_pwd;
	}

	public void setCom_pwd(String com_pwd) {
		this.com_pwd = com_pwd;
	}

	public int getCom_num() {
		return com_num;
	}

	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}

	public String getCom_name() {
		return com_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	public String getCom_mgrName() {
		return com_mgrName;
	}

	public void setCom_mgrName(String com_mgrName) {
		this.com_mgrName = com_mgrName;
	}

	public String getCom_address() {
		return com_address;
	}

	public void setCom_address(String com_address) {
		this.com_address = com_address;
	}

	public String getCom_zipcode() {
		return com_zipcode;
	}

	public void setCom_zipcode(String com_zipcode) {
		this.com_zipcode = com_zipcode;
	}

	public String getCom_phone() {
		return com_phone;
	}

	public void setCom_phone(String com_phone) {
		this.com_phone = com_phone;
	}

	public String getCom_email() {
		return com_email;
	}

	public void setCom_email(String com_email) {
		this.com_email = com_email;
	}

	@Override
	public String toString() {
		return "Company [com_id=" + com_id + ", com_pwd=" + com_pwd + ", com_num=" + com_num + ", com_name=" + com_name
				+ ", com_mgrName=" + com_mgrName + ", com_address=" + com_address + ", com_zipcode=" + com_zipcode
				+ ", com_phone=" + com_phone + ", com_email=" + com_email + "]";
	}
}
