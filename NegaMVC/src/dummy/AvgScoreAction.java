package dummy;

import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actions.Action;
import dao.MovieDao;
import dao.ReviewDao;
import dto.MainVO;

public class AvgScoreAction implements Action {
	
	MovieDao mDao = new MovieDao();
	ReviewDao rDao = new ReviewDao();

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ArrayList<MainVO> tmp = new ArrayList<MainVO>();
		HttpSession session = request.getSession(); 
		tmp = (ArrayList<MainVO>) session.getAttribute("listMain");
		rDao.avgScore(tmp);
		
		for(MainVO vo :tmp) {
			System.out.println(vo);
		}
		
	}

}
