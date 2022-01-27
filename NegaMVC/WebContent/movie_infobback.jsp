<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"
import="java.util.Date"
import="javax.servlet.ServletException"
import="javax.servlet.annotation.WebServlet"
import="javax.servlet.http.HttpServlet"
import="javax.servlet.http.HttpServletRequest"
import="javax.servlet.http.HttpServletResponse"
import="javax.xml.parsers.DocumentBuilder"
import="javax.xml.parsers.DocumentBuilderFactory"
import="org.w3c.dom.Document"
import="org.w3c.dom.Element"
import="org.w3c.dom.Node"
import="org.w3c.dom.NodeList" %>


<%
	String mName = request.getParameter("mName");	// movie_code 넘어옴
	System.out.println(mName);
	String likeId = request.getParameter("id");
	String loginId = (String)(session.getAttribute("member_id"));
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "megabox";
	String userPw = "user1234";
	
	Connection conn = null;
	ArrayList<ReviewVO> listReview = new ArrayList<ReviewVO>();
	
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, userPw);
	} catch(Exception e) {
		e.printStackTrace();
	} 

	String sql ="select * from review where movie_code = ? order by write_date desc";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, "#연애빠진로맨스");
	ResultSet rs = pstmt.executeQuery();
	
	float scoreaver = 0;
	while(rs.next()) {
		String memberId = rs.getString("member_id");
		int score = rs.getInt("score");
		String reviewText = rs.getString("review_text");
		String viewingPoints = rs.getString("viewing_points");
		int report = rs.getInt("report");
		String movieCode = rs.getString("movie_code");
		Date writeDate = rs.getTimestamp("write_date");
		scoreaver += score;
		listReview.add(new ReviewVO(memberId,score,reviewText,viewingPoints,report,movieCode,writeDate));
	}
	
	System.out.println("관람평 합계 : " + scoreaver);
	float cor = scoreaver/ listReview.size();
	System.out.println("관람평 평균 : " + cor);
	
	/* float coee = Math.round(cor*100)/10.0; */
	
	sql = "select * from movie where movie_code = ? ";
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, "#연애빠진로맨스"); 
	
	rs = pstmt.executeQuery();
	
	rs.next();
	
	String movieName = rs.getString("movie_name");
	Date openingDay = rs.getDate("opening_day");
	int runningTime = rs.getInt("running_time");
	String director = rs.getString("director");
	String rating = rs.getString("rating");
	String casting = rs.getString("casting");
	String moviePhoto = rs.getString("movie_photo");
	String plot = rs.getString("plot");
	String allType = rs.getString("alltype");
	String tag = rs.getString("tag");
	String endName = rs.getString("eng_name");
	String trailer = rs.getString("trailer");
	String trailerSub = rs.getString("trailer_sub");
	String stealcut = rs.getString("stealcut");
	String genre = rs.getString("genre");
	String miniTitle = rs.getString("mini_title");
	int dolby = rs.getInt("dolby");
	
%>

