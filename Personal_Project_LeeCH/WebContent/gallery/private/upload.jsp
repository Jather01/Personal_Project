<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 
		업로드된 이미지 정보를 DB에 저장하고
		/gallery/list.jsp 페이지로 
		리다이렉트 이동해서 업로드된 이미지 목록을 보여준다.
	*/
	// Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
	String realPath=application.getRealPath("/upload");
	
	File f=new File(realPath);
	if(!f.exists()){
		f.mkdir();
	}
	//최대 업로드 사이즈 설정
	int sizeLimit=1024*1024*10; // 10 MByte
	
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());
	//폼전송된 내용 추출하기 caption,imagePath
	String caption=mr.getParameter("caption");
	String orgFileName=mr.getOriginalFileName("image");
	String saveFileName=mr.getFilesystemName("image");
	//작성자
	String writer=(String)session.getAttribute("id");
	GalleryDto dto=new GalleryDto();
	dto.setWriter(writer);
	dto.setCaption(caption);
	dto.setImagePath("/upload/"+saveFileName);
	GalleryDao.getInstance().insert(dto);
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/gallery/list.jsp");
%>