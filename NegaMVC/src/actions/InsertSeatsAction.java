package actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QuickSeatsRevDao;

public class InsertSeatsAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QuickSeatsRevDao qsrDao = new QuickSeatsRevDao();
		
		//ajax에서 받은 정보
		String paramloginId = request.getParameter("loginId"); 
		String paramSeatsSelected = request.getParameter("seats_selected");
		String paramSeatsPrice = request.getParameter("seats_price");
		String paramSeatsAge = request.getParameter("seats_age");
		String paramScreenInfoCode = request.getParameter("screen_info_code"); 
		String[] arrSeats2 = paramSeatsSelected.split("_");
		String[] strPrice = paramSeatsPrice.split("_");
		String[] arrAges = paramSeatsAge.split("_");
		int[] arrPrice = new int[strPrice.length];
		for(int i=0; i<=arrPrice.length-1; i++) {
			arrPrice[i] = Integer.parseInt(strPrice[i]);
		}
		
		qsrDao.insertRevSeats(arrPrice, arrSeats2, arrAges, paramloginId, paramScreenInfoCode);
		
		
	}

}
