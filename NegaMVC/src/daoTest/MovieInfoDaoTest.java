package daoTest;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dao.MovieInfoDao;
import dto.ApiVO;
import dto.ReviewVO;

public class MovieInfoDaoTest {
	static String loginId = "PJH";
	static MovieInfoDao miDao = new MovieInfoDao();

	public static void main(String[] args) {
		//API날짜
				Date today = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				SimpleDateFormat df = new SimpleDateFormat("YYYYMMdd");
				cal.add(Calendar.DATE, -7);
				String weeklyday = df.format(cal.getTime());
				DecimalFormat decFormat = new DecimalFormat("#,###");
				
				int pip = 0;
				ArrayList<ApiVO> apiList = new ArrayList<ApiVO>();
				ArrayList<ReviewVO> listReview = new ArrayList<ReviewVO>();
				String movieName = null;
				String reviewCount = null;
				Date openingDay = null;
				int runningTime = 0;
				String director = null;
				String rating = null;
				String casting = null;
				String moviePhoto = null;
				String plot = null;
				String allType = null;
				String tag = null;
				String endName = null;
				String trailer = null;
				String trailerSub = null;
				String stealcut = null;
				String genre = null;
				String miniTitle = null;
				int dolby = 0;
				float corr = 0;
				int attendance = 0;
				String chartPit1 = null;
				String chartPit2 = null;
				int chartProduction = 1;
				int chartActor = 2;
				int cntApiDay = 3;
				int chartOst = 4;
				int chartVisual = 5;
				int chartStory = 5;
				
				
				//더미들
				String mName = "#웨스트사이드스토리"; //더미
				String movieCode = "#웨스트사이드스토리";//더미
				movieName = "웨스트 사이드 스토리"; //더미
				String textaera = "재미있어요";//더미
				String pit = "영상미,배우";
				
				miDao.showReviews(listReview, mName,today); //통과
				miDao.showMovieInfo(mName, movieName, openingDay, runningTime, director, rating, casting, moviePhoto, plot, allType, tag, endName, trailer, trailerSub, stealcut, genre, miniTitle, dolby);//통과
				
				//API
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
					for(int temp = 0; temp < nList.getLength(); temp++){
						Node movieApi = movieNm.item(temp);
						Node accApi = audiAcc.item(temp);
						Node cntApi = audiCnt.item(temp);
						
							Element e1 = (Element) movieApi;
							Element e2 = (Element) accApi;
							Element e3 = (Element) cntApi;
							System.out.println("######################");
							
							pip += Integer.parseInt(e3.getTextContent());
							
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
							for(ApiVO vo : apiList) {
								if(vo.getMovieNm().equals(movieName)) {
									accApi = vo.getAudiAcc();
									cntApi = vo.getAudiCnt();
								}
							}
							
							int pp = Integer.parseInt(cntApi);
							System.out.println("일자별 관객수 : " +pp);
							System.out.println("일자별 관객수 합 : " + pip);
							System.out.println("누적관객수 : " +accApi);
							System.out.println("로그인 아이디 체크 : " + loginId);
					
							System.out.println("================영화 정보 페이지 끝===================");
				
							
		
		//테스트
		reviewCount = miDao.countReview(mName, reviewCount);		
		miDao.reviewCalc(mName, chartStory, chartProduction, chartOst, chartVisual, chartActor, chartPit1, chartPit2, accApi, cntApi);
		miDao.insertReview(loginId, 10 , textaera, pit, movieCode);
	}
}
