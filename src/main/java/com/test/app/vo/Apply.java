package com.test.app.vo;

public class Apply {
	private int rec_index;
	private String rec_duty;
	private String per_id;
	private String per_savedfile;
	private String per_name;
	private String com_id;

	public int getRec_index() {
		return rec_index;
	}

	public void setRec_index(int rec_index) {
		this.rec_index = rec_index;
	}

	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getCom_id() {
		return com_id;
	}

	public void setCom_id(String com_id) {
		this.com_id = com_id;
	}

	public String getPer_savedfile() {
		return per_savedfile;
	}

	public void setPer_savedfile(String per_savedfile) {
		this.per_savedfile = per_savedfile;
	}

	public String getRec_duty() {
		return rec_duty;
	}

	public void setRec_duty(String rec_duty) {
		this.rec_duty = rec_duty;
	}

	public String getPer_name() {
		return per_name;
	}

	public void setPer_name(String per_name) {
		this.per_name = per_name;
	}

	@Override
	public String toString() {
		return "Apply [rec_index=" + rec_index + ", rec_duty=" + rec_duty + ", per_id=" + per_id + ", per_savedfile="
				+ per_savedfile + ", per_name=" + per_name + ", com_id=" + com_id + "]";
	}

}