<%
	ArrayList<ApiVO> apiList = new ArrayList<ApiVO>();
	try{
		// parsing할 url 지정(API 키 포함해서)
		String apiurl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.xml?key=9cdf19c7cea4d9369ab54dce5a79fd75&targetDt=20220101";
		
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
				System.out.println("누적관객수 : " +accApi);
				System.out.println("로그인 아이디 체크 : " + loginId);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link href='css/header_footer.css?a' rel='stylesheet' type='text/css'>
<link href='css/movie_info.css?s' rel='stylesheet' type='text/css'>
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEET PLAY SHARE, 내가박스</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$('#exitButton').on("click",function(){
		$(this).parents(".background").toggleClass('on');
	});
	
	$('#loginBox').on("click",function(){
		$(".background").toggleClass('on');
	});
	
	$('#movelogin').on("click",function(){
		$(".layer-mynega").removeClass("on");
		$(".background").addClass('on');
	});
	
	$('.mymegabox').click(function(){
		$(this).toggleClass("on");
		$(".layer-mynega").toggleClass("on");
	});
	
	$('#sitemap').click(function(){
		$(this).toggleClass("on");
		$('.layer-sitemap').toggleClass("on");
	});
	
	$('.gnb-txt-movie, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-movie, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});

	$('.gnb-txt-reserve, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-reserve, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-theater, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-theater, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-event, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-event, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-benefit, .gnb-depth2').mouseover(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-benefit, .gnb-depth2').mouseout(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.button.close-layer').click(function(){
		$('.modal-layer').removeClass("on");
	});
	
	$('.btn-modal-close').click(function(){
		$('.modal-layer').removeClass("on");
	});
	
	$('.tooltip-click.oneWrtNonMbBtn').click(function(){
		/* $('.modal-layer').addClass('on'); */
		if(<%=loginId%> == null) {
		alert("로그인후 이용가능 합니다.");
		} else if(<%=loginId%> != null) {
		$('.modal-layer').addClass('on');
		}
	});
	
	$('#review_btn').click(function(){
		/* $('.modal-layer').addClass('on'); */
		if(<%=loginId%> == null) {
			alert("로그인후 이용가능 합니다.");
			} else if(<%=loginId%> != null) {
			$('.modal-layer').addClass('on');
			}
	});
	
	var starnum;
	$('.star').children('.group').mouseover(function(){
		
		$(this).children('button').addClass('on');
		
		$(this).children('button').mouseover(function(){
			starnum = $(this).attr('value');
			$('.num').find('em').text(starnum);
		});
	});
	
	var maxbtn = 0;
	$('.point').find('.btn').click(function(){
		$(this).toggleClass('on');
		maxbtn++;
		
		if(maxbtn >= 3) {
			$('.point').find('.btn').removeClass('on');	
			maxbtn = 0;
		};
	});
	
});
</script>
</head>
<body>
	<!-- header -->
	<header id="header" class="main-header no-bg">
		<div class="ci">
		<a href="main_page.jsp" title="내가박스 메인으로 가기"></a>
		</div>
		<div class="util-area">
			<div class="left-link">
				<a href="#" title="VIP LOUNGE">VIP LOUNGE</a>
				<a href="#" title="맴버십">멤버십</a>
				<a href="#" title="고객센터">고객센터</a>
			</div>
			<div class="right-link">
				<%if(loginId == null) { %>
				<a href="#" title="로그인" id="loginBox">로그인</a>
				<%} else { %>
				<a href="logout.jsp" title="로그아웃" id="loginBox">로그아웃</a>
				<% } %> 
				<%if (loginId == null) { %>
				<a href="#" title="회원가입">회원가입</a>
				<%} else { %>
				<a href="#" title="알림">알림</a>
				<% } %>
				<a href="#" title="빠른예매">빠른예매</a>
			</div>
		</div>
		<div class="link-area">
			<a href="#" id="sitemap" class="menu-open-btn" title="사이트맵">사이트맵</a>
			<!-- <a href="#" id="search" class="search-btn" title="검색">검색</a>  미구현   -->
			<a href="javascript:void(0);" class="mymegabox" title="나의메가박스">나의메가박스</a>
			<a href="movie-theater-table.jsp" class="link-ticket" title="상영시간표">상영시간표</a>
		</div>
			
		<nav id="gnb" class="">
			<ul class="gnb-depth1">
				<li class=""> <!-- <<<<< on으로 메뉴조정 -->
					<a href="전체영화" class="gnb-txt-movie" title="영화"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="전체영화" title="전체영화">전체영화</a></li>
							<li><a href="N스크린" title="N스크린">N스크린</a></li>
							<li><a href="큐레이션" title="큐레이션">큐레이션</a></li>
							<li><a href="무비포스트" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="빠른예매" class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="빠른예매" title="빠른예매">빠른예매</a></li>
							<li><a href="상영시간표" title="상영시간표">상영시간표</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="극장" class="gnb-txt-theater" title="극장"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="전체영화" title="전체극장">전체극장</a></li>
							<li><a href="N스크린" title="특별관">특별관</a></li>
						</ul>
					</div>
				</li>
				<li class=""> 	<!-- <<<<< on으로 메뉴조정 -->
					<a href="이벤트" class="gnb-txt-event" title="이벤트"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="공사중" title="진행중 이벤트">진행중 이벤트</a></li>
							<li><a href="공사중" title="지난 이벤트">지난 이벤트</a></li>
							<li><a href="공사중" title="당첨자 발표">당첨자 발표</a></li>
						</ul>
					</div>
				</li>
				<li>	
					<a href="스토어" class="gnb-txt-store" title="스토어"></a>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="혜택" class="gnb-txt-benefit" title="혜택"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="전체영화" title="내가박스 맴버십">내가박스 맴버십</a></li>
							<li><a href="N스크린" title="제휴/할인">제휴/할인</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		<!--  on off 사이트맵  -->
		<div id='layer_sitemap' class='layer-sitemap'> <!-- on을 놓으면 켜지고, 빼면 꺼짐 display:none으로 조정함 -->
		<div class='layer_sitemap_wrap'>
			<a href="" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>
			<p class="tit">SITEMAP</p>
			<div class="list position-1">
				<p class="tit-depth">영화</p>
				<ul class="list-depth">
					<li><a href="/movie" title="전체영화">전체영화</a></li>
					<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
					<li><a href="javascript:void(0)" onclick="javascript:MegaboxUtil.Common.moveMovieFilmCheck();"
							title="영화제">영화제</a></li>
					<li><a href="/moviepost/all" title="무비포스트">무비포스트</a></li>
				</ul>
			</div>

			<div class="list position-2">
				<p class="tit-depth">예매</p>

				<ul class="list-depth">
					<li><a href="/booking" title="빠른예매">빠른예매</a></li>
					<li><a href="/booking/timetable" title="상영시간표">상영시간표</a></li>
					<li><a href="/booking/privatebooking" title="더 부티크 프라빗 예매">더 부티크 프라이빗 예매</a></li>
				</ul>
			</div>

			<div class="list position-3">
				<p class="tit-depth">극장</p>

				<ul class="list-depth">
					<li><a href="/theater/list" title="전체극장">전체극장</a></li>
					<li><a href="/specialtheater/list" title="특별관">특별관</a></li>
				</ul>
			</div>

			<div class="list position-4">
				<p class="tit-depth">이벤트</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0)" onclick="NetfunnelChk.aTag('EVENT_LIST','/event');return false;"
							title="진행중 이벤트">진행중 이벤트</a></li>
					<li><a href="javascript:void(0)"
							onclick="NetfunnelChk.aTag('EVENT_LIST','/event/end');return false;" title="지난 이벤트">지난
							이벤트</a></li>
					<li><a href="javascript:void(0)"
							onclick="NetfunnelChk.aTag('EVENT_LIST','/event/winner/list');return false;"
							title="당첨자발표">당첨자발표</a></li>
				</ul>
			</div>

			<div class="list position-5">
				<p class="tit-depth">스토어</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0)" onclick="NetfunnelChk.aTag('STORE_LIST','/store');return false;"
							title="새로운 상품">새로운 상품</a></li>
					<li><a href="javascript:void(0)"
							onclick="NetfunnelChk.aTag('STORE_LIST','/store/megaticket');return false;"
							title="메가티켓">메가티켓</a></li>
					<li><a href="javascript:void(0)"
							onclick="NetfunnelChk.aTag('STORE_LIST','/store/megachance');return false;"
							title="메가찬스">메가찬스</a></li>
					<li><a href="javascript:void(0)"
							onclick="NetfunnelChk.aTag('STORE_LIST','/store/popcorn');return false;"
							title="팝콘/음료/굿즈">팝콘/음료/굿즈</a></li>
					<li><a href="javascript:void(0)" onclick="NetfunnelChk.aTag('STORE_LIST','/store/e-giftcard');return false;" title="기프트카드">기프트카드</a></li>
				</ul>
			</div>

			<div class="list position-6">
				<p class="tit-depth">나의 메가박스</p>
				<ul class="list-depth mymage">


					<li><a href="javascript:movePage('/mypage',						'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="나의 메가박스 홈">나의 메가박스 홈</a></li>
					<li><a href="javascript:movePage('/mypage/bookinglist',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="예매/구매내역">예매/구매내역</a></li>
					<li><a href="javascript:movePage('/mypage/movie-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="영화관람권">영화관람권</a></li>
					<li><a href="javascript:movePage('/mypage/store-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="스토어교환권">스토어교환권</a></li>
					<li><a href="javascript:movePage('/mypage/discount-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>

					<li><a href="javascript:movePage('/mypage/point-list',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="멤버십포인트">멤버십포인트</a></li>
					<li><a href="javascript:movePage('/mypage/moviestory',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="나의 무비스토리">나의 무비스토리</a></li>
					<li><a href="javascript:movePage('/mypage/myevent',				'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="나의 이벤트 응모내역">나의 이벤트 응모내역</a></li>
					<li><a href="javascript:movePage('/mypage/myinquiry',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
							title="나의 문의내역">나의 문의내역</a></li>
					<li><a href="#" title="자주쓰는 할인 카드">자주쓰는 할인 카드</a></li>
					<li><a href="javascript:movePage('/on/oh/ohh/Mypage/mainPage.do?returnURL=info','로그인이 필요한 서비스 입니다.');"
							title="회원정보">회원정보</a></li>

				</ul>
			</div>


			<div class="list position-7">
				<p class="tit-depth">혜택</p>

				<ul class="list-depth">
					<li><a href="/benefit/membership" title="멤버십 안내">멤버십 안내</a></li>
					<li><a href="/benefit/viplounge" title="VIP LOUNGE">VIP LOUNGE</a></li>
					<li><a href="/benefit/discount/guide" title="제휴/할인">제휴/할인</a></li>
				</ul>
			</div>

			<div class="list position-8">
				<p class="tit-depth">고객센터</p>

				<ul class="list-depth">
					<li><a href="/support" title="고객센터 홈">고객센터 홈</a></li>
					<li><a href="/support/faq" title="자주묻는질문">자주묻는질문</a></li>
					<li><a href="/support/notice" title="공지사항">공지사항</a></li>
					<li><a href="/support/inquiry" title="1:1문의">1:1문의</a></li>
					<li><a href="/support/rent" title="단체/대관문의">단체/대관문의</a></li>
					<li><a href="/support/lost" title="분실물문의">분실물문의</a></li>
				</ul>
			</div>

			<div class="list position-9">
				<p class="tit-depth">회사소개</p>

				<ul class="list-depth">
					<li><a href="/megaboxinfo" target="_blank" title="메가박스소개">메가박스소개</a></li>
					<li><a href="/socialcontribution" target="_blank" title="사회공헌">사회공헌</a></li>
					<li><a href="/advertize" target="_blank" title="홍보자료">홍보자료</a></li>
					<li><a href="/partner" target="_blank" title="제휴/부대사업문의">제휴/부대사업문의</a></li>
					<li><a href="/onlinereport" target="_blank" title="온라인제보센터">온라인제보센터</a></li>
					<li><a href="/ir" target="_blank" title="자료">IR자료</a></li>
					<li><a href="/recruit" target="_blank" title="인재채용림">인재채용</a></li>
					<li><a href="https://jebo.joonganggroup.com/main.do" target="_blank" title="윤리경영">윤리경영</a></li>
				</ul>
			</div>


			<div class="list position-10">
				<p class="tit-depth">이용정책</p>

				<ul class="list-depth">
					<li><a href="/support/terms" title="이용약관">이용약관</a></li>
					<li><a href="/support/privacy" title="개인정보처리방침">개인정보처리방침</a></li>
					<li><a href="/support/screenrule" title="스크린수배정에관한기준">스크린수배정에관한기준</a></li>
				</ul>
			</div>

			<div class="ir">
				<a href="" class="layer-close" title="레이어닫기">레이어닫기</a>
			</div>


		</div>
	</div>
		<!-- layer-mynega on off -->
		<div id="header-layer-mynega" class="layer-mynega">
			<a class="ir" title="나의 내가박스 레이어 입니다."></a>
			<div class="wrap">
				<%if(loginId == null) { %>
				<!--  로그인 전  -->
				<div class="login-before">
					<p class="txt">
						로그인 하시면 나의 메가박스를 만날 수 있어요.
						<br/>
						영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해 보세요!
					</p>
					<div class="mb50">
						<a href="#" id="movelogin" title="로그인" class="button" style="width:120px;">로그인</a>
					</div>
					<a href="#" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직 회원이 아니신가요?</a>
				</div>
				<%} else { %>
				<!--  로그인 후    -->
				<div class="login-after" >
					<div class="user-info">
						<p class="txt">안녕하세요</p>
						<p class="info">
							<em class="name">회원 이름 입력</em>
							<span>회원님</span>
						</p>
						<div class="last-date">
							마지막 접속일 : 
							<em>접속 날짜 계산후 입력</em>
						</div>
						<div class="btn-fixed">
							<a href="마이페이지" class="button" title="나의 내가박스">나의 내가박스</a>
						</div>
					</div>
					<div class="box">
						<div class="point">
							<p class="tit">Point</p>
							<p class="count">0</p>
							<div class="btn-fixed">
								<a href="공사중" class="button" title="맴버십 포인트">맴버십포인트</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="coupon">
							<p class="tit">쿠폰/관람권</p>
							<p class="count">
								<em title="쿠폰 수" class="cpon">0</em>
								<span title="관람권수" class="movie">0</span>
							
							<div class="btn-fixed">
								<a href="#" class="button" title="쿠폰">쿠폰</a>
								<a href="#" class="button" title="관람권">관람권</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="reserve">
							<p class="tit">예매</p>
							<p class="txt">예매내역이 없어요!</p>
							<div class="btn-fixed">
								<a href="#" class="button" title="예매내역">예매내역</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="buy">
							<p class="tit">구매</p>
							<p class="count">
								<em>0</em>
								<span>건</span>
							</p>
						</div>
						<div class="btn-fixed">
							<a href="#" class="button" title="구매내역">구매내역</a>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</header>
	
	<!-- ▽로그인 창 -->
	<!-- on으로 조정함 -->
	<div class="background ">
		<!-- 	<div style="height:100px;"></div>
		 --><div class="wrap1">
				<div class="wrap-login">
					<h3 class="tit fl">로그인</h3>
						<a id="exitButton" href="#" class="fr"><img src="image/btn-layer-close.png"/></a>
					<div style="clear:both;"></div>
				</div>
				<form action="login_action.jsp">
				<div class="layer-login">
					<div class="login-input-area">
						<input type="text" placeholder="아이디" id="id" name="id"/> <br/>
						<input type="password" placeholder="비밀번호" id="pw" name="pw"/> <br/>
					</div>
					<div class="chk">
						<div>
							<input id="chkbox" type="checkbox" style="font-size:14px; color:#444444;">
							아이디 저장
								<div class="ad">
									<a href=""></a>
										<span>휴대폰 간편로그인 </span>
										<span style="border:1px solid #3d7db7; font-size:14px; border: 1px solid #3d7db7; font-size: 14px; padding-left: 7px; padding-right: 7px;">광고</span>
								</div>
						</div>

					</div>
						<input type='submit' value='로그인' class="but">
					<div class="link">
						<a href="" style="text-decoration: none; color:#666666">ID/PW 찾기</a>
						<img src="image/I.png" style="margin: -9px; margin-left: -20px; margin-right: -25px;"/>
						<a href="" style="text-decoration: none; color:#666666">회원가입</a>
						<img src="image/I.png" style="margin: -9px; margin-right: -25px; margin-left: -20px;"/>
						<a href="" style="text-decoration: none; color:#666666">비회원 에매확인</a>
					</div>
					<div class="sns-login">
						<a href="">
						<img src="image/ico-facebook.png">
						</a>
						<a href="">
						<img src="image/ico-naver.png">
						</a>
						<a href="">
						<img src="image/ico-kakao.png">
						</a>
						<a href="">
						<img src="image/ico-payco.png">
						</a>
					</div>
					<div class="col-right">
					</div>
				</div>
				</form>
				<div class="right-login">
					<div class="login-ad">
						<a href="">
							<img src="image/fecf1f96c23d2dfc4deaeba5b8c33828.jpg">
						</a>
					</div>
				</div>
			</div>
		</div>
	<!-- △로그인 창 -->
	
	<!-- ▽main  -->
	<div class="movie-detail-page">
	<div class="bg-img" style="background-image:url(movie_photo/<%=moviePhoto%>)"></div>
	<div class="bg-pattern"></div>
	<div class="bg-mask"></div>
	<div class="movie-detail-cont">
		<!-- <p class="d-day default">예매 D-5</p> -->
		<p class="contents-type"><%=tag %></p>
		<P class="title"><%=movieName%></P>
		<p class="title-eng"><%=endName %></p>
		<div class="btn-util">
				<button class="btn btn-like">
					<i class="iconset ico-heart-line"></i>
					<span>3.4K</span>
				</button>
				<div class="sns-share">
					<a href="#" class="btn btn-common-share" title="공유하기">
					<i class="icoset ico-sns-line"></i>
					공유하기
					</a>
				</div>
		</div>
		<div class="info">
			<div class="rate" style="padding:0">
				<p class="tit">예매율</p>
				<%
				for(ApiVO vo : apiList) {
					if(vo.getMovieNm().equals(movieName)) {
						float i = Float.parseFloat(vo.getAudiCnt());
						float j = Float.parseFloat(vo.getAudiAcc());
						float apinum = i / j * 100;
				%>
				<p class="cont">
					<em><%=Math.round(apinum*100)/10.0 %>%</em>
					
				</p>
				<% 	}
				} %>
			</div>
			<div class="audience">
				<div class="tit">
					<span class="m-tooltip-warp">
					누적관객수
						<em class="tootip m105">
							<i class="iconset ico-tooltip-gray">툴팁보기</i>
						</em>
					</span>
				</div>
				<p class="cont">
					<em><%=accApi%></em>
					명
				</p>
			</div>
		</div>
		<div class="poster">
			<div class="wrap">
				<p class="movie-grade age-12"><%=rating %></p>
				<img src="movie_photo/<%=moviePhoto%>">
				<!-- <a href="#" class="btn-poster-down" title="포스터 다운로드">포스터 다운로드</a> -->
			</div>
		</div>
		<div class="reserve screen-type col-2">
			<div class="reserve">
				<%if (dolby == 0){ %>
				<a href="#" class="btn reserve" title="영화 예매하기">예매</a>
				<a href="#" class="btn dolby">
					<img src="image/mov_detail_db_btn.png">
				</a>
				<% } else { %>
				<a href="#" class="btn reserve" title="영화 예매하기" style="width: 100%; margin: 0; border-radius: 5px;">예매</a>
				<%	} %>
			</div>
		</div>
	</div>
</div>
<div class="inner-wrap">
	<div class="tab-list fixed">
		<ul>
			<li class="on">
				<a href="movie_info.jsp" title="주요정보 탭으로 이동">주요정보</a>
			</li>
			<li>
				<a href="movie_info_review.jsp" title="실관람평 탭으로 이동">실관람평</a>
			</li>
			<li>
				<a href="movie_info_poster.jsp" title="무비포스트 탭으로 이동">무비포스트</a>
			</li>
			<li>
				<a href="movie_info_stillcut.jsp" title="예고편/스틸컷 탭으로 이동">예고편/스틸컷</a>
			</li>
		</ul>
	</div>
	<div class="movie-summary infoContent" id="info">
		<div class="txt">
			<%=plot %>
		</div>
		<div class="btn-more toggle" style="display: none;">
			<button type="button" class="btn">
				<span>더보기</span>
				<i class="iconset ico-btn-more-arr"></i>
			</button>
		</div>
	</div>
	<div class="movie-info infoContent">
		<p>상영타입 : <%=allType %></p>
		<div class="line">
			<p>감독 : <%=director %></p>
			<p>장르 : <%=genre %> / <%=runningTime %> 분</p>
			<p>등급 : <%=rating %></p>
			<p>개봉일 : <%=openingDay%></p>
		</div>
		<p>출연진 : <%=casting %></p>
	</div>
	<div class="movie-graph infoContent">
		<div class="col">
            <dl>
                <dt>관람포인트</dt>
                <dd id="charByPoint">배우·스토리</dd>
            </dl>
            <div class="graph" style="position: relative; bottom: 0px;">
                <canvas id="chartByStart" style="width: 216px; height: 216px; display: block;" width="216" height="216" class="chart-Radar"></canvas>   
                <!-- <img src="image/movie_info/no-graph01.jpg" alt="기대포인트 결과 없음" style=""> -->
            </div>
            
            <script>
            var marksCanvas = document.getElementById("chartByStart");
            var myChart = new Chart(marksCanvas, {
                type: 'radar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                        '연출','배우','OST','영상미','스토리',
                    ],
                    datasets: [
                        { //데이터
                            label: '관람포인트', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                                	45,80,33,58,99 //x축 label에 대응되는 데이터 값
                            ],
                            backgroundColor: [
                                //색상
                                'transparent'
                            ],
                            borderColor: [
                                //경계선 색상
                                '#6543b1'
                            ],
                           
                            borderWidth: 3, //경계선 굵기
                            pointRadius: 1,
                            Radius: 6,
                            pointBorderWidth: 2,
                        }
                    ]
                },
                options: {
                	legend: {
                		display: false
                	},
                	angleLines: {
                		display: true
                	},
                	
                	scale: {
                		   ticks: {
                			  display: false,
                			  stepSize: 5,
                			  maxTicksLimit: 5,
                			  
                		   }
                	}	
                }
            });
        	
            </script>
        </div>
        <div class="col" id="subMegaScore">
            <dl>
                <dt>실관람 평점</dt>
                <dd class="font-roboto regular"><em><%=cor %></em><span class="ir">점</span></dd>
            </dl>
				<div class="middle">
					<div class="circle">
						<em><%=cor %></em>
						<span class="ir">점</span>
					</div>
					<p>관람 후</p>
				</div>
                    <!-- <div class="graph">
                        <img src="image/movie_info/no-graph02.jpg" alt="메가스코어 결과 없음">
                    </div> -->
                    <div class="score" style="position: relative; bottom: 29px; display: none;">
                        <div class="before">
                            <div class="circle"><em>0</em><span class="ir">점</span></div>
                            <p>관람 전</p>
                        </div>
                        <div class="after">
                            <div class="circle"><em>0</em><span class="ir">점</span></div>
                            <p>관람 후</p>
                        </div>
                    </div>
        </div>
        <!-- <div class="col">
            <dl>
                <dt>예매율</dt>
                <dd class="font-roboto regular">
                    <span id="rkTag">86.2%</span>
                </dd>
            </dl>

            <div class="graph" style="position: relative; bottom: 10px; right: 10px;"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                <canvas id="chartByBar" style="display: block; width: 216px; height: 216px;" width="216" height="216" class="chartjs-render-monitor"></canvas>
                <img src="image/movie_info/no-graph03.jpg" alt="기대율 결과 없음" style="display: none;">
            </div>
        </div> -->
        <div class="col">
            <dl>
                <dt>일자별관객수</dt>
                <dd class="font-roboto regular">        
                        <%=accApi %>
                </dd>
            </dl>

            <div class="graph">
                <canvas id="chartByLine" style="width: 220px; height: 205px;"></canvas>
                <script>
                var context2 = document.getElementById('chartByLine')
                
            var myChart2 = new Chart(context2, {
                type: 'line', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
                        '12.29','12.30','12.31','01.01','01.02'
                    ],
                    datasets: [
                        { //데이터
                            label: '누적관객수', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                                147549,137452,191124,289165,225375 //x축 label에 대응되는 데이터 값
                            ],
                            backgroundColor: [
                                //색상
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(54, 162, 235, 0.2)'
                                
                            ],
                            borderColor: [
                                //경계선 색상
                            	'#329eb1'
                            ],
                            borderWidth: 1, //경계선 굵기
                            tension: 0
                        }
                    ]
                },
                options: {
                	legend: {
                		display: false
                	},
                    scales: {
                        yAxes:[{
                                ticks: {
                                    beginAtZero: true,
                                    display: false,
                                    drawBorder: false
                                },
                        		gridLines: {
                            		color: "rgba(0, 0, 0, 0)",
                       			},
                                
                            }
                        ],
                        xAxes: [{
                            gridLines: {
                                borderDash: [2, 5],
                                color: '#444',
                            },
                        }]
                    }
                }
            });
                </script>
                <!-- <img src="image/movie_info/no-graph04.jpg" alt="일자별 관객수 결과 없음" style=""> -->
            </div>
        </div>    
	</div>
	<div class="tit-util mt70 mb15">
	<!--  영화 정보 가져올것  영화 제목 , 리뷰 카운트 -->
		<h2 class="tit small">
	<%=movieName %>에 대한
			<span class="font-gblue">11,210</span>개의 이야기가 있어요!
		</h2>
	</div>
	<div class="movie-idv-story oneContent">
	
	 <!-- 본 영화가 아닌경우 -->
        <ul>
            <li class="type03">
                <div class="story-area">
                    <!-- 프로필영역  -->
                    <!--  로그 아웃시  -->
                    <%if(loginId == null) { %>
                    <div class="user-prof">
                        <div class="prof-img"><img src="image/ico-mega-profile.png" alt="MEGABOX"></div>
                        <p class="user-id">MEGABOX</p>
                    </div>
                    <% } else { %>
                    <!--  로그인 시 -->
                    <div class="user-prof">
                        <div class="prof-img"><img src="image/ico-mega-profile.png" alt="MEGABOX"></div>
                        <p class="user-id"><%=loginId %></p>
                    </div>
                    <% } %>
                    <!-- // 프로필영역 -->
					
                    <!-- 내용 영역 -->
                    <div class="story-box">
                        <div class="story-wrap">
                            <div class="story-cont">
                                <span class="font-gblue"><%=movieName %></span>재미있게 보셨나요? 영화의 어떤 점이 좋았는지 이야기해주세요.
                            </div>
                            <div class="story-write">
			                	 <!-- 로그인이 안되있을시 -->
                                	<a href="javascript:void(0);" class="tooltip-click oneWrtNonMbBtn" w-data="500" h-data="680" data-cd="PREV" title="관람평쓰기"><i class="iconset ico-story-write" id="review_btn"></i> 관람평쓰기</a>		                	    						
                            </div>
                        </div>
                    </div>
                    <!-- // 내용 영역 -->
                </div>
            </li>
           
            <!----------------------- 관람평  --------------------------------------------------->
           <%for(ReviewVO vo : listReview) { %>
            <li class="type01 oneContentTag">
            	<div class="story-area">
            		<div class="user-prof">
            			<div class="prof-img">
            				<img src="image/bg-profile.png" alt="프로필사진" title="프로필사진"/>
            			</div>
            			<p class="user-id"><%=vo.getMemberId() %><p>
            		</div>
            		<div class="story-box">
            			<div class="story-wrap review">
            				<div class="tit">관람평</div>
            				<div class="story-cont">
            					<div class="story-point">
            						<span><%=vo.getScore() %></span>
            					</div>
            					<div class="story-recommend">
            						<% String viewP = vo.getViewingPoints();
            						String[] viewArr = viewP.split(",");
            						%>
            						<em><%=viewArr[0] %></em>
            						<%if(viewArr[1].equals("x")) { %>
            						<%} else {%>
            						<em><%=viewArr[1] %></em>
            						<%	} %>
	            				</div>
	            				<div class="story-txt">
	            					<%=vo.getReviewText() %>
	            				</div>
	            				<div class="story-like">
	            					<%-- <button type="button" class="onelikeBtn" title="댓글 추천">
	            						<i class="iconset ico-like-gray"></i>
	            						<span><%=vo.getReport() %></span>
	            					</button> --%>
	            				</div>
	            				<div class="story-util">
	            					<div class="post-funtion">
	            						<div class="wrap">
	            							<!-- <button	type="button" class="btn-alert"></button> -->
	            							<!--  balloon on 으로 서브창 열림 -->
	            							<div class="balloon-space user">
	            								<div class="balloon-cont">
	            									<div class="user">
	            										<p class="reset a-c">
	            										스포일러 및 욕설/비방하는
	            										<br/>
	            										내용이 있습니까?
	            										</p>
	            										<button type="button" class="maskOne">
	            											댓글 신고
	            											<i class="iconset ico-arr-right-green"></i>
	            										</button> 
	            									</div>
	            								</div>
	            							</div>
	            						</div>
            						</div>
            					</div>
	            			</div>
	            		</div>
	            	</div>
	            </div>
	            <div class="story-date">
	            	<% 
	          		Date time = new Date();
	            	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	            	
	            	String ftime = simpleDateFormat.format(vo.getWriteDate());
	            	Date formatDate = simpleDateFormat.parse(ftime);
	            	
	            	long sumtime = time.getTime() - formatDate.getTime();
	            	
	            	long hours = sumtime / (60*60*1000); 
	            	long minutes = sumtime / (60*1000);
	            	long day = sumtime / (24*60*60*1000);
	            	long second = sumtime / (1000);
	            	if(day >= 1) {
	            	%>
            		<div class="review on"><span><%=day %> 일전</span></div>
            	 <% } else if(hours >= 1 || hours > 24) { %>
            		<div class="review on"><span><%=hours %> 시간전</span></div>
            	 <% } else if(minutes >= 1 || minutes > 60) { %>
            		<div class="review on"><span><%=minutes %> 분전</span></div>
            	 <% } else if(second < 60) { %>
            		<div class="review on"><span>방금</span></div>
            	  <% } %>
            	</div>
            </li>	
            <% } %>
  
 	<!-- 관람평 종료 -->
        </ul>
    </div>
    <!-- 관람평 등록 레이어 -->
    		
			<div id="layer_regi_reply_review" class="modal-layer" style="z-index: 503;">
			<form action="movie_info.jsp">
				<div class="wrap" style="width: 500px; height: 600px; margin-left: -250px; margin-top: -340px;">
					<header class="layer-header">
						<h3 class="tit">
							<span class="oneTitle">관람평</span>
							작성하기
						</h3>
					</header>
					<div class="layer-con" style="height: 568px;">
					<div class="regi-reply-score review">
						<div class="score">
							<p class="tit">
							스파이더맨: 노 웨이 홈
							<br/>
							영화 어떠셨나요?
							</p>
						<div class="box">
							<div class="box-star-score">
								<div class="star">
									<div class="group">
										<button type="button" class="btn left score-1" value="1">1</button>
										<button type="button" class="btn right score-2" value="2">2</button>
									</div>
									<div class="group">
										<button type="button" class="btn left score-3" value="3">3</button>
										<button type="button" class="btn right score-4" value="4">4</button>
									</div>
									<div class="group">
										<button type="button" class="btn left score-5" value="5">5</button>
										<button type="button" class="btn right score-6" value="6">6</button>
									</div>
									<div class="group">
										<button type="button" class="btn left score-7" value="7">7</button>
										<button type="button" class="btn right score-8" value="8">8</button>
									</div>
									<div class="group">
										<button type="button" class="btn left score-9" value="9">9</button>
										<button type="button" class="btn right score-10" value="10">10</button>
									</div>
								</div>
								<div class="num">
									<em>0</em>
									<span>점</span>
								</div>
							</div>
							<div class="textarea">
								<textarea id="textarea" style="row:5; color:30;" title="한줄평 입력" placeholder="실관람평을 남겨주세요." class="input-textarea"></textarea>
								</div>
							</div>
						<div class="point">
							<p class="tit">관람포인트는 무엇인가요?</p>
							<p class="txt">(최대 2개 선택가능)</p>
							<div class="box">
								<button type="button" class="btn">연출</button>
								<button type="button" class="btn">스토리</button>
								<button type="button" class="btn">영상미</button>
								<button type="button" class="btn">배우</button>
								<button type="button" class="btn">OST</button>
							</div>
						</div>
					</div>
				</div>
					<div class="btn-group-fixed">
						<button type="button" class="button close-layer">취소</button>
						<button type="submit" class="button purple" id="regOneBtn">등록</button>
					</div>
					<button type="button" class="btn-modal-close">레이어 닫기</button>
				</div>
			</div>
			</form>
		</div>
