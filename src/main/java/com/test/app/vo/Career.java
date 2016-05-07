package com.test.app.vo;

public class Career {
	private String per_id;
	private String car_comname;
	private String car_startdate;
	private String car_enddate;
	private String car_department;
	private String car_duty;

	// setter, getter, toString
	public String getPer_id() {
		return per_id;
	}

	public void setPer_id(String per_id) {
		this.per_id = per_id;
	}

	public String getCar_comname() {
		return car_comname;
	}

	public void setCar_comname(String car_comname) {
		this.car_comname = car_comname;
	}

	public String getCar_startdate() {
		return car_startdate;
	}

	public void setCar_startdate(String car_startdate) {
		this.car_startdate = car_startdate;
	}

	public String getCar_enddate() {
		return car_enddate;
	}

	public void setCar_enddate(String car_enddate) {
		this.car_enddate = car_enddate;
	}

	public String getCar_department() {
		return car_department;
	}

	public void setCar_department(String car_department) {
		this.car_department = car_department;
	}

	public String getCar_duty() {
		return car_duty;
	}

	public void setCar_duty(String car_duty) {
		this.car_duty = car_duty;
	}

	@Override
	public String toString() {
		return "Career [per_id=" + per_id + ", car_comname=" + car_comname + ", car_startdate=" + car_startdate
				+ ", car_enddate=" + car_enddate + ", car_department=" + car_department + ", car_duty=" + car_duty
				+ "]";
	}
}
