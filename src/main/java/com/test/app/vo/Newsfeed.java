package com.test.app.vo;

import java.io.Serializable;

public class Newsfeed implements Serializable {
	/**
	* 
	*/
	private static final long serialVersionUID = -8182019410322826792L;
	private String nf_url;
	private String nf_title;
	private String nf_subtitle;
	private String nf_date;
	private String nf_content;
	private String per_interestcom;

	public Newsfeed() {
		// TODO Auto-generated constructor stub
	}

	public String getNf_title() {
		return nf_title;
	}

	public void setNf_title(String nf_title) {
		this.nf_title = nf_title;
	}

	public String getNf_subtitle() {
		return nf_subtitle;
	}

	public void setNf_subtitle(String nf_subtitle) {
		this.nf_subtitle = nf_subtitle;
	}

	public String getNf_date() {
		return nf_date;
	}

	public void setNf_date(String nf_date) {
		this.nf_date = nf_date;
	}

	public String getNf_content() {
		return nf_content;
	}

	public void setNf_content(String nf_content) {
		this.nf_content = nf_content;
	}

	public String getNf_url() {
		return nf_url;
	}

	public void setNf_url(String nf_url) {
		this.nf_url = nf_url;
	}

	public String getPer_interestcom() {
		return per_interestcom;
	}

	public void setPer_interestcom(String per_interestcom) {
		this.per_interestcom = per_interestcom;
	}

	@Override
	public String toString() {
		return "Newsfeed [nf_url=" + nf_url + ", nf_title=" + nf_title + ", nf_subtitle=" + nf_subtitle + ", nf_date="
				+ nf_date + ", nf_content=" + nf_content + ", per_interestcom=" + per_interestcom + "]";
	}

}