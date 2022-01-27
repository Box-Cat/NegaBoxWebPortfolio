package dummy;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actions.Action;
import dao.WantToWatchDao;
import dto.MainVO;

public class CountLikeMemberAction implements Action{

	WantToWatchDao wtwDao = new WantToWatchDao();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<MainVO> tmp = new ArrayList<MainVO>();
		HttpSession session = request.getSession(); 
		tmp = (ArrayList<MainVO>) session.getAttribute("listMain");
		String loginId = (String)(session.getAttribute("member_id"));
		String name = (String)(session.getAttribute("name"));

		wtwDao.countLikeMember(tmp, loginId);
	}

}
