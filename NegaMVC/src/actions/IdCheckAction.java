package actions;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.IdCheckDao;

public class IdCheckAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		IdCheckDao idcheckDao = new IdCheckDao();
		
		String userID = request.getParameter("userID"); // 원인:초기화가 이루어지지 않음
		int idcheck = 0;;
		
		idcheck = idcheckDao.idCheck(userID, idcheck);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("result", idcheck);
		out.print(obj);
		obj.remove("result");
		
		
	}

}
