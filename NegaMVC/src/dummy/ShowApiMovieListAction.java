package dummy;

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

import actions.Action;
import dao.MovieDao;
import dto.ApiVO;


public class ShowApiMovieListAction implements Action{

	MovieDao mDao = new MovieDao();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//api 날짜 구하기
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat df = new SimpleDateFormat("YYYYMMdd");
		cal.add(Calendar.DATE, -7);
		String weeklyday = df.format(cal.getTime());
		System.out.println(weeklyday);
		

		ArrayList<ApiVO> apiList = new ArrayList<ApiVO>();
		try{
			// parsing할 url 지정(API 키 포함해서)
			String apiurl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.xml?key=9cdf19c7cea4d9369ab54dce5a79fd75&targetDt="+weeklyday+"&itemPerPage=4";
			
			//▽긁어온 것
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiurl);	
			// root tag 
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			//▲긁어온 것
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("weeklyBoxOffice"); //박스 오피스 순위
			NodeList movieNm = doc.getElementsByTagName("movieNm");
			NodeList audiAcc = doc.getElementsByTagName("audiAcc");
			NodeList audiCnt = doc.getElementsByTagName("audiCnt");
			//System.out.println("파싱할 리스트 수 : "+ nList.getLength());
			
			for(int temp = 0; temp < nList.getLength(); temp++){
				Node movieApi = movieNm.item(temp);
				Node accApi = audiAcc.item(temp);
				Node cntApi = audiCnt.item(temp);
				Element e1 = (Element) movieApi;
				Element e2 = (Element) accApi;
				Element e3 = (Element) cntApi;
				apiList.add(new ApiVO(e3.getTextContent(),e2.getTextContent(),e1.getTextContent()));
			}	
			
			} catch (Exception e){	
			e.printStackTrace();
		}	
		for(ApiVO vo : apiList) { 
			System.out.println(mDao.showApiMovieList(vo));
			HttpSession session = request.getSession(); //객체가 아니라 참조변수이다.
			session.setAttribute("listMain",mDao.showApiMovieList(vo)); 
		}
		
		/* request.getRequestDispatcher("main_page.jsp").forward(request,response); */
	}

}
