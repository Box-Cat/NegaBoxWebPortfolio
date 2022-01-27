package actions;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dao.MovieInfoDao;
import dto.ApiVO;
import dto.ChartVO;
import dto.MovieVO;
import dto.ReviewVO;

public class MovieInfoAction implements Action {
	
	//starnum??
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//System.out.println("M.I.Action~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		ArrayList<ReviewVO> listReview = new ArrayList<ReviewVO>();
		int pip = 0;
		ArrayList<ApiVO> apiList = new ArrayList<ApiVO>();
		String reviewCount = null;
		String openingDay = null;
		int runningTime = 0;
		String director = null;
		String rating = null;
		String casting = null;
		String moviePhoto = null;
		String plot = null;
		String allType = null;
		String tag = null;
		String engName = null;
		String trailer = null;
		String trailerSub = null;
		String stealcut = null;
		String genre = null;
		String miniTitle = null;
		int dolby = 0;
		float corr = 0;
		String chartPit1 = null;
		String chartPit2 = null;
		int chartProduction = 0;
		int chartActor = 0;
		int chartOst = 0;
		int chartVisual = 0;
		int chartStory = 0;

		
		MovieInfoDao miDao = new MovieInfoDao();
		
		//로그인 아이디 받기
		HttpSession session = request.getSession();
		String loginId = (String)(session.getAttribute("member_id"));
		String name = (String)(session.getAttribute("name"));
		String movieName = request.getParameter("movieName").trim(); //writeReview에서 돌아올 때 null값
		String mName ="#"+movieName.replace(" ","").trim(); //all_movie에서 sendPost로 받아오도록 바꿀 것
		String movieCode = mName;//all_movie에서 sendPost로 받아오도록 바꿀 것
		System.out.println("movieCode : "+movieCode);
		//API날짜
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat df = new SimpleDateFormat("YYYYMMdd");
		cal.add(Calendar.DATE, -7);
		String weeklyday = df.format(cal.getTime());
		
	
		ArrayList<Float> listCorr = new ArrayList<Float>();
//		System.out.println("메서드1부터 시작해보쟈~~~~");
		listReview = miDao.showReviews(listReview, mName, today,listCorr);
		corr=listCorr.get(0);
//		System.out.println("listReview : " + listReview);
//		System.out.println("listCorr : " + listCorr + "corr : " + corr);
//		System.out.println();
//		System.out.println("메서드2부터 시작해보쟈~~~~");
//		System.out.println();
		MovieVO movieVo = miDao.showMovieInfo(mName, movieName, openingDay, runningTime, director, rating, casting, moviePhoto, plot, allType, tag, engName, trailer, trailerSub, stealcut, genre, miniTitle, dolby);
		
		//API
		try{
			// parsing할 url 지정(API 키 포함해서)
			String apiurl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.xml?key=9cdf19c7cea4d9369ab54dce5a79fd75&targetDt="+weeklyday;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiurl);
			
			// root tag 
			doc.getDocumentElement().normalize();
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("weeklyBoxOffice");
			NodeList movieNm = doc.getElementsByTagName("movieNm");
			NodeList audiAcc = doc.getElementsByTagName("audiAcc");
			NodeList audiCnt = doc.getElementsByTagName("audiCnt");
			for(int temp = 0; temp < nList.getLength(); temp++){
				Node movieApi = movieNm.item(temp);
				Node accApi = audiAcc.item(temp);
				Node cntApi = audiCnt.item(temp);
				
					Element e1 = (Element) movieApi;
					Element e2 = (Element) accApi;
					Element e3 = (Element) cntApi;
					
					pip += Integer.parseInt(e3.getTextContent());
					System.out.println("영화이름: " + e1.getTextContent() + " pip :" + pip + "   cntApi : " + e3.getTextContent());
					apiList.add(new ApiVO(e3.getTextContent(),e2.getTextContent(),e1.getTextContent()));
					// for end
			}	// if end
			
		} catch (Exception e){
			e.printStackTrace();
		}	// try~catch end
		
		String accApi = "";
		String cntApi = "";
		for(ApiVO vo : apiList) {
			if(vo.getMovieNm().equals(movieName)) {
				accApi = vo.getAudiAcc();
				cntApi = vo.getAudiCnt();
			}
		}
		
	    reviewCount = miDao.countReview(mName, reviewCount);		
	    ChartVO chartVO = miDao.reviewCalc(mName, chartStory, chartProduction, chartOst, chartVisual, chartActor, chartPit1, chartPit2);
		

		 
		 request.setAttribute("reviewCount",reviewCount);
		 request.setAttribute("apiList",apiList);
		 request.setAttribute("listReview",listReview);
		 request.setAttribute("movieName",movieName);
		 request.setAttribute("corr",corr);
		 request.setAttribute("pip",pip);
		 request.setAttribute("accApi",accApi.equals("") ? "0" : accApi);
		 
		 request.setAttribute("cntApi",cntApi.equals("")  ? "0" : cntApi);

		 
		 request.setAttribute("movieVo", movieVo);
		 request.setAttribute("chartVO", chartVO);
		 
		 request.getRequestDispatcher("movie_info.jsp").forward(request,response); 
	}
	
}
