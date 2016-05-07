package com.test.app.vo;

public class Scrap {
	private int scr_seq;
	private String per_id;
	private String scr_title;
	private String scr_subtitle;
	private String scr_date;
	private String scr_content;

	public Scrap() {
	}

	public int getScr_seq() {
		return scr_seq;
	}

	public void setScr_seq(int scr_seq) {
		this.scr_seq = scr_seq;
	}

	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getScr_title() {
		return scr_title;
	}

	public void setScr_title(String scr_title) {
		this.scr_title = scr_title;
	}

	public String getScr_subtitle() {
		return scr_subtitle;
	}

	public void setScr_subtitle(String scr_subtitle) {
		this.scr_subtitle = scr_subtitle;
	}

	public String getScr_date() {
		return scr_date;
	}

	public void setScr_date(String scr_date) {
		this.scr_date = scr_date;
	}

	public String getScr_content() {
		return scr_content;
	}

	public void setScr_content(String scr_content) {
		this.scr_content = scr_content;
	}

	@Override
	public String toString() {
		return "Scrap [scr_seq=" + scr_seq + ", per_id=" + per_id + ", scr_title=" + scr_title + ", scr_subtitle="
				+ scr_subtitle + ", scr_date=" + scr_date + ", scr_content=" + scr_content + "]";
	}

}
