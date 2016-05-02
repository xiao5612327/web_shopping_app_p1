<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<HTML>
    <HEAD>
        <TITLE>Products</TITLE>
    </HEAD>

    <BODY>
    
<table>
    <tr>
        <td valign="top">
            <%-- -------- import page from home page -------- --%>
            <jsp:include page="ower_home_page.jsp" />
        </td>
        
        <td>
				<%@ page import="java.sql.*"%>

		
        <H1>Products</H1>

        <% 
        	Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
            Statement statement = connection.createStatement() ;
            ResultSet resultset; 
        %>
		
		<%-- -------- Product Insert -------- --%>
		<H2>Product Insert</H2>
		<%	resultset = statement.executeQuery("select category_name from categories") ; %>
		<form action="product_insert.jsp" method="post">
			<br> Product name: <input type='text' name='product_name'>
			<br> Product SKU: <input type='text' name='product_sku'>
			<br> Category: <select name='product_category'>
					<option value=' '> </option>
					<% while(resultset.next()){ %>
						<option value='<%= resultset.getString(1) %>'> <%= resultset.getString(1) %> </option>
					<% } %>
				</select>
			<br> Product price: <input type='text' name='product_price'>
			<input type="submit" value="Insert New Product">
		</form>
		
		<%-- -------- Product Search -------- --%>
		<h2>Product Search</h2>
		<%    resultset = statement.executeQuery("select category_name from categories") ; %>
		<form action="product.jsp" method="post">
		  	<br> Search query: <input type='text' name='search'>
			<br> Category: <select name='category'>
				<option value=' '> </option>
				<% while(resultset.next()){ %>
					<option value='<%= resultset.getString(1) %>'> <%= resultset.getString(1) %> </option>
				<% } %>
			</select>
		  	<input type="submit" value="Search">
		</form>
        
        <%-- -------- Product Table -------- --%>
		<%
			String search = request.getParameter("search");
			String category;
			category = request.getParameter("category");
			if (category == null || category.equals(" "))
		    	resultset = statement.executeQuery("select * from products where LOWER(product_name) like LOWER('%"+search+"%')"); 
			else
				resultset = statement.executeQuery("select * from products where LOWER(product_name) like LOWER('%"+search+"%') and category = '"+category+"'"); 
        %>
        <!-- html table format -->
            <table border="1">
            <tr>                
            	<th>Name</th>
            	<th>SKU</th>
                <th>Category</th>
                <th>Price</th>
   
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (resultset.next()) {
            %>

            <tr>
                <form action="product.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>

                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("product_name")%>" name="updated_name" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("sku")%>" name="updated_sku" size="15"/>
                </td>
                
                <td>
                	<input value="<%=resultset.getString("category")%>" name="updated_category" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("price")%>" name="updated_price" size="15"/>
                </td>


                <td><input type="submit" value="Update"></td>
                </form>
                
                <form action="product.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            </tr>

            <%
                }
            %>
        
        </td>
    </tr>
</table>
    </BODY>
</HTML>