<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	// 1. GET 방식 파라미터로 전달되는 삭제할 글번호를 읽어와서
	int num=Integer.parseInt(request.getParameter("num"));
	String title=(String)request.getParameter("title");
	String content=(String)request.getParameter("content");
	CafeDto dto=new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	// 2. DB에서 삭제하고
	boolean isSuccess=CafeDao.getInstance().update(dto);
	// 3. 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=num%>";
		</script>
	<%}else{ %>
		<script>
			alert("수정 실패!");
			location.href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=num%>";
		</script>
	<%} %>
</body>
</html>