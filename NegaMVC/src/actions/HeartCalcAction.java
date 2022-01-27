package actions;


import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.HeaartCalcDao;
import dto.HeartsVO;

public class HeartCalcAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HeaartCalcDao hcDao = new HeaartCalcDao();
		
		HttpSession session = request.getSession();
		String loginId = (String)(session.getAttribute("member_id"));
		String movieCode = request.getParameter("movieCode");
		int heart = Integer.parseInt(request.getParameter("heart"));
		boolean heartTrueFalse = false;
		// TODO : DB처리. = insert/delete
		HeartsVO resultHeartVO = new HeartsVO();
		
		
System.out.println("heartCalcAction의 heart : "+heart);
		
		
 		resultHeartVO = hcDao.showHeart(heart, loginId, movieCode, heartTrueFalse, resultHeartVO);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		//heartTrueFalse
		obj.put("like", resultHeartVO.isHeartTrueFalse());
		obj.put("likeHeart", resultHeartVO.getHeart());
		out.print(obj);
	}

}








