package test.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.file.dao.FileDao;
import test.file.dto.FileDto;

@WebServlet("/file/list2")
public class FileListServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
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
		
		// jsp 페이지에서 필요한 데이터를 request 영역에 담고
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		// jsp 페이지로 forward 이동해서 응답한다.
		RequestDispatcher rd=request.getRequestDispatcher("/file/list2.jsp");
		rd.forward(request, response);
	}
}
