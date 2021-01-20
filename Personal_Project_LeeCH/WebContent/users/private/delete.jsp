<%@page import="test.users.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	// 1. 로그인 되어있는 아이디를 가져온다.
	String id=(String)session.getAttribute("id");
	// 2. 아이디를 이용해서 DB에서 해당 row를 삭제한다.
	boolean isSuccess=UserDao.getInstance().delete(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/user/delete.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isSuccess){ 
			session.removeAttribute("id");%>
			<script>
				alert("<%=id %>님 탈퇴 처리되었습니다.");
				location.href="${pageContext.request.contextPath }/main.jsp";
			</script>
		<%}else{ %>
			<script>
				alert("탈퇴에 실패하였습니다.");
				location.href="${pageContext.request.contextPath }/users/private/info.jsp";
			</script>
		<%} %>
	</div>
</body>
</html>