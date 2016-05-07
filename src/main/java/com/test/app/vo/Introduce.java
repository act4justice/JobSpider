package com.test.app.vo;

public class Introduce {
	private String per_id;
	private String intro_title;
	private String intro_contents;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getIntro_title() {
		return intro_title;
	}

	public void setIntro_title(String intro_title) {
		this.intro_title = intro_title;
	}

	public String getIntro_contents() {
		return intro_contents;
	}

	public void setIntro_contents(String intro_contents) {
		this.intro_contents = intro_contents;
	}

	@Override
	public String toString() {
		return "Introduce [per_id=" + per_id + ", intro_title=" + intro_title + ", intro_contents=" + intro_contents
				+ "]";
	}
}
