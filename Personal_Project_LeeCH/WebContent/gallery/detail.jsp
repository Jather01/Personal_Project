<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
	GalleryDto dto=GalleryDao.getInstance().getData(num);
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<%if(dto.getWriter().equals(id)) { %>
			<div class="text-right"  style="margin-bottom: 10px">
				<a class="btn btn-secondary" href="javascript:deleteConfirm()">삭제</a>
			</div>
		<%} %>
		<table class="table table-bordered">
			<tr>
				<th>제목</th>
				<td><%=dto.getCaption() %></td>
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
				<td colspan="2">
					<img class="card-img-top" src="${pageContext.request.contextPath }<%=dto.getImagePath()%>"/>
				</td>
			</tr>
		</table>
		<nav>
			<ul class="pagination justify-content-center">
				<%if(dto.getPrevNum() != 0){ %>
					<li class="page-item mr-3">
						<a class="page-link" href="${pageContext.request.contextPath }/gallery/detail.jsp?num=<%=dto.getPrevNum()%>">&larr; Prev</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled mr-3">
						<a class="page-link" href="javascript:">Prev</a>
					</li>	
				<%} %>
				<li class="page-item mr-3">
					<a class="page-link" href="${pageContext.request.contextPath }/gallery/list.jsp">목록</a>
				</li>
				<%if(dto.getNextNum() != 0){ %>
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath }/gallery/detail.jsp?num=<%=dto.getNextNum()%>">Next &rarr;</a>
					</li>
				<%}else{ %>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>	
				<%} %>
			</ul>
		</nav>
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