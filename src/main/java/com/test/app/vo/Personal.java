package com.test.app.vo;

import org.springframework.web.multipart.MultipartFile;

public class Personal {
	private String per_id;
	private String per_pwd;
	private String per_name;
	private String per_phone;
	private String per_email;
	private String per_address;
	private String per_zipcode;
	private String per_emailsetting;
	private String per_originalfile;
	private String per_savedfile;
	private MultipartFile file;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getPer_pwd() {
		return per_pwd;
	}

	public void setPer_pwd(String per_pwd) {
		this.per_pwd = per_pwd;
	}

	public String getPer_name() {
		return per_name;
	}

	public void setPer_name(String per_name) {
		this.per_name = per_name;
	}

	public String getPer_phone() {
		return per_phone;
	}

	public void setPer_phone(String per_phone) {
		this.per_phone = per_phone;
	}

	public String getPer_email() {
		return per_email;
	}

	public void setPer_email(String per_email) {
		this.per_email = per_email;
	}

	public String getPer_address() {
		return per_address;
	}

	public void setPer_address(String per_address) {
		this.per_address = per_address;
	}

	public String getPer_zipcode() {
		return per_zipcode;
	}

	public void setPer_zipcode(String per_zipcode) {
		this.per_zipcode = per_zipcode;
	}

	public String getPer_originalfile() {
		return per_originalfile;
	}

	public void setPer_originalfile(String per_originalfile) {
		this.per_originalfile = per_originalfile;
	}

	public String getPer_savedfile() {
		return per_savedfile;
	}

	public void setPer_savedfile(String per_savedfile) {
		this.per_savedfile = per_savedfile;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getPer_emailsetting() {
		return per_emailsetting;
	}

	public void setPer_emailsetting(String per_emailsetting) {
		this.per_emailsetting = per_emailsetting;
	}

	@Override
	public String toString() {
		return "Personal [per_id=" + per_id + ", per_pwd=" + per_pwd + ", per_name=" + per_name + ", per_phone="
				+ per_phone + ", per_email=" + per_email + ", per_address=" + per_address + ", per_zipcode="
				+ per_zipcode + ", per_emailsetting=" + per_emailsetting + ", per_originalfile=" + per_originalfile
				+ ", per_savedfile=" + per_savedfile + ", file=" + file + "]";
	}
}