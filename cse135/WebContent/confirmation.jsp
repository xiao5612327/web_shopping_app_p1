<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<table>

	<%
		String user = (String) session.getAttribute("user_name");

	%>
	<br>
	<h1>Welcome: <%=user%></h1>
	
    <tr>     
        <td>
		<%@ page import="java.sql.*"%>

        <H1>Products Bought:</H1>

        <% 
        	Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
            Statement statement = connection.createStatement() ;
            ResultSet resultset; 
        %>

        <%-- -------- Product Table -------- --%>
		<%
			resultset = statement.executeQuery("select name from shopping_cart") ; 
        %>
        <!-- html table format -->
            <table border="1">
            <tr>                
            	<th>Name</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (resultset.next()) {
            %>

            <tr>
                <form action="product_order.jsp" method="POST">

                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("name")%>" name="shopping_cart_name" size="15"/>
                </td>

                </form>
            </tr>

            <%
                }
            %>
        </td>
    </tr>
</table>
</body>
<br>
<a href="product_browsing.jsp" >Product Browsing</a>

</html>