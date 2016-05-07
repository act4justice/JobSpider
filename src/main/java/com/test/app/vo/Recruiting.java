package com.test.app.vo;

import org.springframework.web.multipart.MultipartFile;

public class Recruiting {
	private String com_id;
	private int rec_index;
	private String rec_duty;
	private String rec_requirement;
	private String rec_memnum;
	private String rec_location;
	private String rec_day;
	private String rec_department;
	private String rec_salary;
	private String rec_position;
	private String rec_welfare;
	private String rec_procedure;
	private String rec_docs;
	private String rec_submitway;
	private String rec_startdate;
	private String rec_enddate;
	private String rec_originalfile;
	private String rec_savedfile;
	private MultipartFile file;
	private String com_name;
	private String dday;
	private boolean like;

	private int apply_num = 0;

	// setter, getter, toString

	public String getCom_id() {
		return com_id;
	}

	public boolean isLike() {
		return like;
	}

	public void setLike(boolean like) {
		this.like = like;
	}

	public void setCom_id(String com_id) {
		this.com_id = com_id;
	}

	public int getRec_index() {
		return rec_index;
	}

	public void setRec_index(int rec_index) {
		this.rec_index = rec_index;
	}

	public String getRec_duty() {
		return rec_duty;
	}

	public void setRec_duty(String rec_duty) {
		this.rec_duty = rec_duty;
	}

	public String getRec_requirement() {
		return rec_requirement;
	}

	public void setRec_requirement(String rec_requirement) {
		this.rec_requirement = rec_requirement;
	}

	public String getRec_memnum() {
		return rec_memnum;
	}

	public void setRec_memnum(String rec_memnum) {
		this.rec_memnum = rec_memnum;
	}

	public String getRec_location() {
		return rec_location;
	}

	public void setRec_location(String rec_location) {
		this.rec_location = rec_location;
	}

	public String getRec_day() {
		return rec_day;
	}

	public void setRec_day(String rec_day) {
		this.rec_day = rec_day;
	}

	public String getRec_department() {
		return rec_department;
	}

	public void setRec_department(String rec_department) {
		this.rec_department = rec_department;
	}

	public String getRec_salary() {
		return rec_salary;
	}

	public void setRec_salary(String rec_salary) {
		this.rec_salary = rec_salary;
	}

	public String getRec_position() {
		return rec_position;
	}

	public void setRec_position(String rec_position) {
		this.rec_position = rec_position;
	}

	public String getRec_welfare() {
		return rec_welfare;
	}

	public void setRec_welfare(String rec_welfare) {
		this.rec_welfare = rec_welfare;
	}

	public String getRec_procedure() {
		return rec_procedure;
	}

	public void setRec_procedure(String rec_procedure) {
		this.rec_procedure = rec_procedure;
	}

	public String getRec_docs() {
		return rec_docs;
	}

	public void setRec_docs(String rec_docs) {
		this.rec_docs = rec_docs;
	}

	public String getRec_submitway() {
		return rec_submitway;
	}

	public void setRec_submitway(String rec_submitway) {
		this.rec_submitway = rec_submitway;
	}

	public String getRec_startdate() {
		return rec_startdate;
	}

	public void setRec_startdate(String rec_startdate) {
		this.rec_startdate = rec_startdate;
	}

	public String getRec_enddate() {
		return rec_enddate;
	}

	public void setRec_enddate(String rec_enddate) {
		this.rec_enddate = rec_enddate;
	}

	public String getCom_name() {
		return com_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	public String getDday() {
		return dday;
	}

	public void setDday(String dday) {
		this.dday = dday;
	}

	public String getRec_originalfile() {
		return rec_originalfile;
	}

	public void setRec_originalfile(String rec_originalfile) {
		this.rec_originalfile = rec_originalfile;
	}

	public String getRec_savedfile() {
		return rec_savedfile;
	}

	public void setRec_savedfile(String rec_savedfile) {
		this.rec_savedfile = rec_savedfile;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public int getApply_num() {
		return apply_num;
	}

	public void setApply_num(int apply_num) {
		this.apply_num = apply_num;
	}

	@Override
	public String toString() {
		return "Recruiting [com_id=" + com_id + ", rec_index=" + rec_index + ", rec_duty=" + rec_duty
				+ ", rec_requirement=" + rec_requirement + ", rec_memnum=" + rec_memnum + ", rec_location="
				+ rec_location + ", rec_day=" + rec_day + ", rec_department=" + rec_department + ", rec_salary="
				+ rec_salary + ", rec_position=" + rec_position + ", rec_welfare=" + rec_welfare + ", rec_procedure="
				+ rec_procedure + ", rec_docs=" + rec_docs + ", rec_submitway=" + rec_submitway + ", rec_startdate="
				+ rec_startdate + ", rec_enddate=" + rec_enddate + ", rec_originalfile=" + rec_originalfile
				+ ", rec_savedfile=" + rec_savedfile + ", file=" + file + ", com_name=" + com_name + ", dday=" + dday
				+ ", like=" + like + "]";
	}

}
