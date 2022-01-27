package actions;




import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RegisterDao;


public class RegisterAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		RegisterDao rDao = new RegisterDao();
		
		String birth = request.getParameter("birth");
		String name = request.getParameter("name");
		Date birth2 = Date.valueOf(birth);
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		int ret = 0;
		
		ret = rDao.insertMember(id, pw, email, phone, birth2, name, ret);
		if(ret==1)
			request.getRequestDispatcher("Controller?command=main").forward(request,response);
	}

}
