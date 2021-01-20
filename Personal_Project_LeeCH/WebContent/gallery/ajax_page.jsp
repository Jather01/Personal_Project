<%@page import="java.net.URLEncoder"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇 개씩 표시할 것인지
	final int PAGE_ROW_COUNT = 8;
	//보여줄 페이지 번호
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	// 보여줄 페이지의 시작 ROWNUM
	int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
	// 보여줄 페이지의 끝 ROWNUM
	int endRowNum = pageNum * PAGE_ROW_COUNT;
	
	String keyword = request.getParameter("keyword");
	String condition = request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if (keyword == null) {
		// 키워드와 검색 조건에 빈문자열을 넣어준다.
		// 클라이언트 웹브라우저레 출력할 때 "null"을 출력되지 않게 하기 위해서
		keyword = "";
		condition = "";
	}
	// 특수 기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK = URLEncoder.encode(keyword);
	
	// startRowNum과 endRowNum을 MmeberDto 객체에 담고
	GalleryDto dto = new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
	List<GalleryDto> list = null;

	list=GalleryDao.getInstance().getList(dto);
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("caption")){ //제목 검색인 경우
			dto.setCaption(keyword);;
			list=GalleryDao.getInstance().getListC(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);;
			list=GalleryDao.getInstance().getListW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{
		list=GalleryDao.getInstance().getList(dto);
	}
	System.out.println("pageNum : "+pageNum);
	System.out.println("keyword : "+keyword);
%>
<%for (GalleryDto tmp : list) {	%>
	<div class="col-6 col-md-3">
		<a href="detail.jsp?num=<%=tmp.getNum()%>">
			<div class="card mb-3">
				<div class="img-wrapper page-<%=pageNum%>">
					<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath()%>" />
				</div>
				<div class="card-body">
					<h5 class="card-text"><%=tmp.getCaption()%></h5>
					<p class="card-text">by <strong><%=tmp.getWriter()%></strong></p>
					<p class="card-text"><small class="text-muted"><%=tmp.getRegdate()%></small></p>
				</div>
			</div>
		</a>
	</div>
<%}	%>