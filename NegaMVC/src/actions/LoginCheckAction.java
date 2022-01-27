package actions;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dto.MemberVO;

public class LoginCheckAction implements Action {

	MemberDao memberDao = new MemberDao();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		Date today = new Date(); //로그인 되면 출력
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//로그인 되면 출력
		String todate = format.format(today);//로그인 되면 출력

		if(memberDao.loginCheck(new MemberVO(id,pw,"","","",null,"","",""))) { //null은 date(생일)
			
			
			String name = memberDao.showName(new MemberVO(id,"","","","",null,"","","")); 
			
			//넘어가기 전에 session사용한다.
			HttpSession session = request.getSession(); //객체가 아니라 참조변수이다.
			session.setAttribute("member_id", id); //key와 value는 내가 정한다.
			session.setAttribute("pw", pw); 
			session.setAttribute("name", name); 
			session.setAttribute("today", today); 
			session.setAttribute("format", format); 
			session.setAttribute("todate", todate); 
			
			request.getRequestDispatcher("login_success.jsp").forward(request, response);
		}
		else {
			request.getRequestDispatcher("login_failure.jsp").forward(request, response);
		}	
		
	}
}
