<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	CafeDto dto=CafeDao.getInstance().getData(num);
	CafeDao.getInstance().viewCountUpdate(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<table class="table table-bordered">
			<tr>
				<th>글번호</th>
				<td><%=dto.getNum() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=dto.getWriter() %></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><%=dto.getRegdate() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
			<tr>
				<td colspan="2">
					<div><%=dto.getContent() %></div>
				</td>
			</tr>
		</table>
		<a class="btn btn-secondary" href="list.jsp">목록보기</a>
		<%
			String id=(String)session.getAttribute("id");
			if(dto.getWriter().equals(id)){ %>
			<a class="btn btn-secondary" href="${pageContext.request.contextPath }/cafe/private/updateform.jsp?num=<%=dto.getNum()%>">수정</a>
			<a class="btn btn-secondary" href="javascript:deleteConfirm()">삭제</a>
		<%} %>
	</div>
	<script>
		function deleteConfirm(){
			let isDelete=confirm("글을 삭제 하시겠습니까?");
			if(isDelete){
				location.href="private/delete.jsp?num=<%=dto.getNum()%>";
			}
		}
	</script>
</body>
</html>