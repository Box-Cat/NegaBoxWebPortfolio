package actions;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import dao.AllMovieDao;
import dto.ApiVO;
import dto.MainVO;
import dto.MovieAll;

public class AllMovieAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				AllMovieDao amDao = new AllMovieDao();
		
				//로그인 아이디 받기
				HttpSession session = request.getSession();
				String loginId = (String)(session.getAttribute("member_id"));
				String name = (String)(session.getAttribute("name"));
				
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
					
					// 파싱할 tag
					NodeList nList = doc.getElementsByTagName("weeklyBoxOffice");
					NodeList movieNm = doc.getElementsByTagName("movieNm");
					NodeList audiAcc = doc.getElementsByTagName("audiAcc");
					NodeList audiCnt = doc.getElementsByTagName("audiCnt");
					
					String[] Narr = new String[10];
					for(int temp = 0; temp < nList.getLength(); temp++){
						Node movieApi = movieNm.item(temp);
						Node accApi = audiAcc.item(temp);
						Node cntApi = audiCnt.item(temp);
							Element e1 = (Element) movieApi;
							Element e2 = (Element) accApi;
							Element e3 = (Element) cntApi;
							Narr[temp] = e1.getTextContent();
							
							pip += Integer.parseInt(e3.getTextContent());
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
						sumApi = Math.round(apinum*10)/10.0;
						Apisum[tt] = sumApi;
						tt++;
					}
	
				//mtlDao.getMovieList(listMovieName, listRating, listMoviePhoto);
				list = amDao.showLists(list, apiList);
				countList = amDao.countLike(countList, list);  
				movieCount = amDao.movieCount();
				notlist = amDao.showNotLists(apiList, notlist);
				countListNot = amDao.countLikeNot(countListNot, notlist);
				reviewCount = amDao.reviewCount(reviewCount, list);
				reviewCountNot = amDao.reviewCountNot(reviewCountNot, notlist);
				amDao.countMemberLike(loginId, hmapMovieCodeLike, hmapMovieCodeLike2, list, notlist); 
				//return을 안하면, 굳이 안 담아도 된다.
				
				request.setAttribute("weeklyday",weeklyday);
				request.setAttribute("reviewCount", reviewCount);
				request.setAttribute("reviewCountNot", reviewCountNot);
				request.setAttribute("hmapMovieCodeLike", hmapMovieCodeLike);
				request.setAttribute("hmapMovieCodeLike2", hmapMovieCodeLike2);
				request.setAttribute("movieCount", movieCount);
				request.setAttribute("list", list);
				request.setAttribute("notlist", notlist);
				request.setAttribute("reviewCount", reviewCount);
				request.setAttribute("reviewCountNot", reviewCountNot);
				request.setAttribute("Apisum", Apisum);
				request.setAttribute("countList", countList);
				request.setAttribute("countListNot", countListNot);
	
				request.getRequestDispatcher("all_movie.jsp").forward(request,response); 
	
	}

}
