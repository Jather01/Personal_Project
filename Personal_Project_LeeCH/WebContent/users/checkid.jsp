<%@page import="test.users.dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// id라는 파라미터로 전달되는 문자열 읽어오기
	String id=request.getParameter("id");
	// DB에서 가입된 아이디가 이미 존재하는지 여부를 확인한다.
	boolean isExist=UserDao.getInstance().isExist(id);	
	// 클라이언트에게 응답하기
%>
{"isExist":<%=isExist %>}