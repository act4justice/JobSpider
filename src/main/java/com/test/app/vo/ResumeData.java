package com.test.app.vo;

import java.util.List;

public class ResumeData {
	private Personal personal;
	private List<Education> eduList;
	private List<Career> carList;
	private List<Certificate> cerList;
	private List<Award> awaList;
	private List<Introduce> introduceList;

	public Personal getPersonal() {
		return personal;
	}

	public void setPersonal(Personal personal) {
		this.personal = personal;
	}

	public List<Education> getEduList() {
		return eduList;
	}

	public void setEduList(List<Education> eduList) {
		this.eduList = eduList;
	}

	public List<Career> getCarList() {
		return carList;
	}

	public void setCarList(List<Career> carList) {
		this.carList = carList;
	}

	public List<Certificate> getCerList() {
		return cerList;
	}

	public void setCerList(List<Certificate> cerList) {
		this.cerList = cerList;
	}

	public List<Award> getAwaList() {
		return awaList;
	}

	public void setAwaList(List<Award> awaList) {
		this.awaList = awaList;
	}

	public List<Introduce> getIntroduceList() {
		return introduceList;
	}

	public void setIntroduceList(List<Introduce> introduceList) {
		this.introduceList = introduceList;
	}

	@Override
	public String toString() {
		return "ResumeData [personal=" + personal + ", eduList=" + eduList + ", carList=" + carList + ", cerList="
				+ cerList + ", awaList=" + awaList + ", introduceList=" + introduceList + "]";
	}
}
