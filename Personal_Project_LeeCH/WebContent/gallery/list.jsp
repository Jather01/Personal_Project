<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇 개씩 표시할 것인지
	final int PAGE_ROW_COUNT = 8;
	//보여줄 페이지 번호
	int pageNum = 1;
	// 페이지 번호가 파라미터로 전달되는지 읽어와본다.
	String strPageNum = request.getParameter("pageNum");
	// 만일 페이지 번호가 파라미터로 넘어온다면
	if (strPageNum != null) {
		// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum = Integer.parseInt(strPageNum);
	}
	// 보여줄 페이지의 시작 ROWNUM
	int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum = pageNum * PAGE_ROW_COUNT;
	/*
		[ 검색 키워드에 관련된 처리 ]
		- 검색 키워드가 파라미터로 넘어올수도 있고 안 넘어 올수도 있다.
	*/
	String keyword = request.getParameter("keyword");
	String condition = request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if (keyword == null) {
		// 키워드와 검색 조건에 빈문자열을 넣어준다.
		// 클라이언트 웹브라우저레 출력할 때 "null"을 출력되지 않게 하기 위해서
		keyword = "";
		condition="";
	}
	
	// 특수 기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK = URLEncoder.encode(keyword);
	
	// startRowNum과 endRowNum을 MmeberDto 객체에 담고
	GalleryDto dto = new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
	List<GalleryDto> list = null;
	int totalRow = 0;
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("caption")){ //제목 검색인 경우
			dto.setCaption(keyword);;
			list=GalleryDao.getInstance().getListC(dto);
			totalRow=GalleryDao.getInstance().getCountC(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);;
			list=GalleryDao.getInstance().getListW(dto);
			totalRow=GalleryDao.getInstance().getCountW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{
		list=GalleryDao.getInstance().getList(dto);
		totalRow=GalleryDao.getInstance().getCount();
	}
	int lastPage = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	body{
		margin-bottom: 60px;
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
	<jsp:include page="../include/navbar.jsp"></jsp:include>
	<div class="container">
		<div class="row"  style="margin-bottom: 10px">
			<div class="col">
				<a href="private/ajax_form.jsp" class="btn btn-primary">이미지 업로드</a>
			</div>
			<div class="col text-right">
				<form action="${pageContext.request.contextPath }/gallery/list.jsp" method="get">
					<select name="condition" id="condition">
						<option value="caption" <%=condition.equals("caption")? "selected":"" %>>제목</option>
						<option value="writer" <%=condition.equals("writer")? "selected":"" %>>작성자</option>
					</select>
					<input type="text" name="keyword" value="<%=keyword%>"/>
					<button class="btn btn-success" type="submit">검색</button>
				</form>
			</div>
		</div>
		<!-- 만약 검색 키워드가 존재한다면 몇개의 글이 검색되었는지 알려준다. -->
		<%if(!keyword.equals("")){%>
			<div class="alert alert-success"><strong><%=totalRow %></strong>개의 자료가 검색 되었습니다.</div>
		<%} %>
		<div class="row" id="galleryList">
			<%for (GalleryDto tmp : list) {	%>
			<!-- 
			[ 칼럼의 폭을 반응 형으로 ]
			device 폭 768px 미만에서 칼럼의 폭 => 6/12 (50%)
			device 폭 768px ~ 992px에서 칼럼의 폭 => 4/12 (33.333%)
			device 폭 992px 이상에서 칼럼의 폭 => 3/12 (25%)
		 -->
			<div class="col-6 col-md-3">
				<a href="detail.jsp?num=<%=tmp.getNum()%>">
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
		<div class="back-drop">
			<img src="${pageContext.request.contextPath }/svg/spinner-solid.svg" />
		</div>
	</div>
	<script>
		// card 이미지의 부모 요소를 선택해서 imgLiquid  동작(jquery plugin 동작) 하기 
		$(".img-wrapper").imgLiquid();
		//페이지가 처음 로딩될때 1 page 를 보여주기 때문에 초기값을 1 로 지정한다.
		let currentPage=1;
		let isLoading=false;
		// 웹브라우저 창을 스크롤 할 때마다 호출되는 함수 등록
		$(window).on("scroll",function(){
			console.log("scroll!");
			// 최하단까지 스크롤 되었는지 조사해본다.
			let scrollTop=$(window).scrollTop();
			let windowHeight=$(window).height();
			let documentHeight=$(document).height();
			// 바닥까지 스트롤 되었는지 여부를 알아낸다.
			console.log("scrollTop : "+scrollTop+", windowHeight : "+windowHeight+", documentHeight : "+documentHeight);
			let isBottom=scrollTop+windowHeight >= documentHeight;
			if(isBottom&&currentPage!=<%=lastPage%>){// 만일 바닥까지 스크롤 되고, 현재 페이지가 마지막 페이지가 아니라면 
				console.log("bottom!");
				if(currentPage==<%=lastPage%>||isLoading){
					return;
				}
				isLoading=true;
				// 로딩바를 띄운다.
				$(".back-drop").show();
				// 요청할 페이지 번호를 1 증가시킨다.
				currentPage++;
				// 추가로 받아올 페이지를 서버에 ajax 요청을 하고
				$.ajax({
					url:"${pageContext.request.contextPath }/gallery/ajax_page.jsp",
					method:"GET",
					data:"pageNum="+currentPage+"&condition="+"<%=condition%>"+"&keyword="+"<%=encodedK%>",
					success:function(data){
						console.log(data);
						$("#galleryList").append(data);
						// card 이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작) 하기 
						$(".page-"+currentPage).imgLiquid();
						// 로딩바를 숨긴다.
						$(".back-drop").hide();
						isLoading=false;
					}
				});
			}
		});
	</script>
</body>
</html>