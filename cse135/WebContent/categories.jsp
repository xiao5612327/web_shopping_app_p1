<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   
<head>

<%@page import="java.util.*, cse135.category.*" %>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Category Page</title>

  
</head>
<body>
	<% 
		String roles = (String) session.getAttribute("roles");

		if(roles == null){
			if(roles.equals("customer")){%>
			<SCRIPT TYPE="text/javascript">
			alert("Request is invalid!");
			window.location.href = "log_in.jsp"
			</SCRIPT>
		<%}
		}%>
<table>
    <tr>
    
        <td valign="top">
            <%-- -------- import page from home page -------- --%>
            <jsp:include page="ower_home_page.jsp" />
        </td>
        <td>
				<%@ page import="java.sql.*"%>
				 <% session.setAttribute("id", 0); %>
            <%-- -------- connect to database -------- --%>
            <%
            Connection c =  null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
     
            try {
            	Class.forName("org.postgresql.Driver");
    			c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/shopping", "postgres", "Asdf!23");
    			
    			ResultSet resultset = null; 
            	Statement statement1 = c.createStatement() ;
            	
            %>
            
            <%-- -------- INSERT category -------- --%>
            <%
                String action = request.getParameter("action");
                
            	//do insert if insert called
                if (action != null && action.equals("insert")) {
                	String checkName = request.getParameter("name");
                	
                	//checking categories name is not null
                	if( checkName == null || checkName.trim().length() == 0){
                		%> 
            
						<h3 style="color:red">Data modification failure!  Category Name Can't Be Null</h3>
                		<% 
                		
                		
                	}else{
                	//begin communicate with database
                    c.setAutoCommit(false);

                    // insert into category table
                    pstmt = c.prepareStatement("INSERT INTO categories ( category_name, description) VALUES (?,?)");
                    		
                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("description"));

                    int rowCount = pstmt.executeUpdate();
 
                    //end communicate with database
                    c.commit();
                    c.setAutoCommit(true);
                	}
                }
            %>
            
            <%-- -------- UPDATE category -------- --%>
            <%
                // update is called
                if (action != null && action.equals("update")) {
					String checkName = request.getParameter("name");
                	if( checkName == null || checkName.trim().length() == 0){
                		%> 
                		
            
						<h3 style="color:red">Data modification failure! Category Name Can't Be Null</h3>
                		<% 
                		
                		
                	}else{
                    // Begin communicate with database
                    c.setAutoCommit(false);

                    // updata sql 
                    pstmt = c.prepareStatement("UPDATE categories SET category_name = ?, description = ? WHERE id=?");
                    
                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("description"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();
                    
                    // Commit communicate with database
                    c.commit();
                    c.setAutoCommit(true);
                	}
                }
            %>
            
            <%-- -------- DELETE catagory -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {
                	
                    
                    c.setAutoCommit(false);

                    pstmt = c.prepareStatement("DELETE FROM categories WHERE id = ?");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                    int rowCount = pstmt.executeUpdate();

                    // Commit communicate with database
                    c.commit();
                    c.setAutoCommit(true);
                }
            %>

            <%-- -------- SELECT get all information form category table -------- --%>
            <%
              
                Statement statement = c.createStatement();

                // select sql get infor
                rs = statement.executeQuery("SELECT * FROM categories");
                
            %>
            
            <!-- html talbe format -->
            <table border="1">
            <tr>                
            	<th>ID</th>
                <th>Category Name</th>
                <th>Description</th>
   
            </tr>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="name" size="10"/></th>
                    <th><textarea name="description" rows="3" cols ="40"></textarea></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                //loop to display the table
                while (rs.next()) {
                	
            %>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%=rs.getInt("id")%>"/>
                   
                <%-- a id to track all insert delete and update --%>
                <td>
                    <%=rs.getInt("id")%>
                   
                </td>

                <td>
                    <input value="<%=rs.getString("category_name")%>" name="name" size="15"/>
                </td>

                <td><textarea name="description" rows="3" cols ="40"><%=rs.getString("description")%></textarea>
               
                </td>

                <td><input type="submit" value="Update"></td>
                </form>
                
                <% 
			    	 resultset = statement1.executeQuery("select * from products where category_id = '"+rs.getInt("id")+"'") ;
                	 
                	
                	if(!resultset.next()){ 
                     %>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=rs.getInt("id")%>" name="id"/>
                     <% session.setAttribute("id", rs.getInt("id")); %>
                    <%-- Button --%>
               
                   
                	<td><input type="submit" value="Delete"/></td>
                	
                	<%}%>
                	
                </form>
            </tr>

            <%
                }
            %>

            <%-- -------- disconnect form database-------- --%>
            <%
                rs.close();
                statement.close();

                c.close();
            } catch (SQLException e) {

                throw new RuntimeException(e);
            }
            finally {

                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) { } 
                    rs = null;
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) { } 
                    pstmt = null;
                }
                if (c != null) {
                    try {
                        c.close();
                    } catch (SQLException e) { } 
                    c = null;
                }
            }
            %>
        </table>
        </td>
    </tr>
</table>
	
</body>
</html>