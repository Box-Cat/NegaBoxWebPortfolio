<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="dto.*"%>
<%@ page import="actions.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.text.SimpleDateFormat" import="java.util.Date"
	import="javax.servlet.ServletException"
	import="javax.servlet.annotation.WebServlet"
	import="javax.servlet.http.HttpServlet"
	import="javax.servlet.http.HttpServletRequest"
	import="javax.servlet.http.HttpServletResponse"
	import="javax.xml.parsers.DocumentBuilder"
	import="javax.xml.parsers.DocumentBuilderFactory"
	import="org.w3c.dom.Document" import="org.w3c.dom.Element"
	import="org.w3c.dom.Node" import="org.w3c.dom.NodeList"%>
<%
String loginId = (String) (session.getAttribute("member_id"));
String name = (String) (session.getAttribute("name"));
Date today = (Date) (session.getAttribute("today"));
String todate = (String) (session.getAttribute("todate"));
ArrayList<MainVO> listMain = (ArrayList<MainVO>) (request.getAttribute("listMain"));
ArrayList<Float> reviewCount = (ArrayList<Float>) (request.getAttribute("reviewCount"));
ArrayList<Integer> heartCount = (ArrayList<Integer>) (request.getAttribute("heartCount"));
HashMap<String, Integer> hmapMovieCodeLike = (HashMap<String, Integer>) (request.getAttribute("hmapMovieCodeLike"));
%>
<%-- <%
//api 날짜 구하기   //api dao로 보낼까??
Calendar cal = Calendar.getInstance();
cal.setTime(new Date());
SimpleDateFormat df = new SimpleDateFormat("YYYYMMdd");
cal.add(Calendar.DATE, -7);
String weeklyday = df.format(cal.getTime());
System.out.println(weeklyday);

%> --%>
<%-- <% 
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
			System.out.println("######################");
			
			System.out.println("e1.getTextContent() :" + e1.getTextContent());
			System.out.println("e2.getTextContent() :" +e2.getTextContent());
			System.out.println("e3.getTextContent() :" +e3.getTextContent());
			apiList.add(new ApiVO(e3.getTextContent(),e2.getTextContent(),e1.getTextContent()));
				// for end
		}	// if end
		
		
		} catch (Exception e){	
		e.printStackTrace();
	}	// try~catch end
	
%>
<%  
	//DBConnection
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "megabox";
	String userPw = "user1234";
	Connection conn = null;
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, userPw);
	} catch(Exception e) {   
		e.printStackTrace();
	}
	//DBConnection		
	
	ArrayList<MainVO> listMain = new ArrayList<MainVO>();
	//dao1. MovieDao의 ShowApiMovieList()
	String sql ="select movie_photo, dolby, mx, movie_code, plot, movie_name from movie where movie_name = ?";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	pstmt = conn.prepareStatement(sql);
	
	for(ApiVO vo : apiList) {
		pstmt.setString(1, vo.getMovieNm()); //ApiVO의 getMovieNm는 영화 이름
		rs = pstmt.executeQuery();
		rs.next();
		String moviePhoto = rs.getString("movie_photo");
		int dolby = rs.getInt("dolby");
		int mx = rs.getInt("mx");
		String plot = rs.getString("plot");
		String movieCode = rs.getString("movie_code");
		String movieName = rs.getString("movie_name");
		listMain.add(new MainVO(movieCode, moviePhoto, plot, dolby, mx, movieName));
	}
	System.out.println("=======박스오피스와 비교한 영화 일치값 =========");
	for(MainVO vo : listMain) {
		System.out.println("vo.getMovieCode() :" + vo.getMovieCode());
	}
	
	//dao2. ReviewDao의  avgScore()
	sql = "SELECT round(sum(score)/count(*) ,1) AS score FROM review WHERE movie_code = ?";
	
	pstmt = conn.prepareStatement(sql);
	ArrayList<Float> reviewCount = new ArrayList<Float>();
	for(MainVO vo : listMain) {
		pstmt.setString(1, vo.getMovieCode());
		rs = pstmt.executeQuery();
		if(rs.next())
		
		reviewCount.add(rs.getFloat("score"));
		System.out.println(vo.getMovieCode() + " 관람평 점수  : " + rs.getFloat("score"));
	}
	
	
	//dao3. WantToWatchDao의  countLike() - 영화당 좋아요 개수 세기
	sql = "select count(*) from want_to_watch where movie_code = ?";
	
	pstmt = conn.prepareStatement(sql);
	
	ArrayList<Integer> heartCount = new ArrayList<Integer>();
	for(MainVO vo : listMain) {
		pstmt.setString(1, vo.getMovieCode());
		rs = pstmt.executeQuery();
		rs.next();
		heartCount.add(rs.getInt("count(*)")); // 좋아요 카운트 영화 순서별.
	}
	
	//dao4. WantToWatchDao의  countLikeMember() - 해당 회원의 좋아요 개수 세기
	sql	= "select count(*) from want_to_watch where member_id = ? and movie_code = ?";
	HashMap<String, Integer> hmapMovieCodeLike = new HashMap<String, Integer>();
	
	for(MainVO vo : listMain) {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,loginId);
		pstmt.setString(2,vo.getMovieCode());
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			hmapMovieCodeLike.put(vo.getMovieCode(), rs.getInt(1));
		}
		rs.close();
		pstmt.close();
	}
	
	conn.close(); 
