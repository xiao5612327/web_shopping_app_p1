<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String user = (String) session.getAttribute("user_name");
	%>

	Welcome
	<%=user%>
		<form method="get" action="log_in.jsp">
		<INPUT TYPE=SUBMIT VALUE="Log out">
	</form>
	<p>Product:
	<form>
		<select name="product">
			<option value="Notebook">Notebook</option>
			<option value="Pen">Pen</option>
		</select>
		<p>
			Amount: <input type="text" size="4" name="amount" />
		<p />
		<input type="submit" value="Click to Order" />
	</form>
</body>
</html>