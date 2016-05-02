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
       
            <%-- -------- List of categories for saerch ------- --%>
            <%@ page import="java.sql.*"%>
            
            <% 
	        	Class.forName("org.postgresql.Driver");
	            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/shopping", "postgres", "Asdf!23");  
	            Statement statement = connection.createStatement() ;
	            PreparedStatement pstmt = null;
	            ResultSet resultset; 
	       	%>
	       	
	       	<%	
	       		resultset = statement.executeQuery("select count(*) from categories") ;
				resultset.next();
				int rowCount = Integer.parseInt(resultset.getString(1));
				String[] categories = new String[rowCount];
				resultset = statement.executeQuery("select category_name from categories") ;
			%>
			
			<% 	
				int index = 0;
				while(resultset.next()){ 
					categories[index] = resultset.getString(1);
					index++;
				}
			%>
        
        	<h2>Search categories</h2>
            <% 	
            	index = 0;
				while(index < rowCount){ 
					index++;
			%>
					<form action="product.jsp" method="get">
						<input type="submit" value="<%= categories[index-1] %>" style="width:200px">
						<% if (request.getParameter("search") == null) { %>
								<input type="hidden" name="search" value=""/>
						<% }
						   else { %>
						   		<input type="hidden" name="search" value="<%=request.getParameter("search")%>"/>
						<% } %>
						<input type="hidden" name='category' value="<%= categories[index-1] %>">
						
					</form>
			<% } %>
        </td>
        
        <td>
				

		
        <H1>Products</H1>

        
		
		<%-- -------- UPDATE category -------- --%>
        <%
        	String action = request.getParameter("action");
            // update is called
            if (action != null && action.equals("update")) {

            	// Begin communicate with database
                connection.setAutoCommit(false);

                // updata sql 
                pstmt = connection.prepareStatement("UPDATE products SET product_name = ?, sku = ?, price = ?, category = ? WHERE id=?");
                    
                pstmt.setString(1, request.getParameter("updated_name"));
                pstmt.setInt(2, Integer.parseInt(request.getParameter("updated_sku")));
                pstmt.setInt(3, Integer.parseInt(request.getParameter("updated_price")));
                pstmt.setString(4, request.getParameter("updated_category"));
                pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));
                int row = pstmt.executeUpdate();
                  
                // Commit communicate with database
                connection.commit();
                connection.setAutoCommit(true);
            }
        %>
            
        <%-- -------- DELETE catagory -------- --%>
        <%
            // Check if a delete is requested
            if (action != null && action.equals("delete")) {

                // Begin communicate with database
                connection.setAutoCommit(false);

                pstmt = connection.prepareStatement("DELETE FROM products WHERE id = ?");

                pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                int row = pstmt.executeUpdate();

                // Commit communicate with database
                connection.commit();
                connection.setAutoCommit(true);
            }
        %>
            
		<%-- -------- Product Insert -------- --%>
		<H2>Product Insert</H2>
		
		<form action="product_insert.jsp" method="post">
			<br> Product name: <input type='text' name='product_name'>
			<br> Product SKU: <input type='text' name='product_sku'>
			<br> Category: <select name='product_category'>
					<option value=' '> </option>
					<% 	index = 0;
						while(index < rowCount){ 
							index++;
					%>
						<option value='<%= categories[index-1] %>'> <%= categories[index-1] %> </option>
					<% } %>
				</select>
			<br> Product price: <input type='text' name='product_price'>
			<input type="submit" value="Insert New Product">
		</form>
		
		<%-- -------- Product Search -------- --%>
		<h2>Product Search</h2>
		<form action="product.jsp" method="post">
		  	<br> Search query: <input type='text' name='search'>
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
					<input type="hidden" name="id" value="<%=resultset.getInt("id")%>"/>
                <%-- a id to track all insert delete and update --%>
                <td>
                    <input value="<%=resultset.getString("product_name")%>" name="updated_name" size="15"/>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("sku")%>" name="updated_sku" size="15"/>
                </td>
                
                <td>
                	<select name='updated_category'>
                		<% String default_category = resultset.getString("category"); %>
						<option selected=<%=default_category%>><%=default_category%></option>
					<% 	index = 0;
						while(index < rowCount){ 
							index++;
							if(categories[index-1].equals(resultset.getString("category")))
								continue;
					%>
						<option value='<%= categories[index-1] %>'> <%= categories[index-1] %> </option>
					<% } %>
					</select>
                </td>
                
                <td>
                    <input value="<%=resultset.getString("price")%>" name="updated_price" size="15"/>
                </td>


                <td><input type="submit" value="Update"></td>
                </form>
                
                <form action="product.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
					<input type="hidden" name="id" value="<%=resultset.getInt("id")%>"/>
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