%>
--%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css"
	rel="stylesheet">
<link href='css/MainPage(Remake).css?ss' rel='stylesheet'
	type='text/css'>
<link href='css/main_header_footer.css?ss' rel='stylesheet'
	type='text/css'>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEET PLAY SHARE, 내가박스</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	function sendPost(url, params){ 
		var form = document.createElement('form');
		form.setAttribute('method','post');
		form.setAttribute('action',url);
		document.charset = "utf-8";
		for(var key in params){
			var hiddenField = document.createElement('input');
			hiddenField.setAttribute('type','hidden');
			hiddenField.setAttribute('name', key);
			hiddenField.setAttribute('value',params[key]);
			form.appendChild(hiddenField);
	
		}
		document.body.appendChild(form);
		form.submit();
	}

	$(function() {
		$('#exitButton').on("click", function() {
			$(this).parents(".background").toggleClass('on');
		});

		$('#loginBox').on("click", function() {
			$(".background").addClass('on');
		});
		$('#logout').on("click", function() {
			$(".background").removeClass('on');
		})

		$('#movelogin').on("click", function() {
			$(".layer-mynega").removeClass("on");
			$(".background").addClass('on');
			$(".mymegabox").removeClass('on');
		});

		$('.mymegabox').click(function() {
			$(this).toggleClass("on");
			$(".layer-mynega").toggleClass("on");
		});

		$('#sitemap').click(function() {
			$(this).toggleClass("on");
			$('.layer-sitemap').toggleClass("on");
		});

		$('.gnb-txt-movie, .gnb-depth2').mouseenter(function() {
			$('#gnb').addClass("on");
			$(this).parent('li').addClass("on");
		});

		$('.gnb-txt-movie, .gnb-depth2').mouseleave(function() {
			$('#gnb').removeClass("on");
			$(this).parent('li').removeClass("on");
		});

		$('.gnb-txt-reserve, .gnb-depth2').mouseenter(function() {
			$('#gnb').addClass("on");
			$(this).parent('li').addClass("on");
		});

		$('.gnb-txt-reserve, .gnb-depth2').mouseleave(function() {
			$('#gnb').removeClass("on");
			$(this).parent('li').removeClass("on");
		});

		$('.gnb-txt-theater, .gnb-depth2').mouseenter(function() {
			$('#gnb').addClass("on");
			$(this).parent('li').addClass("on");
		});

		$('.gnb-txt-theater, .gnb-depth2').mouseleave(function() {
			$('#gnb').removeClass("on");
			$(this).parent('li').removeClass("on");
		});

		$('.gnb-txt-event, .gnb-depth2').mouseenter(function() {
			$('#gnb').addClass("on");
			$(this).parent('li').addClass("on");
		});

		$('.gnb-txt-event, .gnb-depth2').mouseleave(function() {
			$('#gnb').removeClass("on");
			$(this).parent('li').removeClass("on");
		});

		$('.gnb-txt-benefit, .gnb-depth2').mouseover(function() {
			$('#gnb').addClass("on");
			$(this).parent('li').addClass("on");
		});

		$('.gnb-txt-benefit, .gnb-depth2').mouseout(function() {
			$('#gnb').removeClass("on");
			$(this).parent('li').removeClass("on");
		});
		
		/* var num = Number($("button[name=movieCode]").val()); */
		$("button[name=movieCode]").click(
				function() {
					var num = $(this).val();
					var heart = Number($(this).text());
<%if (loginId == null) {%>
	alert("로그인후 이용가능합니다.");
<%} else {%>
	_this = $(this);
	$.ajax({
		type : "post",
		url : "Controller?command=heartCalc",
		data : {
			'movieCode' : num,
			'heart' : heart
		},
		datatype : "json",
		success : function(data) {
			if (data.like) {
				_this.children('span').text(
						data.likeHeart);
				_this.children(".img-container")
						.addClass("on"); /* 조건식 걸어야함 */
			} else {
				_this.children(".img-container")
						.removeClass("on"); /* 조건식 걸어야함 */
				_this.children('span').text(
						data.likeHeart);
     			}
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n"
					+ "message:" + request.responseText
					+ "\n" + "error:" + error);
			alert("code:" + request.status + "\n");
			alert("message:" + request.responseText
					+ "\n");
			alert("error:" + error);
			console.log(request.responseText);
		}
	});
<%}%>
	});

		$(".poster, .rank, .screen_type ").mouseenter(function() {
			$(this).siblings('.wrap').addClass("on");
		});

		$(".wrap").mouseleave(function() {
			$(this).removeClass("on");
		});
		
		$(".poster, .wrap").click(function() {					
			var movieName = '';
		 	var mName ='';
			movieName = $(this).siblings("img").attr("movieName"); 
			mName = "#" + movieName.replace(/ /gi,"");
			sendPost("Controller?command=movieInfo&mName="+mName, {
				"movieName" : movieName,
				"mName" : mName
			});
		});

	});
