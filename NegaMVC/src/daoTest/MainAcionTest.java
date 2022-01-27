package daoTest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dao.MovieDao;
import dao.ReviewDao;
import dao.WantToWatchDao;
import dto.ApiVO;
import dto.MainVO;

public class MainAcionTest {
	
	public static void main(String[] args) {
		
				//더미아이디
				String loginId = "PJH";
		
				MovieDao movieDao = new MovieDao();
				ReviewDao reviewDao = new ReviewDao();
				WantToWatchDao wtwDao = new WantToWatchDao();
				ArrayList<MainVO> listMain = new  ArrayList<MainVO>();
				ArrayList<MainVO> listMainCheck = new  ArrayList<MainVO>();
		
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
					
					DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
					DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
					Document doc = dBuilder.parse(apiurl);	
					// root tag 
					doc.getDocumentElement().normalize();
					System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
					
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
				}catch (Exception e){	
					e.printStackTrace();
				}	
				for(ApiVO vo : apiList) { 
					listMainCheck = movieDao.showApiMovieList(vo);
					System.out.println();
					System.out.println("listMain이다★★★★★★★★★★★★"); //현재 4개 잘 들어감.
					System.out.println(listMainCheck);
					listMain.addAll(new ArrayList<MainVO>(listMainCheck));
				}
				//현재 listMain에 1개만 들어간 것이 문제
				System.out.println("---------------------------------------------------------------------------------------------");
				ArrayList<Float> reviewCount = reviewDao.avgScore(listMain);
				for(float vo : reviewCount) { //왜 1번만 돌지??
					System.out.println("reviewCount이다☆☆☆☆☆☆☆☆☆☆☆☆☆☆"); 
					System.out.println(vo);
				}
				System.out.println("---------------------------------------------------------------------------------------------");
				ArrayList<Integer> heartCount = wtwDao.countLike(listMain); //4위만 들어가 있음. 1,2,3위를 덮어씌운건가???
				for(Integer vo : heartCount) {
					System.out.println("heartCount이다★★★★★★★★★★★★");
					System.out.println(vo);
				}
				System.out.println("---------------------------------------------------------------------------------------------");
				HashMap<String, Integer> hmapMovieCodeLike = wtwDao.countLikeMember(listMain, loginId); //4위만 들어가 있음. 1,2,3위를 덮어씌운건가???
                System.out.println(hmapMovieCodeLike);
                for( String key : hmapMovieCodeLike.keySet() ){
                	System.out.println("hmapMovieCodeLike이다☆☆☆☆☆☆☆☆☆☆☆☆☆☆"); 
                	Integer value = hmapMovieCodeLike.get(key);
                    System.out.println( String.format("키 : "+key+", 값 : "+value));
                }
				System.out.println("---------------------------------------------------------------------------------------------");
				//listMain을  reviewDao.avgScore();  wtwDao.countLike();  wtwDao.countLikeMember(); avgScore();에 넣어야 함
				
	}
}
