package com.test.app.vo;

public class Reply {
	private int reply_index;
	private String per_id;
	private String per_name;
	private String per_savedfile;
	private String reply_content;
	private String reply_date;
	private String scr_content;

	public int getReply_index() {
		return reply_index;
	}

	public void setReply_index(int reply_index) {
		this.reply_index = reply_index;
	}

	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getPer_name() {
		return per_name;
	}

	public void setPer_name(String per_name) {
		this.per_name = per_name;
	}

	public String getPer_savedfile() {
		return per_savedfile;
	}

	public void setPer_savedfile(String per_savedfile) {
		this.per_savedfile = per_savedfile;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public String getReply_date() {
		return reply_date;
	}

	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}

	public String getScr_content() {
		return scr_content;
	}

	public void setScr_content(String scr_content) {
		this.scr_content = scr_content;
	}

	@Override
	public String toString() {
		return "Reply [reply_index=" + reply_index + ", per_id=" + per_id + ", per_name=" + per_name
				+ ", per_savedfile=" + per_savedfile + ", reply_content=" + reply_content + ", reply_date=" + reply_date
				+ ", scr_content=" + scr_content + "]";
	}
	
}