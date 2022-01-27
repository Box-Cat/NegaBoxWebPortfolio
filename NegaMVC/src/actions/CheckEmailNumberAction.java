package actions;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.EmailDao;

public class CheckEmailNumberAction implements Action{//get

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		EmailDao eDao = new EmailDao();
		String ret = null;
		String to = request.getParameter("email4");
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		ret = eDao.checkEmailNumber(to, ret);
		
		JSONObject obj = new JSONObject();
	    obj.put("result2", ret);
	    out.print(obj);
	}
	
}
