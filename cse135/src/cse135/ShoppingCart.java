/**
 * 
 */
package cse135;

/**
 * @author xiaopingweng
 *
 */
public class ShoppingCart {
	private String product;
	private int amount;
	private int price;

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public ShoppingCart() {
		super();
		this.product = "";
		this.amount = 0;
		this.price = 0;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public ShoppingCart(String product, int amount, int price) {
		super();
		this.product = product;
		this.amount = amount;
		this.price = price;
	}


}
