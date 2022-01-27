<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
String likeId = request.getParameter("id");
String loginId = (String)(session.getAttribute("member_id"));
String name = (String)(session.getAttribute("name"));
Date today = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String todate = format.format(today);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<link href='css/my_member_history.css?aa' rel='stylesheet' type='text/css'>
<link href='css/header_footer.css?aa' rel='stylesheet' type='text/css'>
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
		$(".mymegabox").removeClass('on');
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
	
	/*  */
	
	$('.dot-toggle-a').on('click',function(){
		$(this).toggleClass('on');
		$('.a-search').find('.box-button').toggleClass('on');
	});
	
	$('.dot-toggle-b').on('click',function(){
		$(this).toggleClass('on');
		$('.b-search').find('.box-button').toggleClass('on');
	});
	
	$('#ticketing').on("click",function(){
		$(this).addClass('on');
		$('#buy').removeClass('on');
		$('.a-search').addClass('on');
		$('.b-search').removeClass('on');
	});
	
	$('#buy').on("click",function(){
		$(this).addClass('on');
		$('#ticketing').removeClass('on');
		$('.b-search').addClass('on');
		$('.a-search').removeClass('on');
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
				<a href="#" title="맴버십">맴버십</a>
				<a href="centerhome.jsp" title="고객센터">고객센터</a>
			</div>
			<div class="right-link">
				<%if(loginId == null) { %>
				<a href="#" title="로그인" id="loginBox">로그인</a>
				<%} else { %>
				<a href="logout.jsp" title="로그아웃" id="loginBox">로그아웃</a>
				<% } %> 
				<%if (loginId == null) { %>
				<a href="information.jsp" title="회원가입">회원가입</a>
				<%} else { %>
				<!-- <a href="#" title="알림">알림</a> -->
				<% } %>
				<a href="fast_rev_before_map.jsp" title="빠른예매">빠른예매</a>
			</div>
		</div>
		<div class="link-area">
			<a href="#" id="sitemap" class="menu-open-btn" title="사이트맵">사이트맵</a>
			<!-- <a href="#" id="search" class="search-btn" title="검색">검색</a>  미구현   -->
			<a href="#" class="mymegabox" title="나의내가박스">나의내가박스</a>
			<a href="movie-theater-table.jsp" class="link-ticket" title="상영시간표">상영시간표</a>
		</div>
		<nav id="gnb" class="">
			<ul class="gnb-depth1">
				<li class=""> <!-- <<<<< on으로 메뉴조정 -->
					<a href="all_movie.jsp" class="gnb-txt-movie" title="영화"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="all_movie.jsp" title="전체영화">전체영화</a></li>
							<li><a href="#" title="N스크린">N스크린</a></li>
							<li><a href="#" title="큐레이션">큐레이션</a></li>
							<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="fast_rev_before_map.jsp" class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="fast_rev_before_map.jsp" title="빠른예매">빠른예매</a></li>
							<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="AllTheater.jsp" class="gnb-txt-theater" title="극장"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="AllTheater.jsp" title="전체극장">전체극장</a></li>
							<li><a href="N스크린" title="특별관">특별관</a></li>
						</ul>
					</div>
				</li>
				<li class=""> 	<!-- <<<<< on으로 메뉴조정 -->
					<a href="#" class="gnb-txt-event" title="이벤트"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="#" title="진행중 이벤트">진행중 이벤트</a></li>
							<li><a href="#" title="지난 이벤트">지난 이벤트</a></li>
							<li><a href="#" title="당첨자 발표">당첨자 발표</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="#" class="gnb-txt-store" title="스토어"></a>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="#" class="gnb-txt-benefit" title="혜택"></a>
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
		<div id='layer_sitemap' class='layer-sitemap'> <!-- on을 놓으면 켜지고, 빼면 꺼짐 display:none으로 조정함 -->
		<div class='layer_sitemap_wrap'>
			<a href="" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>
			<p class="tit">SITEMAP</p>
			<div class="list position-1">
				<p class="tit-depth">영화</p>
				<ul class="list-depth">
					<li><a href="all_movie.jsp" title="전체영화">전체영화</a></li>
					<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
					<li><a href="javascript:void(0)" onclick="javascript:MegaboxUtil.Common.moveMovieFilmCheck();"
							title="영화제">영화제</a></li>
					<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
				</ul>
			</div>
			<div class="list position-2">
				<p class="tit-depth">예매</p>
				<ul class="list-depth">
					<li><a href="fast_rev_before_map.jsp" title="빠른예매">빠른예매</a></li>
					<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
					<li><a href="javascript:void(0);" title="더 부티크 프라빗 예매">더 부티크 프라이빗 예매</a></li>
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
				<p class="tit-depth">나의 내가박스</p>
				<ul class="list-depth mymage">


					<li><a href="javascript:void(0);"
							title="나의 내가박스 홈">나의 내가박스 홈</a></li>
					<li><a href="javascript:void(0);"
							title="예매/구매내역">예매/구매내역</a></li>
					<li><a href="javascript:void(0);"
							title="영화관람권">영화관람권</a></li>
					<li><a href="javascript:void(0);"
							title="스토어교환권">스토어교환권</a></li>
					<li><a href="javascript:void(0);"
							title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>

					<li><a href="javascript:void(0);"
							title="멤버십포인트">멤버십포인트</a></li>
					<li><a href="javascript:void(0);"
							title="나의 무비스토리">나의 무비스토리</a></li>
					<li><a href="javascript:void(0);"
							title="나의 이벤트 응모내역">나의 이벤트 응모내역</a></li>
					<li><a href="javascript:void(0);"
							title="나의 문의내역">나의 문의내역</a></li>
					<li><a href="javascript:void(0);" title="자주쓰는 할인 카드">자주쓰는 할인 카드</a></li>
					<li><a href="javascript:void(0);"
							title="회원정보">회원정보</a></li>
				</ul>
			</div>

			<div class="list position-7">
				<p class="tit-depth">혜택</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0);" title="멤버십 안내">멤버십 안내</a></li>
					<li><a href="javascript:void(0);" title="VIP LOUNGE">VIP LOUNGE</a></li>
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
					<li><a href="javascript:void(0);" target="_blank" title="사회공헌">사회공헌</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="홍보자료">홍보자료</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="제휴/부대사업문의">제휴/부대사업문의</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="온라인제보센터">온라인제보센터</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="자료">IR자료</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="인재채용림">인재채용</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="윤리경영">윤리경영</a></li>
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
				<%if(loginId == null) { %>
				<!--  로그인 전  -->
				<div class="login-before">
					<p class="txt">
						로그인 하시면 나의 내가박스를 만날 수 있어요.
						<br/>
						영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해 보세요!
					</p>
					<div class="mb50">
						<a href="#" id="movelogin" title="로그인" class="button" style="width:120px;">로그인</a>
					</div>
					<a href="information.jsp" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직 회원이 아니신가요?</a>
				</div>
				<%} else { %>
				<!--  로그인 후    -->
				<div class="login-after" >
					<div class="user-info">
						<p class="txt">안녕하세요!</p>
						<p class="info">
							<em><%=name %></em>
							<span>회원님</span>
						</p>
						<div class="last-date">
							마지막 접속일 : 
							<em><%=todate%></em>
						</div>
						<div class="btn-fixed">
							<a href="mymegabox.jsp" class="button" title="나의 내가박스">나의 내가박스</a>
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
								<em title="쿠폰 수" class="cpon">0</em>
								<span title="관람권수" class="movie">0</span>
							
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="쿠폰">쿠폰</a>
								<a href="javascript:void(0);" class="button" title="관람권">관람권</a>
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
								<em>0</em>
								<span>건</span>
							</p>
						</div>
						<div class="btn-fixed">
							<a href="javascript:void(0);" class="button" title="구매내역">구매내역</a>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</header>
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="#" title="페이지 이동">
					각각 맞는 페이지 위치 넣기
				</a>
				<a href="#" title="페이지 이동">
					페이지 이동
				</a>
			</div>
		</div>
	</div>
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
						<a href="javascript:void(0);" style="text-decoration: none; color:#666666">ID/PW 찾기</a>
						<img src="image/I.png" style="margin: -9px; margin-left: -20px; margin-right: -25px;"/>
						<a href="information.jsp" style="text-decoration: none; color:#666666">회원가입</a>
						<img src="image/I.png" style="margin: -9px; margin-right: -25px; margin-left: -20px;"/>
						<a href="javascript:void(0);" style="text-decoration: none; color:#666666">비회원 예매확인</a>
					</div>
					<div class="sns-login">
						<a href="javascript:void(0);">
						<img src="image/ico-facebook.png">
						</a>
						<a href="javascript:void(0);">
						<img src="image/ico-naver.png">
						</a>
						<a href="javascript:void(0);">
						<img src="image/ico-kakao.png">
						</a>
						<a href="javascript:void(0);">
						<img src="image/ico-payco.png">
						</a>
					</div>
					<div class="col-right">
					</div>
				</div>
				</form>
				<div class="right-login">
					<div class="login-ad">
						<a href="javascript:void(0);">
							<img src="image/fecf1f96c23d2dfc4deaeba5b8c33828.jpg">
						</a>
					</div>
				</div>
			</div>
		</div>
	<!-- △로그인 창 -->
	<!--  header 종료 -->
	<!-- ▽main  -->
	<div class="inner-wrap" style="padding-top:40px;">
    <div class="inb-area">
    	<a class="tit" href="mymegabox.jsp">
    		나의 메가박스
    	</a>
    	<a class="area-a" href="my_member_history.jsp">
    		예매/구매내역
    	</a>
    	<a class="area-a">
    		영화/스토어 관람권	
    	</a>
   	 	<div class="area-box">
   			<a class="area-b">
   				영화관람권
   			</a>
   			<a class="area-b">	
    			스토어교환권
    		</a>
   		</div>
    		<a class="area-a">
    			메가박스/제휴쿠폰
    		</a>
   			<a class="area-a">
    			맴버십 포인트
   			</a>
  	 	<div class="area-box">
   			<a class="area-b">
    			포인트 이용내역
    		</a>
    		<a class="area-b">
   				멤버십 카드관리
   			</a>
   			<a class="area-b">
   				MiL.k포인트
   			</a>
   		</div>
   			<a class="area-a">
   				나의 무비스토리
   			</a>
   			<a class="area-a">
 				나의 이벤트 응모내역
  			</a>
  			<a class="area-a">
    			나의 문의내역
   			</a>
   			<a class="area-a">
    			자주쓰는 카드 관리
    		</a>
    		<a class="area-a">
    			회원정보
   			</a>
   		<div class="area-box">
   			<a class="area-b">
   				개인정보 수정
    		</a>
    		<a class="area-b">
    			선택정보 수정
    		</a>
  	 	</div>
	</div>
	
	<!-- ----------------------------------------------------------------- -->

	<div class="contents">
		<h2 class="movie-tit">예매/구매 내역</h2>
		<div class="tap-block">
			<div class="btn on" id="ticketing">
				<a href="#">예매</a>
			</div>
			<div class="btn" id="buy">
				<a href="#">구매</a>
			</div>
		</div>
	<div class="a-search on">
		<div class="board-list-search-a">
			<div class="board-box">
				<strong style="margin-right: 25px;">구분</strong>
				<input type="radio" id="radBox01">
				<label for="radBox01">예매내역</label>
				<input type="radio" id="radBox02">
				<label for="radBox01">지난내역</label>
				<select class="date-btn">
				<option>2022년 1월</option>
				<option>2022년 2월</option>
				<option>2022년 3월</option>
				<option>2022년 4월</option>
				<option>2022년 5월</option>
				<option>2022년 6월</option>
				<option>2022년 7월</option>
				<option>2022년 8월</option>
				<option>2022년 9월</option>
				<option>2022년 10월</option>
				<option>2022년 11월</option>
				<option>2022년 12월</option>
				</select>
				<button class="list-btn-right">
					<img src="./image/member_img/ico-search-gray.png" style="margin:-3px;"/>
				조회
				</button>
			</div>
		</div>
		<div class="history-box">
				예매내역이 없습니다.
			</div>
		<div class="history-tit">
			<h2>예매취소내역</h2>
		</div>
		<div class="mypage-info">
			<ul class="dot-list">
				<li>상영일 기준 7일간 취소내역을 확인하실 수 있습니다.</li>
			</ul>
		</div>
		<div class="table-warp">
					<div class="table-list" style="width:160px; height:38px;">취소일시</div>
					<div class="table-list" style="width:260px; height:38px;">영화명</div>
					<div class="table-list" style="width:140px; height:38px;">극장</div>
					<div class="table-list" style="width:140px; height:38px;">상영일시</div>
					<div class="table-list" style="width:140px; height:38px;">취소금액</div>			
		</div>
		<div class="table-warp-list ">
			<p style="padding:0;">취소 내역이 없습니다.</p>
		</div>
		<button type="button" class="dot-toggle-a">이용안내
				<!-- <img src="./image/member_img/ico-arr-right-gray.png" style="transform:rotate(270deg); float:right; margin-top: 3px; margin-right: 10px;"/> -->
			</button>
		<div class="box-button">
			<div class="cont-box">
				<strong>[예매안내]</strong>
				<ul class="cont-list">
					<li>만 4세(48개월) 이상부터는 영화티켓을 반드시 구매하셔야 입장 가능합니다.</li>
					<li>예매 변경은 불가능하며, 취소 후 재 예매를 하셔야만 합니다.</li>
					<li>메가박스 모바일앱을 이용할 경우 티켓출력없이 모바일티켓을 통해 바로 입장하실 수 있습니다.</li>
				</ul>
				<strong>[티켓교환 안내]</strong>
				<ul class="cont-list">
					<li>극장의 무인발권기(KIOSK)를 통해 예매번호 또는 고객확인번호(생년월일+휴대폰번호)를 입력하여 편리하게 티켓을 발권하실 수 있습니다.<li>
					<li>무인발권기 이용이 어려우신경우, 티켓교환권을 출력하여 매표소에 방문하시면 티켓을 발권하실 수 있습니다.<li>
					<li>(티켓교환권 출력이 어려운경우 예매번호와 신분증을 지참하여 매표소에 방문하시면 티켓을 발권하실 수 있습니다)<li>
				</ul>
				<strong>[예매취소 안내]</strong>
				<ul class="cont-list">
					<li>온라인(홈페이지/모바일) 예매 취소는 상영시간 20분전까지 입니다.</li>
					<li>위탁 예매 사이트 이용 시 취소 및 환불 규정은 해당 사이트 규정을 따릅니다.</li>
					<li>LIVE 공연 콘텐트는 취소 기준은 아래와 같습니다.</li>
					<li>
						<ul>
							<li>관람 4일전 : 취소 가능</li>
							<li>관람 3일 ~ 1일전 : 취소 수수료 부담 후 취소 가능</li>
							<li>관람 당일 : 취소 및 환불 불가</li>
						</ul>
					<li>공연 관람시 시작 시간 이후에는 입장이 제한 됩니다.</li>
					<li>발권된 티켓은 상영시간 전까지 현장 방문 시에만 취소가 가능합니다.</li>
				</ul>	
			</div>
		</div>
	</div>
	<!--------------------예매 내역 종료	 --------------------------->
	<div class="b-search">
		<div class="board-list-search-b">
			<div class="board-box">
				<strong style="margin-right: 40px;">구분</strong>
				<select class="date-btn">
					<option>전체</option>
					<option>구매내역</option>
					<option>취소내역</option>
				</select>
				
				<input type="radio" id="radBox01" class="radbox" name="t">
				<label for="radBox01">전체</label>
				<input type="radio" id="radBox02" class="radbox" name="t">
				<label for="radBox01">구매내역</label>
				<input type="radio" id="radBox03" class="radbox" name="t">
				<label for="radBox01">취소내역</label>
				
				<!-- ------------------------------------버튼 만들기------------------------- -->
				
			</div>
			<!-- <div class="board-box">
				<strong style="float:left; line-height: 36px;     margin-right: 13px;">조회기간</strong>
				<button class="borad-btn" style="border-radius: 5px 0 0 5px;">1주일</button>
				<button class="borad-btn">1개월</button>
				<button class="borad-btn">3개월</button>
				<button class="borad-btn" style="border-radius: 0 5px 5px 0;">6개월</button>
				<div style="float: left; margin-left: 15px;">
				<input type="text" class="date-calen" placeholder="2021.06.02" id="#1"/>
					<button class="date-calen-btn"></button>
				<span>~</span>
				<input type="text" class="date-calen" placeholder="2021.12.02" id="#2"/>
					<button class="date-calen-btn"></button>
				</div>
				<button class="list-btn-right">
					<img src="./image/member_img/ico-search-gray.png" style="margin:-3px;"/>
				조회
				</button>
			</div> -->
		</div>
		<div style="float: left; margin: 30px 0 15px 0;">
		<p class="result-count">
				<strong>
				전체
				<b class="font-gblue">0</b>
				건
				</strong>
			</p>
		</div>
		<div class="table-warp">
					<div class="table-list" style="width:140px; height:38px;">결제일시</div>
					<div class="table-list" style="width:140px; height:38px;">구분</div>
					<div class="table-list" style="width:280px; height:38px;">상품명</div>
					<div class="table-list" style="width:140px; height:38px;">결제금액</div>	
					<div class="table-list" style="width:140px; height:38px;">상태</div>	
		</div>
		<div class="table-warp-list ">
			<p style="padding:0;">결제 내역이 없습니다.</p>
		</div>
		<div style="padding: 60px 0 0 0; float:left; width:840px;">
			
		</div>
		<button type="button" class="dot-toggle-b">이용안내
				<!-- <img src="./image/member_img/ico-arr-right-gray.png" style="transform:rotate(270deg); float:right; margin-top: 3px; margin-right: 10px;"/> -->
			</button>
		<div class="box-button">
			<div class="cont-box">
				<strong>[스토어 구매/취소 안내]</strong>
				<ul class="cont-list">
					<li>스토어 상품은 구매 후 취소가능기간 내 100% 환불이 가능하며, 부분환불은 불가 합니다.</li>
					<li>(ex. 3개의 쿠폰을 한 번에 구매하신 경우, 3개 모두 취소만 가능하며 그 중 사용하신 쿠폰이 있는 경우 환불이 불가합니다)</li>
					<li>스토어 교환권은 MMS로 최대 1회 재전송 하실 수 있습니다.</li>
				</ul>
				<strong>[모바일오더 구매/취소 안내]</strong>
				<ul class="cont-list">
					<li style="color:red;">ⓘ 모바일오더는 모바일앱을 통해 이용하실 수 있습니다.</li>
					<li>모바일오더는 구매 후 즉시 조리되는 상품으로 취소가 불가 합니다.</li>
					<li>극장 매점에서 주문번호가 호출되면 상품을 수령하실 수 있습니다.</li>
					<li>극장 상황에 따라 상품준비시간이 다소 길어질 수 있습니다.</li>
				</ul>
			</div>
		</div>
		<!-- <div class="box-button">
			<button type="button" class="dot-toggle-b">이용안내
				<img src="./image/member_img/ico-arr-right-gray.png" style="transform:rotate(270deg); float:right; margin-top: 3px; margin-right: 10px;"/>
			</button>
		</div> -->
		</div>
	</div>
</div>
	
	<!-- △main -->
	
	<!-- footer 입력 -->
	<div style="clear:both;"></div>
	<div id="footer">
		<div class="container1">
			<div id="footerbox1">
				<a href="javascript:void(0);" class="footerlink">회사소개</a>
				<a href="javascript:void(0);" class="footerlink">인재채용</a>
				<a href="javascript:void(0);" class="footerlink">사회공헌</a>
				<a href="javascript:void(0);" class="footerlink">제휴/광고/부대사업문의</a>
				<a href="javascript:void(0);" class="footerlink"><b>개인정보처리방침</b></a>
				<a href="javascript:void(0);" class="footerlink">윤리경영</a>
				<a href="AllTheater.jsp" id="footerbox"><img src="./image/ico-footer-search.png" style="margin:-4px 0" />극장찾기</a>
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
					<a href="javascript:void(0);">
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