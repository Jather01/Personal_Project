<%@page import="test.users.dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// id와 pwd라는 파라미터로 전달되는 문자열 읽어오기
	String id=(String)session.getAttribute("id");
	String pwd=request.getParameter("pwd");
	// DB에서 가입된 아이디가 이미 존재하는지 여부를 확인한다.
	boolean isExist=UserDao.getInstance().pwdCheck(id,pwd);
	// 클라이언트에게 응답하기
%>
{"isExist":<%=isExist %>}