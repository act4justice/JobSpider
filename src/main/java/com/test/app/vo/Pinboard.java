package com.test.app.vo;

public class Pinboard {
	private String per_id;
	private int pin_index;
	private String pin_date;
	private String pin_title;
	private String pin_contents;

	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public int getPin_index() {
		return pin_index;
	}

	public void setPin_index(int pin_index) {
		this.pin_index = pin_index;
	}

	public String getPin_date() {
		return pin_date;
	}

	public void setPin_date(String pin_date) {
		this.pin_date = pin_date;
	}

	public String getPin_title() {
		return pin_title;
	}

	public void setPin_title(String pin_title) {
		this.pin_title = pin_title;
	}

	public String getPin_contents() {
		return pin_contents;
	}

	public void setPin_contents(String pin_contents) {
		this.pin_contents = pin_contents;
	}

	@Override
	public String toString() {
		return "Pinboard [per_id=" + per_id + ", pin_date=" + pin_date + ", pin_title=" + pin_title + ", pin_contents="
				+ pin_contents + "]";
	}
}
