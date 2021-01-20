<%@page import="java.util.List"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum=4;
	
	CafeDto cafedto=new CafeDto();
	cafedto.setStartRowNum(1);
	cafedto.setEndRowNum(5);

	FileDto filedto=new FileDto();
	filedto.setStartRowNum(1);
	filedto.setEndRowNum(5);

	GalleryDto gallerydto=new GalleryDto();
	gallerydto.setStartRowNum(1);
	gallerydto.setEndRowNum(4);
	
	List<CafeDto> cafeList=CafeDao.getInstance().getList(cafedto);
	List<FileDto> fileList=FileDao.getInstance().getList(filedto);
	List<GalleryDto> galleryList=GalleryDao.getInstance().getList(gallerydto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/main.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	.table {
		border: 1px solid black;
	}
	/* card 이미지 부모요소의 높이 지정 */
	.img-wrapper {
		height: 250px;
		/* transform을 적용할 때 0.3초동안 순차적으로 적용하기 */
		transition: transform 0.3 ease-out;
	}
	/* .image-wrapper에 마우스가 hover 되었을 때 적용할 css */
	.img-wrapper:hover{
		/* 원본 크기의 1.1배로 확대시키기 */
		transform: scale(1.1);
	}
	.card .card-text {
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display: block;
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	.back-drop{
		/* 일단 숨겨 놓는다. */
		display:none;
	
		/* 화면 전체를 투명도가 있는 회색으로 덮기 위한  css*/
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		background-color: #cecece;
		padding-top: 300px;
		z-index: 10000;
		opacity: 0.5;
		/* img  가  가운데 정렬 되도록 */
		text-align: center;
	}
	.back-drop img{
		width: 100px;
		/* rotateAnimation 이라는 키프레임을 2초 동한 일정한 비율로  무한 반복하기 */
		animation: rotateAnimation 2s ease-out infinite;
	}
	@keyframes rotateAnimation{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}
</style>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="container">
		<div class="row" style="margin-bottom: 10px">
			<div class="col">
				<h5>카페 게시판</h5>
			</div>
			<div class="col text-right">
				<a href="${pageContext.request.contextPath }/cafe/list.jsp" class="btn btn-success">더보기</a>
			</div>
		</div>
		<table class="table table-striped">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<%for (CafeDto tmp : cafeList) { %>
				<tr>
					<td><%=tmp.getNum()%></td>
					<td><a href="${pageContext.request.contextPath }/cafe/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle()%></a></td>
					<td><%=tmp.getWriter()%></td>
					<td><%=tmp.getRegdate()%></td>
					<td><%=tmp.getViewCount()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<div class="container">
		<div class="row" style="margin-bottom: 10px">
			<div class="col">
				<h5>파일 자료실</h5>
			</div>
			<div class="col text-right">
				<a href="${pageContext.request.contextPath }/file/list.jsp" class="btn btn-success">더보기</a>
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
				<%for(FileDto tmp : fileList){%>
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
	</div>
	<div class="container">
		<div class="row" style="margin-bottom: 10px">
			<div class="col">
				<h5>갤러리 목록</h5>
			</div>
			<div class="col text-right">
				<a href="${pageContext.request.contextPath }/gallery/list.jsp" class="btn btn-success">더보기</a>
			</div>
		</div>
		<div class="row" id="galleryList">
			<%for (GalleryDto tmp : galleryList) {	%>
			<!-- 
			[ 칼럼의 폭을 반응 형으로 ]
			device 폭 768px 미만에서 칼럼의 폭 => 6/12 (50%)
			device 폭 768px ~ 992px에서 칼럼의 폭 => 4/12 (33.333%)
			device 폭 992px 이상에서 칼럼의 폭 => 3/12 (25%)
		 -->
			<div class="col-6 col-md-3">
				<a href="${pageContext.request.contextPath }/gallery/detail.jsp?num=<%=tmp.getNum()%>">
					<div class="card mb-3">
						<div class="img-wrapper">
							<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath()%>" />
						</div>
						<div class="card-body">
							<h5 class="card-text"><%=tmp.getCaption()%></h5>
							<p class="card-text">
								by <strong><%=tmp.getWriter()%></strong>
							</p>
							<p class="card-text">
								<small class="text-muted"><%=tmp.getRegdate()%></small>
							</p>
						</div>
					</div>
				</a>
			</div>
			<%}	%>
		</div>
	</div>
	<script>
		// card 이미지의 부모 요소를 선택해서 imgLiquid  동작(jquery plugin 동작) 하기 
		$(".img-wrapper").imgLiquid();
		
		function deleteConfirm(num){
			let isDelete=confirm(num+"번 파일을 삭제 하시겠습니까?");
			if(isDelete){
				location.href="private/delete.jsp?num="+num;
			}
		}
	</script>
</body>
</html>