package test.gallery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeDto;
import test.gallery.dto.GalleryDto;
import test.util.DbcpBean;

public class GalleryDao {
	// static 필드
	private static GalleryDao dao;
	// 생성자
	private GalleryDao() {
	}
	// Dao의 참조값을 리턴해주는 static 메소드
	public static GalleryDao getInstance() {
		if (dao == null) {
			dao = new GalleryDao();
		}
		return dao;
	}
	
	public GalleryDto getData(int num) {
		GalleryDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
					" FROM" + 
					"  (SELECT num, writer, caption, imagePath, regdate," + 
					"   LAG(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum," + 
					"   LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum" + 
					"   FROM board_gallery" + 
					"   ORDER BY num DESC)" + 
					" WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, num);
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				dto = new GalleryDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setCaption(rs.getString("caption"));
				dto.setImagePath(rs.getString("imagePath"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPrevNum(rs.getInt("prevNum"));
				dto.setNextNum(rs.getInt("nextNum"));
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
	// 업로드된 사진 하나의 정보를 저장하는 메소드
	public boolean insert(GalleryDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "INSERT INTO board_gallery(num,writer,caption,imagePath,regdate) VALUES(board_gallery_seq.NEXTVAL,?,?,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getCaption());
			pstmt.setString(3, dto.getImagePath());
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
	// 제목 검색
	public int getCountC(GalleryDto dto) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_gallery WHERE caption LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getCaption());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				count = rs.getInt("num");
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
	// 작성자 검색
	public int getCountW(GalleryDto dto) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_gallery WHERE writer LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				count = rs.getInt("num");
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
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0)AS num FROM board_gallery";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("num");
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
	// 제목 검색
	public List<GalleryDto> getListC(GalleryDto tmp) {
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,caption,imagePath,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM" 
							+" (SELECT num,writer,caption,imagePath,regdate" 
							+" FROM board_gallery"
							+" WHERE caption LIKE '%'||?||'%'"
							+" ORDER BY num DESC) result1)" 
					+" WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, tmp.getCaption());
			pstmt.setInt(2, tmp.getStartRowNum());
			pstmt.setInt(3, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				GalleryDto dto = new GalleryDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setCaption(rs.getString("caption"));
				dto.setImagePath(rs.getString("imagePath"));
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
	public List<GalleryDto> getListW(GalleryDto tmp) {
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,caption,imagePath,regdate"
					+" FROM"
						+" (SELECT result1.*, ROWNUM AS rnum"
						+" FROM" 
							+" (SELECT num,writer,caption,imagePath,regdate" 
							+" FROM board_gallery"
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
				GalleryDto dto = new GalleryDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setCaption(rs.getString("caption"));
				dto.setImagePath(rs.getString("imagePath"));
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
	// 업로드된 모든 사진의 정보를 리턴하는 메소드
	public List<GalleryDto> getList(GalleryDto tmp) {
		List<GalleryDto> list = new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT num,writer,caption,imagePath,regdate"
					+ " FROM"
						+ " (SELECT result1.*, ROWNUM AS rnum"
						+ " FROM" 
							+ " (SELECT num,writer,caption,imagePath,regdate" 
							+ " FROM board_gallery"
							+ " ORDER BY num DESC) result1)"
						+ " WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, tmp.getStartRowNum());
			pstmt.setInt(2, tmp.getEndRowNum());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			while (rs.next()) {
				GalleryDto dto = new GalleryDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setCaption(rs.getString("caption"));
				dto.setImagePath(rs.getString("imagePath"));
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
			String sql = "DELETE FROM board_gallery WHERE num=?";
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
}