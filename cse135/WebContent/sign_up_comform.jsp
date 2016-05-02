<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="cse135.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Comformation</title>
</head>
<body>
	<%
		connectJDBC conn = new connectJDBC();
	
		String out_put_result = null;
		Boolean userName = true;
		String user = request.getParameter("user_name");
		if(user != null && user != ""){
			userName = true;
		}else
			userName = false;

		Boolean ageRange = true;
		int ageNo = 0;
		String age = request.getParameter("age");
		if(age != null && age != ""){
			ageRange = conn.checkInt(age);
		}
		else
			ageRange = false;
		
		if(ageRange == true && userName == true){%>
		
			<sql:setDataSource var="snapshot" driver="org.postgresql.Driver"
     		url="jdbc:postgresql://localhost:5433/shopping"
     		user="postgres"  password="Asdf!23"/>
 
			<sql:query dataSource="${snapshot}" var="result">
			SELECT user_name from users where user_name = user;
			</sql:query>
			
			<c:forEach var="row" items="${result.rows}">
			
			<% 
				String total = request.getParameter("row.user_name");
				if(total == user){
					out.println("user name have already exists!");
					break;
			}
			%>
			</c:forEach>
			<% 
			
			out_put_result = "You have successfully signed up.";
			String state = request.getParameter("state");
			String roles = request.getParameter("role");
			Boolean check;
			connectJDBC input_user= new connectJDBC();
			check = input_user.submit(user, roles, ageNo, state);
			if(!check){
				out_put_result = "user name already exist!";
			}
		}
		else{
			if(userName == false){
				out_put_result ="Your signup failed.\n name was not provided.";
			}else
				out_put_result ="Your signup failed.\n age is not real.";
		}
	%>
	<%=out_put_result%>
	<br>
	<a href="log_in.jsp">Back to Log in</a>


</body>
</html>