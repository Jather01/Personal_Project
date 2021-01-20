<%@page import="test.users.dao.UserDao"%>
<%@page import="test.users.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	String email=request.getParameter("email");
	UserDto dto=new UserDto();
	dto.setId(id);
	dto.setEmail(email);
	boolean isSuccess=UserDao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="${pageContext.request.contextPath }/users/private/info.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("수정실패");
			location.href="${pageContext.request.contextPath }/users/private/updateform.jsp";
		</script>
	<%} %>
</body>
</html>