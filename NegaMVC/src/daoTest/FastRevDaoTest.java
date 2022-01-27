package daoTest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import dao.FastRevDao;
import dto.QuickMovieTimeVO;

public class FastRevDaoTest {
	static FastRevDao dao = new FastRevDao();
	static HashMap<String, Integer> hMapArea = new HashMap<String, Integer>();
	static String [] arrParamMovieCode = null;

	public static void testShowMovieHeart() {
//		String paramMovieCode = dao.showMovieHeart("#특송", "22/01/23",(arrParamMovieCode),(listMoviePhoto));
//		System.out.println("listMoviePhoto : " + dao.listMoviePhoto);
//		System.out.println("arrParamMovieCode : " + Arrays.toString(dao.arrParamMovieCode));
//		System.out.println(paramMovieCode);
	}
	public static void testShowMovieHeartNoId() {
//		dao.showMovieHeartNoId("22/01/23", "PJH");
	}
	public static void testCountTheater(){
//		dao.countTheater("PJH", FastRevDao.arrArea);
	}
	
	public static ArrayList<QuickMovieTimeVO> testSelectTheater() { //막히는 DAO
		//dao.selectTheater("20220122","22/01/22","강남", dao.arrParamMovieCode);
//		return dao.selectTheater("22/01/23","신촌", dao.arrParamMovieCode);
		return null;
	}
	
	public static void testMakeListStr1to4(ArrayList<QuickMovieTimeVO> listQuickMovieTime) {
		ArrayList<String> listStr1;
		ArrayList<String> listStr2;
		ArrayList<String> listStr3;
		ArrayList<String> listStr4;
//		listStr1 = dao.makeListStr1();
//		listStr2 = dao.makeListStr2();
//		listStr3 = dao.makeListStr3("PJH", "서울", "신촌");
//		listStr4 = dao.makeListStr4(listQuickMovieTime);
//		System.out.println(listStr1);
//		System.out.println(listStr2);
//		System.out.println(listStr3);
//		System.out.println(listStr4);
	}
	
	//-------------------------------▽메인메소드
	public static void main(String[] args) {
		ArrayList<QuickMovieTimeVO> listQuickMovieTime = null;

		testShowMovieHeart();
		testShowMovieHeartNoId();
		testCountTheater();
		listQuickMovieTime = testSelectTheater(); 
		testMakeListStr1to4(listQuickMovieTime);
	}
}


