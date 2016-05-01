package cse135;

public class User {
	private String user_name;
	private String roles;
	private int age;
	private String state;

	public User() {
		super();
		this.user_name = "";
		this.roles = "";
		this.age = 0;
		this.state = "";
	}

	public User(String user_name, String roles, int age, String state) {
		super();
		this.user_name = user_name;
		this.roles = roles;
		this.age = age;
		this.state = state;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}
