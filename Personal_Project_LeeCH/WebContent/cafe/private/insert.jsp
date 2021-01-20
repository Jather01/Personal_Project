<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인된 상태기 때문에 글 작성자는 session scope에서 얻어낸다.
	String writer=(String)session.getAttribute("id");
	// 1. 폼 전송되는 글 제목과 내용을 읽어와서
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	CafeDto dto=new CafeDto();
	dto.setContent(content);
	dto.setTitle(title);
	dto.setWriter(writer);
	// 2. DB에 반영한다.
	boolean isSuccess=CafeDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("새 글이 추가 되었습니다.");
			location.href="${pageContext.request.contextPath }/cafe/list.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("새 글이 추가에 실패 했습니다.");
			location.href="${pageContext.request.contextPath }/cafe/private/insertform.jsp";
		</script>
	<%} %>
</body>
</html>