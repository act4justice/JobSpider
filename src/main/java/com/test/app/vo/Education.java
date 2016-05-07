package com.test.app.vo;

public class Education {
	private String per_id;
	private String edu_startdate;
	private String edu_enddate;
	private String edu_scname;
	private String edu_major;
	private String edu_graduation;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getEdu_startdate() {
		return edu_startdate;
	}

	public void setEdu_startdate(String edu_startdate) {
		this.edu_startdate = edu_startdate;
	}

	public String getEdu_enddate() {
		return edu_enddate;
	}

	public void setEdu_enddate(String edu_enddate) {
		this.edu_enddate = edu_enddate;
	}

	public String getEdu_scname() {
		return edu_scname;
	}

	public void setEdu_scname(String edu_scname) {
		this.edu_scname = edu_scname;
	}

	public String getEdu_major() {
		return edu_major;
	}

	public void setEdu_major(String edu_major) {
		this.edu_major = edu_major;
	}

	public String getEdu_graduation() {
		return edu_graduation;
	}

	public void setEdu_graduation(String edu_graduation) {
		this.edu_graduation = edu_graduation;
	}

	@Override
	public String toString() {
		return "Education [per_id=" + per_id + ", edu_startdate=" + edu_startdate + ", edu_enddate=" + edu_enddate
				+ ", edu_scname=" + edu_scname + ", edu_major=" + edu_major + ", edu_graduation=" + edu_graduation
				+ "]";
	}

}