</div>
	<!-- △main -->

	<!-- footer 입력 -->
	<div style="clear:both;"></div>
	<div id="footer">
		<div class="container1">
			<div id="footerbox1">
				<a href="https://www.megabox.co.kr/megaboxinfo" class="footerlink">회사소개</a>
				<a href="https://www.megabox.co.kr/recruit" class="footerlink">인재채용</a>
				<a href="https://www.megabox.co.kr/socialcontribution" class="footerlink">사회공헌</a>
				<a href="https://www.megabox.co.kr/partner" class="footerlink">제휴/광고/부대사업문의</a>
				<a href="https://www.megabox.co.kr/support/terms" class="footerlink"><b>개인정보처리방침</b></a>
				<a href="https://jebo.joonganggroup.com/main.do" class="footerlink">윤리경영</a>
				<a href="#" id="footerbox"><img src="./image/ico-footer-search.png" style="margin:-4px 0" />극장찾기</a>
			</div>

			<div id="footerbox4">
				<div id="footerbox2">
					<img src="./image/logo-opacity_new2.png" style="margin:0 15px 0 0; float:left;" />
					<p class="footertext" style="margin-top:3px">
						서울특별시 마포구 월드컵로 240, 지상 2층(성산동, 월드컵주경기장) ARS 1544-0070</p>
					<p class="footertext">
						대표자명 김진선 · 개인정보보호책임자 조상연 · 사업자등록번호 211-86-59478 · 통신판매업신고번호 제 833호
					</p>
					<p class="footertext">
						COPYRIGHT © MegaboxJoongAng, Inc. All rights reserved
					</p>
				</div>
			
				<div id="footerbox3">
					<a href="https://apps.apple.com/kr/app/megabox/id894443858?l=ko&ls=1">
						<div class="footerlink1"
							style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-appstore.png)">
						</div>
					</a>
					<a href="https://play.google.com/store/apps/details?id=com.megabox.mop">
						<div class="footerlink1"
							style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-googleplay.png)">
						</div>
					</a>
					<a href="https://www.instagram.com/megaboxon">
						<div class="footerlink1"
							style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-instagram.png)">
						</div>
					</a>
					<a href="https://www.facebook.com/megaboxon">
						<div class="footerlink1"
							style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-facebook.png)">
						</div>
					</a>
					<a href="https://twitter.com/megaboxon">
						<div class="footerlink1"
							style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-twitter.png)">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>