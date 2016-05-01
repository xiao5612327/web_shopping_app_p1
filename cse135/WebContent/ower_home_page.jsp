<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*"%>
<%@ page import="java.io.*,java.util.*"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home page</title>
</head>
<body>
	<%
		String user = (String) session.getAttribute("user_name");
		String roles = (String) session.getAttribute("roles");
	%>

	Welcome
	<%=roles%>
	<%=user%>
	
	<ul>
		<li><a href="categories.jsp">Categories Page</a></li>
		<li><a href="product.jsp">Product Page</a></li>
		<li><a href="product_browsing.jsp">Product browsing page</a></li>
		<li><a href="product_order.jsp">Product Order Page</a></li>
		<li><a href="shopping_cart.jsp">Buy Shopping Cart</a></li>
	</ul>

	

</body>
</html>