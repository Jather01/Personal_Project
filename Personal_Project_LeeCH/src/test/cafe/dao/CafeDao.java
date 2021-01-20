package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class CafeDao {
	// static 필드
	private static CafeDao dao;
	// 생성자
	private CafeDao() {}
	// Dao의 참조값을 리턴해주는 static 메소드
	public static CafeDao getInstance() {
		if(dao==null) {
			dao=new CafeDao();
		}
		return dao;
	}
	public int getCountTC(CafeDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_cafe WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			/*
			 *  [ title 검색 키워드가 "kim" 이라고 가정하면 ]
			 *  
			 *  값 바인딩 전
			 *  1. title LIKE '%' || ? || '%'
			 *  
			 *  값 바인딩 후
			 *  2. title LIKE '%' || 'kim' || '%'
			 *  
			 *  연결연산 후 아래와 같은 SELECT 문이 구성된다. 
			 *  3. title LIKE '%kim%'
			 *  
			 *  따라사 제목에 kim 이라는 문자열이 포함된 row  가  SELECT 된다.
			 */ 
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close(); 
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	public int getCountT(CafeDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_cafe WHERE title LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getTitle());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close(); 
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	public int getCountW(CafeDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_cafe WHERE writer LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close(); 
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	// 전체 row의 갯수를 리턴하는 메소드
	public int getCount() {
		int count=0;
		CafeDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0)AS num FROM board_cafe";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	public CafeDto getData(int num) {
		CafeDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT writer,title,content,viewCount,regdate FROM board_cafe WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, num);
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if(rs.next()) {
				dto=new CafeDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	// 글 하나의 정보를 추가하는 메소드
	public boolean insert(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "INSERT INTO board_cafe(num,writer,title,content,viewCount,regdate) VALUES(board_cafe_seq.NEXTVAL,?,?,?,0,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			// 완성된 sql문을 수행하고 변화된 row의 갯수를 리턴 받는다.
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (flag > 0)
			return true;
		else
			return false;
	}
	// 제목+내용 검색
	public List<CafeDto> getListTC(CafeDto tmp){
		List<CafeDto> list=new ArrayList<CafeDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,title,content,viewCount,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM"
							+" (SELECT num,writer,title,content,viewCount,regdate"
							+" FROM board_cafe"
							+" WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"
							+" ORDER BY num DESC) result1)"
					+" WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, tmp.getTitle());
			pstmt.setString(2, tmp.getContent());
			pstmt.setInt(3, tmp.getStartRowNum());
			pstmt.setInt(4, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				CafeDto dto=new CafeDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 제목 검색
	public List<CafeDto> getListT(CafeDto tmp){
		List<CafeDto> list=new ArrayList<CafeDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,title,content,viewCount,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM"
							+" (SELECT num,writer,title,content,viewCount,regdate"
							+" FROM board_cafe"
							+" WHERE title LIKE '%'||?||'%'"
							+" ORDER BY num DESC) result1)"
					+" WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, tmp.getTitle());
			pstmt.setInt(2, tmp.getStartRowNum());
			pstmt.setInt(3, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				CafeDto dto=new CafeDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 작성자 검색
	public List<CafeDto> getListW(CafeDto tmp){
		List<CafeDto> list=new ArrayList<CafeDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,title,content,viewCount,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM"
							+" (SELECT num,writer,title,content,viewCount,regdate"
							+" FROM board_cafe"
							+" WHERE writer LIKE '%'||?||'%'"
							+" ORDER BY num DESC) result1)"
					+" WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, tmp.getWriter());
			pstmt.setInt(2, tmp.getStartRowNum());
			pstmt.setInt(3, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				CafeDto dto=new CafeDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 글 전체 목록을 리턴하는 메소드
	public List<CafeDto> getList(CafeDto tmp){
		List<CafeDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,title,content,viewCount,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM"
							+" (SELECT num,writer,title,content,viewCount,regdate"
							+" FROM board_cafe"
							+" ORDER BY num DESC) result1)"
					+" WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, tmp.getStartRowNum());
			pstmt.setInt(2, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				CafeDto dto=new CafeDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	// 삭제 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "DELETE FROM board_cafe WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setInt(1, num);
			// 완성된 sql문을 수행하고 변화된 row의 갯수를 리턴 받는다.
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (flag > 0)
			return true;
		else
			return false;
	}
	// 수정 메소드
	public boolean update(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "UPDATE board_cafe SET title=?, content=? WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			// 완성된 sql문을 수행하고 변화된 row의 갯수를 리턴 받는다.
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (flag > 0)
			return true;
		else
			return false;
	}
	// 조회수를 업데이트 하는 메소드
	public void viewCountUpdate(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "UPDATE board_cafe SET viewCount=viewCount+1 WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setInt(1, num);
			// 완성된 sql문을 수행하고 변화된 row의 갯수를 리턴 받는다.
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