</script>
</head>
<body>
	<!-- header -->
	<header id="header" class="main-header no-bg">
		<div class="ci">
			<a href="index.jsp" title="내가박스 메인으로 가기"></a>
		</div>
		<div class="util-area">
			<div class="left-link">
				<a href="#" title="VIP LOUNGE">VIP LOUNGE</a> <a href="#"
					title="맴버십">맴버십</a> <a href="centerhome.jsp" title="고객센터">고객센터</a>
			</div>
			<div class="right-link">
				<%
					if (loginId == null) {
				%>
				<a href="#" title="로그인" id="loginBox">로그인</a>
				<%
					} else {
				%>
				<a href="logout.jsp" title="로그아웃" id="logoutBox">로그아웃</a>
				<%
					}
				%>
				<%
					if (loginId == null) {
				%>
				<a href="email.jsp" title="회원가입">회원가입</a>
				<%
					} else {
				%>
				<!-- <a href="#" title="알림">알림</a> -->
				<%
					}
				%>
				<a href="Controller?command=fastRev" title="빠른예매">빠른예매</a> 
			</div>
		</div>
		<div class="link-area">
			<a href="#" id="sitemap" class="menu-open-btn" title="사이트맵">사이트맵</a>
			<!-- <a href="#" id="search" class="search-btn" title="검색">검색</a>  미구현   -->
			<a href="#" class="mymegabox" title="나의내가박스">나의내가박스</a> <a
				href="movie-theater-table.jsp" class="link-ticket" title="상영시간표">상영시간표</a>
		</div>
		<nav id="gnb" class="">
			<ul class="gnb-depth1">
				<li class="">
					<!-- <<<<< on으로 메뉴조정 --> <a href="all_movie.jsp"
					class="gnb-txt-movie" title="영화"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
							<li><a href="#" title="N스크린">N스크린</a></li>
							<li><a href="#" title="큐레이션">큐레이션</a></li>
							<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>
				</li>
				<li class="">
					<!-- <<<<< on으로 메뉴조정 --> <a href="Controller?command=fastRev"
					class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
							<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
						</ul>
					</div>
				</li>
				<li class="">
					<!-- <<<<< on으로 메뉴조정 --> <a href="AllTheater.jsp"
					class="gnb-txt-theater" title="극장"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="AllTheater.jsp" title="전체극장">전체극장</a></li>
							<li><a href="N스크린" title="특별관">특별관</a></li>
						</ul>
					</div>
				</li>
				<li class="">
					<!-- <<<<< on으로 메뉴조정 --> <a href="#" class="gnb-txt-event"
					title="이벤트"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="#" title="진행중 이벤트">진행중 이벤트</a></li>
							<li><a href="#" title="지난 이벤트">지난 이벤트</a></li>
							<li><a href="#" title="당첨자 발표">당첨자 발표</a></li>
						</ul>
					</div>
				</li>
				<li><a href="#" class="gnb-txt-store" title="스토어"></a></li>
				<li class="">
					<!-- <<<<< on으로 메뉴조정 --> <a href="#" class="gnb-txt-benefit"
					title="혜택"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="#" title="내가박스 맴버십">내가박스 맴버십</a></li>
							<li><a href="#" title="제휴/할인">제휴/할인</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		<!--  on off 사이트맵  -->
		<div id='layer_sitemap' class='layer-sitemap'>
			<!-- on을 놓으면 켜지고, 빼면 꺼짐 display:none으로 조정함 -->
			<div class='layer_sitemap_wrap'>
				<a href="" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>
				<p class="tit">SITEMAP</p>
				<div class="list position-1">
					<p class="tit-depth">영화</p>
					<ul class="list-depth">
						<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
						<li><a href="#" title="큐레이션">큐레이션</a></li>
						<li><a href="javascript:void(0)" title="영화제">영화제</a></li>
						<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
					</ul>
				</div>
				<div class="list position-2">
					<p class="tit-depth">예매</p>
					<ul class="list-depth">
						<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
						<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
						<li><a href="javascript:void(0);" title="더 부티크 프라빗 예매">더
								부티크 프라이빗 예매</a></li>
					</ul>
				</div>

				<div class="list position-3">
					<p class="tit-depth">극장</p>

					<ul class="list-depth">
						<li><a href="AllTheater.jsp" title="전체극장">전체극장</a></li>
						<li><a href="javascript:void(0);" title="특별관">특별관</a></li>
					</ul>
				</div>

				<div class="list position-4">
					<p class="tit-depth">이벤트</p>
					<ul class="list-depth">
						<li><a href="javascript:void(0)" title="진행중 이벤트">진행중 이벤트</a></li>
						<li><a href="javascript:void(0)" title="지난 이벤트">지난 이벤트</a></li>
						<li><a href="javascript:void(0)" title="당첨자발표">당첨자발표</a></li>
					</ul>
				</div>

				<div class="list position-5">
					<p class="tit-depth">스토어</p>
					<ul class="list-depth">
						<li><a href="javascript:void(0)" title="새로운 상품">새로운 상품</a></li>
						<li><a href="javascript:void(0)" title="메가티켓">메가티켓</a></li>
						<li><a href="javascript:void(0)" title="메가찬스">메가찬스</a></li>
						<li><a href="javascript:void(0)" title="팝콘/음료/굿즈">팝콘/음료/굿즈</a></li>
						<li><a href="javascript:void(0)" title="기프트카드">기프트카드</a></li>
					</ul>
				</div>

				<div class="list position-6">
					<p class="tit-depth">나의 내가박스</p>
					<ul class="list-depth mymage">
						<li><a href="javascript:void(0);" title="나의 내가박스 홈">나의
								내가박스 홈</a></li>
						<li><a href="javascript:void(0);" title="예매/구매내역">예매/구매내역</a></li>
						<li><a href="javascript:void(0);" title="영화관람권">영화관람권</a></li>
						<li><a href="javascript:void(0);" title="스토어교환권">스토어교환권</a></li>
						<li><a href="javascript:void(0);" title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>
						<li><a href="javascript:void(0);" title="멤버십포인트">멤버십포인트</a></li>
						<li><a href="javascript:void(0);" title="나의 무비스토리">나의
								무비스토리</a></li>
						<li><a href="javascript:void(0);" title="나의 이벤트 응모내역">나의
								이벤트 응모내역</a></li>
						<li><a href="javascript:void(0);" title="나의 문의내역">나의 문의내역</a></li>
						<li><a href="javascript:void(0);" title="자주쓰는 할인 카드">자주쓰는
								할인 카드</a></li>
						<li><a href="javascript:void(0);" title="회원정보">회원정보</a></li>
					</ul>
				</div>

				<div class="list position-7">
					<p class="tit-depth">혜택</p>
					<ul class="list-depth">
						<li><a href="javascript:void(0);" title="멤버십 안내">멤버십 안내</a></li>
						<li><a href="javascript:void(0);" title="VIP LOUNGE">VIP
								LOUNGE</a></li>
						<li><a href="javascript:void(0);" title="제휴/할인">제휴/할인</a></li>
					</ul>
				</div>

				<div class="list position-8">
					<p class="tit-depth">고객센터</p>
					<ul class="list-depth">
						<li><a href="centerhome.jsp" title="고객센터 홈">고객센터 홈</a></li>
						<li><a href="javascript:void(0);" title="자주묻는질문">자주묻는질문</a></li>
						<li><a href="javascript:void(0);" title="공지사항">공지사항</a></li>
						<li><a href="inquiry.jsp" title="1:1문의">1:1문의</a></li>
						<li><a href="javascript:void(0);" title="단체/대관문의">단체/대관문의</a></li>
						<li><a href="javascript:void(0);" title="분실물문의">분실물문의</a></li>
					</ul>
				</div>

				<div class="list position-9">
					<p class="tit-depth">회사소개</p>
					<ul class="list-depth">
						<li><a href="mymegabox.jsp" target="_blank" title="내가박스소개">내가박스소개</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="사회공헌">사회공헌</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="홍보자료">홍보자료</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="제휴/부대사업문의">제휴/부대사업문의</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="온라인제보센터">온라인제보센터</a></li>
						<li><a href="javascript:void(0);" target="_blank" title="자료">IR자료</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="인재채용림">인재채용</a></li>
						<li><a href="javascript:void(0);" target="_blank"
							title="윤리경영">윤리경영</a></li>
					</ul>
				</div>


				<div class="list position-10">
					<p class="tit-depth">이용정책</p>
					<ul class="list-depth">
						<li><a href="javascript:void(0);" title="이용약관">이용약관</a></li>
						<li><a href="javascript:void(0);" title="개인정보처리방침">개인정보처리방침</a></li>
						<li><a href="javascript:void(0);" title="스크린수배정에관한기준">스크린수배정에관한기준</a></li>
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
				<%
					if (loginId == null) {
				%>
				<!--  로그인 전  -->
				<div class="login-before">
					<p class="txt">
						로그인 하시면 나의 내가박스를 만날 수 있어요. <br /> 영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해
						보세요!
					</p>
					<div class="mb50">
						<a href="#" id="movelogin" title="로그인" class="button"
							style="width: 120px;">로그인</a>
					</div>
					<a href="information.jsp" class="link" title="혹시 아직 회원이 아니신가요?">혹시
						아직 회원이 아니신가요?</a>
				</div>
				<%
					} else {
				%>
				<!--  로그인 후    -->
				<div class="login-after">
					<div class="user-info">
						<p class="txt">안녕하세요!</p>
						<p class="info">
							<em><%=name%></em> <span>회원님</span>
						</p>
						<div class="last-date">
							 접속날짜 : <em><%=todate%></em>
						</div>
						<div class="btn-fixed">
							<a href="mymegabox.jsp" class="button" title="나의 내가박스">나의
								내가박스</a>
						</div>
					</div>
					<div class="box">
						<div class="point">
							<p class="tit">Point</p>
							<p class="count">0</p>
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="맴버십 포인트">맴버십포인트</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="coupon">
							<p class="tit">쿠폰/관람권</p>
							<p class="count">
								<em title="쿠폰 수" class="cpon">0</em> <span title="관람권수"
									class="movie">0</span>
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="쿠폰">쿠폰</a> <a
									href="javascript:void(0);" class="button" title="관람권">관람권</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="reserve">
							<p class="tit">예매</p>
							<p class="txt">예매내역이 없어요!</p>
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="예매내역">예매내역</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="buy">
							<p class="tit">구매</p>
							<p class="count">
								<em>0</em> <span>건</span>
							</p>
						</div>
						<div class="btn-fixed">
							<a href="javascript:void(0);" class="button" title="구매내역">구매내역</a>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</header>

	<!-- ▽로그인 창 -->
	<!-- on으로 조정함 -->
	<div class="background ">
		<!-- 	<div style="height:100px;"></div>
		 -->
		<div class="wrap1">
			<div class="wrap-login">
				<h3 class="tit fl">로그인</h3>
				<a id="exitButton" href="#" class="fr"><img
					src="image/btn-layer-close.png" /></a>
				<div style="clear: both"></div>
			</div>
			<form method="post" action="Controller?command=loginCheck">
				<div class="layer-login">
					<div class="login-input-area">
						<input type="text" placeholder="아이디" id="id" name="id" /> <br /> <input
							type="password" placeholder="비밀번호" id="pw" name="pw" /> <br />
					</div>
					<div class="chk">
						<div>
							<input id="chkbox" type="checkbox"
								style="font-size: 14px; color: #444444;"> 아이디 저장
							<div class="ad">
								<a href="#"></a> <span>휴대폰 간편로그인 </span> <span
									style="border: 1px solid #3d7db7; font-size: 14px; border: 1px solid #3d7db7; font-size: 14px; padding-left: 7px; padding-right: 7px;">광고</span>
							</div>
						</div>

					</div>
					<input type='submit' value='로그인' class="but">
					<div class="link">
						<a href="javascript:void(0);"
							style="text-decoration: none; color: #666666;">ID/PW 찾기</a> <img
							src="image/I.png"
							style="margin: -9px; margin-left: -20px; margin-right: -25px;" />
						<a href="information.jsp"
							style="text-decoration: none; color: #666666;">회원가입</a> <img
							src="image/I.png"
							style="margin: -9px; margin-right: -25px; margin-left: -20px;" />
						<a href="javascript:void(0);"
							style="text-decoration: none; color: #666666;">비회원 예매확인</a>
					</div>
					<div class="sns-login">
						<a href="javascript:void(0);"> <img
							src="image/ico-facebook.png">
						</a> <a href="javascript:void(0);"> <img src="image/ico-naver.png">
						</a> <a href="javascript:void(0);"> <img src="image/ico-kakao.png">
						</a> <a href="javascript:void(0);"> <img src="image/ico-payco.png">
						</a>
					</div>
					<div class="col-right"></div>
				</div>
			</form>
			<div class="right-login">
				<div class="login-ad">
					<a href="javascript:void(0);"> <img
						src="image/fecf1f96c23d2dfc4deaeba5b8c33828.jpg">
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- △로그인 창 -->
	<!--  header 종료 -->
	<!-- ▽main  -->
	<div class='container main-container'>
		<div id='contents'>
			<div class='main-page'>
				<div id='main-section01' class='section main-movie on'>
					<div class="bg">
						<div class="bg-pattern"></div>
						<%
							for (MainVO vo : listMain) {
							for (int i = 0; i <= 1; i++) {
						%>
						<img src="./movie_photo/<%=vo.getMoviePhoto()%>"
							alt="유체이탈자_티저 포스터.jpg" onerror="noImg(this, 'main');">
						<%
							}
						break;
						}
						%>
					</div>
					<div class='cont-area'>
						<div class='tab-sorting'>
							<button type='button' class='on' sort='boxoRankList'
								name='btnSort'>박스오피스</button>

						</div>
						<a href='all_movie.jsp' class='more-movie' title="더 많은 영화보기">
							더 많은 영화보기 <i class='iconset ico-more-corss gray'></i>
						</a>



						<!-- 	$(".poster, .rank, .screen_type").mouseenter(function(){
			$(this).nextAll('.wrap').addClass("on");
		});
		
		$(".wrap").mouseleave(function(){
			$(this).removeClass("on");
		}); -->


						<div id='main-movie-list'>
							<%
								int count = 1;
							int cot = 0;
							for (MainVO vo : listMain) { // 4번 반복
							%>
							<%
								if (count == 4) {
							%>
							<div class="fl mr0">
								<a href="#">
									<img class='poster' movieName="<%=vo.getMovieName()%>" src="./movie_photo/<%=vo.getMoviePhoto()%>" />
									<p class='rank'><%=count%></p>
									<div class="screen_type">
										<%
											if (vo.getDolby() == 1) {
										%>
										<p>
											<img src='./image/mov_top_tag_db.png' />
										</p>
										<%
											} else {
										}
										%>
										<%
											if (vo.getMx() == 1) {
										%>
										<p>
											<img src='./image/mov_top_tag_mx.png' />
										</p>
										<%
											} else {
										}
										%>
									</div>
									<div class='wrap'>
										<div class="summary">
											<%=vo.getPlot()%>

										</div>
										<div class="score">
											<div class="preview">
												<p class="tit">관람평</p>
												<p class="number"><%=reviewCount.get(cot)%><span
														class="ir">점</span>
												</p>
												<div style='clear: both'></div>
											</div>
										</div>
									</div>
								</a>
								<!-- 좋아요 -->

								<%
									String like_on_2 = hmapMovieCodeLike.get(vo.getMovieCode()) == 1 ? "on" : "";
								%>

								<div class='btn-util'>
									<!-- 하늘색 : <img src='./image/ico-heart-toggle-main.png'> -->

									<button class='button btn-like ico-heart-toggle-gray'
										name="movieCode" id="movieCode" value="<%=vo.getMovieCode()%>">
										<div class="img-container <%=like_on_2%>">
											<!-- <img src='./image/ico-heart-toggle-main.png'> -->
										</div>
										<span><%=heartCount.get(cot)%></span>
										<div style="clear: both;"></div>
									</button>
									<div class='case'>
										<a href='Controller?command=fastRev' class="button gblue"
											title='영화 예매하기'>예매</a>
									</div>
								</div>
								<div style='clear: both'></div>
							</div>
							<%
								break;
							} else {
							%>
							<div class="fl mr40">
								<a href="#">
									<img class='poster' movieName="<%=vo.getMovieName()%>" src="./movie_photo/<%=vo.getMoviePhoto()%>">
									<p class='rank'><%=count%></p>
									<div class="screen_type">
										<%
											if (vo.getDolby() == 1) {
										%>
										<p>
											<img src='./image/mov_top_tag_db.png' />
										</p>
										<%
											} else {
										}
										%>
										<%
											if (vo.getMx() == 1) {
										%>
										<p>
											<img src='./image/mov_top_tag_mx.png' />
										</p>
										<%
											} else {
										}
										%>
									</div>
									<div class='wrap'>
										<div class="summary">
											<%=vo.getPlot()%>
										</div>
										<div class="score">
											<div class="preview">
												<p class="tit">관람평</p>
												<p class="number"><%=reviewCount.get(cot)%><span
														class="ir">점</span>
												</p>
												<div style='clear: both'></div>
											</div>
										</div>
									</div>

								</a>

								<%
									String like_on_1 = hmapMovieCodeLike.get(vo.getMovieCode()) == 1 ? "on" : "";
								%>

								<div class='btn-util'>
									<!-- 하늘색 : <img src='./image/ico-heart-toggle-main.png'> -->
									<button class='button btn-like ico-heart-toggle-gray'
										name="movieCode" id="movieCode" value="<%=vo.getMovieCode()%>">
										<div class="img-container <%=like_on_1%>">
											<!-- <img src='./image/ico-heart-toggle-main.png'> -->
										</div>
										<span><%=heartCount.get(cot)%></span>
										<div style="clear: both;"></div>
									</button>
									<div class='case'>
										<a href='Controller?command=fastRev' class="button gblue"
											title='영화 예매하기'>예매</a>
									</div>
								</div>
								<div style='clear: both'></div>
							</div>
							<%
								count++;
							cot++;
							}
							}
							%>
						</div>
						<div style="clear: both;"></div>
						<div class="search-link">
							<div class='cell'>
								<div class="search">
									<input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색"
										class="input-text" id="movieName">
									<button type="button" class="btn" id="btnSearch">
										<i class="iconset ico-search-w"></i> 검색
									</button>
								</div>
							</div>
							<div class="cell">
								<a href="movie-theater-table.jsp" title="상영시간표 보기"><i
									class="iconset ico-schedule-main"></i> 상영시간표</a>
							</div>
							<div class="cell">
								<a href="javascript:void(0);" title="박스오피스 보기"><i
									class="iconset ico-boxoffice-main"></i> 박스오피스</a>
							</div>
							<div class="cell">
								<a href="Controller?command=fastRev" title="빠른예매 보기"><i
									class="iconset ico-quick-reserve-main"></i> 빠른예매</a>
							</div>
						</div>
					</div>
					<div class="moving-mouse">
						<img class="iconset" alt="" src="./image/ico-mouse.png">
					</div>
				</div>
			</div>
		</div>
	</div>





	<!-- △main -->

	<!-- footer 입력 -->
	<div style="clear: both;"></div>
	<div id="footer">
		<div class="container1">
			<div id="footerbox1">
				<a href="javascript:void(0);" class="footerlink">회사소개</a> <a
					href="javascript:void(0);" class="footerlink">인재채용</a> <a
					href="javascript:void(0);" class="footerlink">사회공헌</a> <a
					href="javascript:void(0);" class="footerlink">제휴/광고/부대사업문의</a> <a
					href="javascript:void(0);" class="footerlink"><b>개인정보처리방침</b></a> <a
					href="javascript:void(0);" class="footerlink">윤리경영</a> <a
					href="AllTheater.jsp" id="footerbox"><img
					src="./image/ico-footer-search.png" style="margin: -4px 0" />극장찾기</a>
			</div>


			<div id="footerbox4">
				<div id="footerbox2">
					<img src="./image/logo-opacity_new2.png"
						style="margin: 0 15px 0 0; float: left;" />
					<p class="footertext" style="margin-top: 3px">서울특별시 마포구 월드컵로
						240, 지상 2층(성산동, 월드컵주경기장) ARS 1544-0070</p>
					<p class="footertext">대표자명 김진선 · 개인정보보호책임자 조상연 · 사업자등록번호
						211-86-59478 · 통신판매업신고번호 제 833호</p>
					<p class="footertext">COPYRIGHT © MegaboxJoongAng, Inc. All
						rights reserved</p>
				</div>

				<div id="footerbox3">
					<a href="javascript:void(0);">
						<div class="footerlink1"
							style="background-image: url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-appstore.png)">
						</div>
					</a> <a
						href="https://play.google.com/store/apps/details?id=com.megabox.mop">
						<div class="footerlink1"
							style="background-image: url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-googleplay.png)">
						</div>
					</a> <a href="https://www.instagram.com/megaboxon">
						<div class="footerlink1"
							style="background-image: url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-instagram.png)">
						</div>
					</a> <a href="https://www.facebook.com/megaboxon">
						<div class="footerlink1"
							style="background-image: url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-facebook.png)">
						</div>
					</a> <a href="https://twitter.com/megaboxon">
						<div class="footerlink1"
							style="background-image: url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-twitter.png)">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>