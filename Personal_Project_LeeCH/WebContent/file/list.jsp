<%@page import="java.net.URLEncoder"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇 개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	//보여줄 페이지 번호
	int pageNum=1;
	// 페이지 번호가 파라미터로 전달되는지 읽어와본다.
	String strPageNum=request.getParameter("pageNum");
	// 만일 페이지 번호가 파라미터로 넘어온다면
	if(strPageNum!=null){
		// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	// 보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	/*
		[ 검색 키워드에 관련된 처리 ]
		- 검색 키워드가 파라미터로 넘어올수도 있고 안 넘어 올수도 있다.
	*/
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		// 키워드와 검색 조건에 빈문자열을 넣어준다.
		// 클라이언트 웹브라우저레 출력할 때 "null"을 출력되지 않게 하기 위해서
		keyword="";
		condition="";
	}
	// 특수 기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK=URLEncoder.encode(keyword);
	
	// startRowNum과 endRowNum을 MmeberDto 객체에 담고
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// FileDao 객체를 이용해서 회원 목록을 얻어온다.
	List<FileDto> list=null;
	int totalRow=0;
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title_filename")){//제목 + 파일명 검색인 경우
			//검색 키워드를 FileDto 에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			list=FileDao.getInstance().getListTF(dto);
			totalRow=FileDao.getInstance().getCountTF(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);;
			list=FileDao.getInstance().getListT(dto);
			totalRow=FileDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);;
			list=FileDao.getInstance().getListW(dto);
			totalRow=FileDao.getInstance().getCountW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{
		list=FileDao.getInstance().getList(dto);
		totalRow=FileDao.getInstance().getCount();
	}
	int startPageNum=1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int lastPage=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	if(endPageNum>lastPage){
		endPageNum=lastPage;
	}
	// 로그인된 아이디가 있는지 읽어와본다. 없다면 null
	String id=(String)session.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<div class="row" style="margin-bottom: 10px">
			<div class="col">
				<a href="${pageContext.request.contextPath }/file/private/upload_form.jsp" class="btn btn-primary">새 파일 업로드</a>
			</div>
			<div class="col text-right">
				<form action="${pageContext.request.contextPath }/file/list.jsp" method="get">
					<select name="condition" id="condition">
							<option value="title_filename" <%=condition.equals("title_filename")? "selected":"" %>>제목+파일명</option>
							<option value="title" <%=condition.equals("title")? "selected":"" %>>제목</option>
							<option value="writer" <%=condition.equals("writer")? "selected":"" %>>작성자</option>
					</select>
					<input type="text" name="keyword" value="<%=keyword%>"/>
					<button class="btn btn-success" type="submit">검색</button>
				</form>
			</div>
		</div>
		<table class="table table-striped">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>파일명</th>
					<th>크기</th>
					<th>등록일</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%for(FileDto tmp : list){%>
					<tr>
						<td><%=tmp.getNum() %></td>
						<td><%=tmp.getWriter() %></td>
						<td><%=tmp.getTitle() %></td>
						<td><a href="${pageContext.request.contextPath }/file/download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
						<td><%=tmp.getFileSize() %></td>
						<td><%=tmp.getRegdate() %></td>
						<%if(tmp.getWriter().equals(id)){ %>
							<td><a href="javascript:deleteConfirm(<%=tmp.getNum()%>)">삭제</a></td>
						<%}else{ %>
							<td></td>
						<%} %>
					</tr>
				<%} %>
			</tbody>
		</table>
		<nav>
			<ul class="pagination justify-content-center">
				<%if(startPageNum!=1){ %>
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath }/file/list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition%>&keyword=<%=encodedK%>">&laquo;</a>
					</li>
				<%} else {%>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&laquo;</a>
					</li>
				<%} %>
				<%for(int i=startPageNum;i<=endPageNum;i++){ %>
					<li class="page-item <%=i==pageNum?"active":"" %>">
						<a class="page-link" href="${pageContext.request.contextPath }/file/list.jsp?pageNum=<%=i %>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
					</li>
				<%} %>
				<%if(endPageNum!=lastPage){ %>
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath }/file/list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition%>&keyword=<%=encodedK%>">&raquo;</a>
					</li>
				<%} else {%>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">&raquo;</a>
					</li>
				<%} %>
			</ul>
		</nav>
		<!-- 만약 검색 키워드가 존재한다면 몇개의 글이 검색되었는지 알려준다. -->
		<%if(!keyword.equals("")){%>
			<div class="alert alert-success"><strong><%=totalRow %></strong>개의 자료가 검색 되었습니다.</div>
		<%} %>
	</div>
<script>
	function deleteConfirm(num){
		let isDelete=confirm(num+"번 파일을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/file/private/delete.jsp?num="+num;
		}
	}
</script>
</body>
</html>