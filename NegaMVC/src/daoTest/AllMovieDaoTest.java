package daoTest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dto.ApiVO;
import dto.MovieAll;

public class AllMovieDaoTest {
	static void test메서드로만들어야지() {
		String loginId = "PJH";
		
		//api 날짜 구하기
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		SimpleDateFormat df = new SimpleDateFormat("YYYYMMdd");
		cal.add(Calendar.DATE, -7);
		String weeklyday = df.format(cal.getTime());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
	
		int pip = 0;
		ArrayList<ApiVO> apiList = new ArrayList<ApiVO>();
		ArrayList<MovieAll> list = new ArrayList<MovieAll>();
		ArrayList<MovieAll> notlist = new ArrayList<MovieAll>();
		ArrayList<Integer> countList = new ArrayList<Integer>();
		ArrayList<Integer> countListNot = new ArrayList<Integer>();
		ArrayList<Float> reviewCount = new ArrayList<Float>();
		ArrayList<Float> reviewCountNot = new ArrayList<Float>();
		HashMap<String, Integer> hmapMovieCodeLike = new HashMap<String, Integer>();
		HashMap<String, Integer> hmapMovieCodeLike2 = new HashMap<String, Integer>();
		int movieCount = 0;
		double[] Apisum = new double[10];
		
		try{
			// parsing할 url 지정(API 키 포함해서)
			String apiurl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.xml?key=9cdf19c7cea4d9369ab54dce5a79fd75&targetDt="+weeklyday;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(apiurl);
			
			// root tag
			
			doc.getDocumentElement().normalize();
			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			
			// 파싱할 tag
			NodeList nList = doc.getElementsByTagName("weeklyBoxOffice");
			NodeList movieNm = doc.getElementsByTagName("movieNm");
			NodeList audiAcc = doc.getElementsByTagName("audiAcc");
			NodeList audiCnt = doc.getElementsByTagName("audiCnt");
			//System.out.println("파싱할 리스트 수 : "+ nList.getLength());
			
			String[] Narr = new String[10];
			for(int temp = 0; temp < nList.getLength(); temp++){
				Node movieApi = movieNm.item(temp);
				Node accApi = audiAcc.item(temp);
				Node cntApi = audiCnt.item(temp);
					Element e1 = (Element) movieApi;
					Element e2 = (Element) accApi;
					Element e3 = (Element) cntApi;
					System.out.println("######################");
					Narr[temp] = e1.getTextContent();
					
					pip += Integer.parseInt(e2.getTextContent());
					System.out.println(e1.getTextContent());
					System.out.println(e2.getTextContent());
					System.out.println(e3.getTextContent());
					apiList.add(new ApiVO(e3.getTextContent(),e2.getTextContent(),e1.getTextContent()));
					// for end
			}	// if end
			
			} catch (Exception e){	
			e.printStackTrace();
		}	// try~catch end	
		
		String accApi = "";
		String cntApi = "";
		float n = 0; 
		float m = 0; 
		float apinum = 0; 
		double sumApi = 0;
			//double[] Apisum = new double[10];
			int tt = 0;
			for(ApiVO vo : apiList) {
				n = Float.parseFloat(vo.getAudiCnt());
				m = Float.parseFloat(vo.getAudiAcc());
				apinum = n / pip * 100;
				System.out.println();
				System.out.println("누적관객수 계산: " + apinum);
				sumApi = Math.round(apinum*10)/10.0;
				System.out.println("예매율 계산: " + sumApi);
				Apisum[tt] = sumApi;
				tt++;
				System.out.println("apiList : "+apiList);
			}
		System.out.println("누적관객수 : " +accApi);
		System.out.println("로그인 아이디 체크 : " + loginId);
		System.out.println("================영화 정보 페이지 끝===================");
	}
	
	public static void main(String[] args) {
		test메서드로만들어야지();
	}
}
