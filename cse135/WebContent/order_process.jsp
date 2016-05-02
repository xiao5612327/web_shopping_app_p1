<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@page import="java.util.*, cse135.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<SCRIPT TYPE="text/javascript">
	function invalidAmount()
	{
		alert("Invalid Amount, you must choose at least 1.");
	}
	</SCRIPT>
	<% 
		String quantity = request.getParameter("amount");
		String product = (String)session.getAttribute("product_name");
		String price = (String)session.getAttribute("product_price");
		connectJDBC conn = new connectJDBC();
		if ( quantity == null || quantity.trim().length() == 0 )
		{ %>
			<script> invalidAmount(); </script>
			<script language="javascript">
   				window.location.href = "product_browsing.jsp"
			</script>
		<% }
		else{
			if(Integer.parseInt(quantity) <=0){
				 %>
					<script> invalidAmount(); </script>
					<script language="javascript">
		   				window.location.href = "product_browsing.jsp"
					</script>
				<%
			}
			else{
		
				conn.insertShopping(product, quantity, price);
			}	
		}
		
	%>
	<script language="javascript">
   		window.location.href = "product_browsing.jsp"
	</script>
</body>
</html>