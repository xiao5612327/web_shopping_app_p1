<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.lang.*"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<SCRIPT TYPE="text/javascript">
	function invalidName()
	{
		alert("Invalid product name.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidSKU()
	{
		alert("Not a unique product SKU.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidCategory()
	{
		alert("No product category provided.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function invalidPrice()
	{
		alert("Invalid product price.");
	}
	</SCRIPT>
	
	<SCRIPT TYPE="text/javascript">
	function inserted()
	{
		alert("Inserted new product.");
	}
	</SCRIPT>
	
	<%
		String name = request.getParameter("product_name");
		String sku = request.getParameter("product_sku");
		String category = request.getParameter("product_category");
		String price = request.getParameter("product_price");
		double priceDouble = -1.0;
		if ( price == null || price.trim().length() == 0 ) {}
		else priceDouble = Double.parseDouble(price);
	
		connectJDBC conn = new connectJDBC();
		
		// Check if valid name
		if ( name == null || name.trim().length() == 0 )
		{ %>
			<script> invalidName(); </script>
			<script language="javascript">
   				window.location.href = "product.jsp"
			</script>
		<% }
		
		// Check if SKU isn't unique
		else if ( sku == null || sku.trim().length() == 0 || !conn.checkSKU(sku))
		{ %>
			<script> invalidSKU(); </script>
			<script language="javascript">
   				window.location.href = "product.jsp"
			</script>
		<% }
		
		// Check if category wasn't provided
		else if ( category == null || category.trim().length() == 0 || category.equals(" "))
		{ %>
			<script> invalidCategory(); </script>
			<script language="javascript">
   				window.location.href = "product.jsp"
			</script>
		<% }
		
		// Check if price is positive
		else if ( price == null || price.trim().length() == 0 || priceDouble < 0.0)
		{ %>
			<script> invalidPrice(); </script>
			<script language="javascript">
   				window.location.href = "product.jsp"
			</script>
		<% }
		
		else
			conn.insertProduct(name, sku, category, price);
	%>
	
	<script> inserted(); </script>
	
	<script language="javascript">
   		window.location.href = "product.jsp"
	</script>
</body>
</html>