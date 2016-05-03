<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*"%>
<%@ page import="java.io.*,java.util.*"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home page</title>

	<SCRIPT TYPE="text/javascript">
	function accessCheck()
	{
		if(roles.equals("customer")){
			
			alert("This page is available to onwers only.");
			request.redirect("ower_home_page.jsp");
		}
	}
	</SCRIPT>
	
</head>
<body>
	<%
		
		String user = (String) session.getAttribute("user_name");
		String roles = (String) session.getAttribute("roles");

		if(user == null){%>
			<SCRIPT TYPE="text/javascript">
			alert("Request is invalid!");
			window.location.href = "log_in.jsp"
			</SCRIPT>
		<%}
	%>

	<h1>Welcome: <%=roles%> <%=user%></h1>

	<form action="log_in.jsp" method="post">
		<% session.setAttribute("user_name" , null);%>
		<INPUT TYPE=SUBMIT VALUE="Log out">
	</form>
	
	<ul>
		<%if(roles.equals("owner")) {%>
			<li><a type="accessCheck()" href="categories.jsp" >Categories Page</a></li>
			<li><a href="product.jsp">Product Page</a></li>
		<%}%>
		<li><a href="product_browsing.jsp">Product browsing page</a></li>
		<li><a href="product_order.jsp">Product Order Page</a></li>
		<li><a href="shopping_cart.jsp">Buy Shopping Cart</a></li>
	</ul>

	

</body>
</html>