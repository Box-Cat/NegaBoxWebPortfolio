package dummy;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actions.Action;
import dao.WantToWatchDao;
import dto.MainVO;

public class CountLikeAction implements Action{

	WantToWatchDao wtwDao = new WantToWatchDao();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<MainVO> tmp = new ArrayList<MainVO>();
		HttpSession session = request.getSession(); 
		tmp = (ArrayList<MainVO>) session.getAttribute("listMain");
		wtwDao.countLike(tmp);
		
		/*session 사용법 예시
		 * HttpSession session = request.getSession(); //객체가 아니라 참조변수이다.
		 * session.setAttribute("listMain",mDao.showApiMovieList(vo));
		 */
		
	}
}
