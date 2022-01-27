package actions;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.MovieInfoDao;
import dto.ReviewVO;

public class WriteReviewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieInfoDao miDao = new MovieInfoDao();
		ArrayList<ReviewVO> listReview = new ArrayList<ReviewVO>();
		ArrayList<Float> listCorr = new ArrayList<Float>();
		Date today = new Date();
		float corr = 0;
		
		HttpSession session = request.getSession();
		String loginId = (String)(session.getAttribute("member_id"));
		String movieCode = request.getParameter("movieCode");
		String textarea = request.getParameter("textarea");
		String star = request.getParameter("star");
		String pit1 = request.getParameter("pit1");
		String pit2 = request.getParameter("pit2");
		
		if(pit2 == "") {
			pit2 = "x";
		}
		System.out.println("로그인아이디 : " + loginId);
		System.out.println("영화코드 : " + movieCode);
		System.out.println("관람평 텍스트 : " + textarea);
		System.out.println("별점 : " + star);
		System.out.println("관람포인트 : " + pit1 + "," + pit2);
		
		String pit = pit1 + "," + pit2;
		
		int starscore = Integer.parseInt(star);
		miDao.writeReview(loginId, starscore, textarea, pit, movieCode);
		listReview = miDao.showReviews(listReview, movieCode, today, listCorr);
		corr=listCorr.get(0);
		request.setAttribute("movieCode",movieCode);
		request.setAttribute("listReview",listReview);
		request.setAttribute("corr",corr);
		System.out.println("insert완료");
	
		/*
		 * response.setContentType("application/json; charset=UTF-8"); PrintWriter out =
		 * response.getWriter(); JSONObject obj = new JSONObject();
		 */
	
		//request.getRequestDispatcher("Controller?command=movieInfo&mName="+movieCode).forward(request, response);
	}

}
