package com.test.app.vo;

public class Certificate {
	private String per_id;
	private String cer_cername;
	private String cer_date;
	private String cer_grade;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getCer_cername() {
		return cer_cername;
	}

	public void setCer_cername(String cer_cername) {
		this.cer_cername = cer_cername;
	}

	public String getCer_date() {
		return cer_date;
	}

	public void setCer_date(String cer_date) {
		this.cer_date = cer_date;
	}

	public String getCer_grade() {
		return cer_grade;
	}

	public void setCer_grade(String cer_grade) {
		this.cer_grade = cer_grade;
	}

	@Override
	public String toString() {
		return "Certificate [per_id=" + per_id + ", cer_cername=" + cer_cername + ", cer_date=" + cer_date
				+ ", cer_grade=" + cer_grade + "]";
	}
}
