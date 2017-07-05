package com.gigabox.admin.stat.vo;

public class UserStatVO {

	/*
	 * <resultMap type="userStat" id="userStatResultMap">
		<result property="time" column="TIME" />
		<result property="gender" column="GENDER" />
		<result property="count" column="COUNT" />
		<result property="age" column="AGE" />
	   </resultMap>
	 */
	
	private String time;		// '2017-07'
	private String gender;		// M or F
	private int count;			// 수
	private int age;			// 나이
	
	@Override
	public String toString() {
		return "UserStatVO [time=" + time + ", gender=" + gender + ", count=" + count + ", age=" + age + "]";
	}
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
}
