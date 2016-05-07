package com.test.app.vo;

public class Award {
	private String per_id;
	private String awa_name;
	private String awa_date;
	private String awa_detail;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getAwa_name() {
		return awa_name;
	}

	public void setAwa_name(String awa_name) {
		this.awa_name = awa_name;
	}

	public String getAwa_date() {
		return awa_date;
	}

	public void setAwa_date(String awa_date) {
		this.awa_date = awa_date;
	}

	public String getAwa_detail() {
		return awa_detail;
	}

	public void setAwa_detail(String awa_detail) {
		this.awa_detail = awa_detail;
	}

	@Override
	public String toString() {
		return "Award [per_id=" + per_id + ", awa_name=" + awa_name + ", awa_date=" + awa_date + ", awa_detail="
				+ awa_detail + "]";
	}
}
