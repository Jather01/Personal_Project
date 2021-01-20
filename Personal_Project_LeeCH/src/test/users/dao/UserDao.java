package test.users.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.users.dto.UserDto;
import test.util.DbcpBean;

public class UserDao {
	// static 필드
	private static UserDao dao;
	// 생성자
	private UserDao() {}
	// Dao의 참조값을 리턴해주는 static 메소드
	public static UserDao getInstance() {
		if(dao==null) {
			dao=new UserDao();
		}
		return dao;
	}
	// 프로필 이미지 경로를 수정하는 메소드
	public boolean updateProfile(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "UPDATE users SET profile=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getProfile());
			pstmt.setString(2, dto.getId());
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
	// 비밀번호 확인
	public boolean pwdCheck(String id, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag=false;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT pwd FROM users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, id);
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if(rs.next()&&rs.getString("pwd").equals(pwd)) {
				flag=true;
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
		return flag;
	}
	// 인자로 전달된 아이디가 DB에 존재하는지 여부를 리턴하는 메소드
	public boolean isExist(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag=true;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT * FROM users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, id);
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				flag=false;
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
		return flag;
	}
	// 인자로 전달된 아이디에 해당하는 가입 정보를 리턴하는 메소드
	public UserDto getData(String id) {
		UserDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT pwd,email,profile,regdate FROM users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, id);
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				dto=new UserDto();
				dto.setId(id);
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setProfile(rs.getString("profile"));
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
	// 인자로 전달된 정보가 유효한 정보인지 여부를 리턴하는 메소드
	public boolean isValid(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag=false;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT id FROM users WHERE id=? AND pwd=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			// select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			// 반복문 돌면서 추출
			if (rs.next()) {
				flag=true;
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
		return flag;
	}
	// 회원 정보를 저장하는 메소드
	public boolean insert(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		conn = new DbcpBean().getConn();
		try {
			// 미완성의 sql문
			String sql = "INSERT INTO users(id,pwd,email,regdate) VALUES(?,?,?,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
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
	// 삭제 메소드
	public boolean delete(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "DELETE FROM users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, id);
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
	// update 메소드
	public boolean update(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "UPDATE users SET email=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getId());
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
	// 비밀번호 update 메소드
	public boolean updatePwd(UserDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			// 미완성의 sql문
			String sql = "UPDATE users SET pwd=? WHERE id=? AND pwd=?";
			pstmt = conn.prepareStatement(sql);
			// ?에 순서대로 값을 바인딩 하기
			pstmt.setString(1, dto.getNewPwd());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPwd());
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
