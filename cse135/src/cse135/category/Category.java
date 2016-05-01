package cse135.category;

/**
 * @author xiaopingweng
 *
 */
public class Category {

	private String name;
	private String description;

	public Category() {
		super();
		name = "";
		description = "";
	}
	public Category(String name, String description) {
		super();
		this.name = name;
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
