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
<link href='css/header_footer.css?aaa' rel='stylesheet' type='text/css'>
<link href='css/mymegabox.css?aaa' rel='stylesheet' type='text/css'>
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
	
	/*  해더 끝 */
	
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
	
	$('.dot-toggle-a').on('click',function(){
		$(this).toggleClass('on');
		$('.a-search').find('.box-button').toggleClass('on');
	});
	
	$('.dot-toggle-b').on('click',function(){
		$(this).toggleClass('on');
		$('.b-search').find('.box-button').toggleClass('on');
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
				<a href="mymegabox.jsp" title="페이지 이동">
					나의 메가박스
				</a>
				<!-- <a href="#" title="페이지 이동">
					페이지 이동
				</a> -->
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
	<div class="inner-wrap" style="margin-top: 40px;">
    	<div class="inb-area">
    		<a class="tit" href="mymegebox.jsp">
    			나의 메가박스
    		</a>
    		<a class="area-a" href="my_member_history.jsp">
    			예매/구매내역
    		</a>
    		<a class="area-a" href="#">
    			영화/스토어 관람권	
    		</a>
   	 	<div class="area-box">
   			<a class="area-b" href="#">
   				영화관람권
   			</a>
   			<a class="area-b" href="#">	
    			스토어교환권
    		</a>
    	</div>
    		<a class="area-a" href="#">
    			메가박스/제휴쿠폰
    		</a>
   			<a class="area-a" href="#">
    			맴버십 포인트
   			</a>
   		<div class="area-box">
   			<a class="area-b" href="#">
    			포인트 이용내역
    		</a>
    		<a class="area-b" href="#">
   				멤버십 카드관리
   			</a>
   			<a class="area-b" href="#">
   				MiL.k포인트
   			</a>
   		</div>
   			<a class="area-a" href="my_movie_story.jsp">
   				나의 무비스토리
   			</a>
   			<a class="area-a" href="#">
   				나의 이벤트 응모내역
   			</a>
   			<a class="area-a" href="#">
    			나의 문의내역
   			</a>
   			<a class="area-a" href="#">
    			자주쓰는 카드 관리
    		</a>
    		<a class="area-a" href="#">
    			회원정보
   			</a>
   		<div class="area-box">
   			<a class="area-b" href="#">
   				개인정보 수정
    		</a>
    		<!-- <a class="area-b" href="#">
    			선택정보 수정
    		</a> -->
    	</div>
	</div>
	<div class="my-megabox-main">
		<div class="my-info">
    		<div class="top">
    			<div class="photo">
    				<i class="member-add-photo"></i>
    				<button class="member-button" type="button">
    				<img src="./image/bg-photo.png">
    				</button>
    			</div>
    			<div class="grade">					<!--  -->
    				<p class="name">
    					<%=name%>님은
    					<br/>
    					일반등급입니다.
    				</p>
    				<div class="member-link">
    					<a href="#" style="color:#666666;">개인정보수정</a>
    					<img src="./image/ico-arr-right-reverse-gray.png"/>
    					<a href="#" style="color:#666666;">지난등급조회</a>
    					<img src="./image/ico-arr-right-reverse-gray.png"/>
    				</div>
    			</div>
    			<div class="my-membership">			<!--  -->
    				<p style="font-size: 15px;">SPECIAL MEMBERSHIP</p>
    				<p style="font-size: 13px; padding: 0 35px;">가입된 스페셜멤버십이 없습니다.</p>
    				<a href="#" style="font-size: 15px;">스페셜멤버십</a>
    				<img src="./image/ico-arr-right-reverse-gray.png"/>
    			</div>
			</div>
			<div class="bottom">
				<div style="width:335px; height:116px; float:left;">
					<div>
						<p class="titp" style="float:left; padding-right: 190px;">총 보유 포인트</p>
						<img src="./image/ico-arr-right-gray.png"/>
					</div>
					<div>
						<p class="font-p">0 P</p>
					</div>
					<div class="point-i">
						<p style="float:left;">적립예정 </p><p style="margin-left:4px; float:left;">0 P</p>
						<p style="float:left; margin-left: 20px;">소멸예정</p><p style="margin-left:4px; color:#e81003; float:left;">0 P</p>
					</div>
				</div>
				<div style="width: 235px; height: 116px; float: left; border: 1px solid #d8d9db; padding: 0 30px; border-top:none; border-bottom:none;">
					<div>
						<p class="titp" style="float:left;">선호극장</p>
						<a href="#" style="float: left; margin-left: 60px;">변경</a>
						<img src="./image/ico-arr-right-reverse-gray.png"/>
					</div>
					<div style="padding-top: 9px;">
						<span style="display: inline-block; border-bottom: 1px solid #444;">선호극장</span>을 설정하세요.
					</div>
				</div>
				<div style="width:206px; height:114px; float:left;">
					<div>
						<div style="width: 175px; height: 114px; float: left; padding: 0 0 0 30px;">
							<p class="titp" style="float:left;">관람권/쿠폰</p>
							<img src="./image/ico-arr-right-gray.png" style="float:right;"/>
							<div>
							<span style="float:left; padding: 9px 0 0 0;">영화관람권</span><span style="float:right; padding: 9px 0 0 0;">0매</span>
							</div>
							<div>
							<span style="float:left; padding: 9px 0 0 0;">스토어교환권</span><span style="float:right; padding: 9px 0 0 0;">0매</span>
							</div>
							<div>
							<span style="float:left; padding: 9px 0 0 0;">할인/제휴쿠폰</span><span style="float:right; padding: 9px 0 0 0;">0매</span>
							</div>
						</div>
						<div>
						</div>
					</div>
				</div> 
			</div>
		</div>
				<!-- left -->
		<div class="column">
			<div class="column-left">
					<h2 style="float:left;">나의 무비스토리</h2>
					<div class="column-left-buttom">
					<a href="#">본영화 등록</a>
					</div>
			</div>
			<div class="column-right">
					<h2 style="float:left;">선호관람정보</h2>
					<div class="column-right-buttom">
					<a href="#">설정</a>
					</div>
			</div>
			<div class="movie-story-box">
					<a>
						<em>0</em>
						<span>본 영화</span>
					</a>
					<a>
						<em>0</em>
						<span>관람평</span>
					</a>
					<a>
						<em>0</em>
						<span>보고싶어</span>
					</a>
					<a>
						<em>0</em>
						<span>무비포스트</span>
					</a>
			</div>
			<div class="favor-see">
				<span>내 선호장르</span><br/>
				<span>내 선호시간</span>
			</div>
		</div>
		<div class="tit-util">
			<h2 style="float:left;">나의 예매내역</h2>
			<a href="my_member_history.jsp">더보기
			<img src="./image/ico-arr-right-gray.png"/>
			</a>
		</div>
		<!-- 질문 -->
			
				<div class="history-reservation" style="text-align: center; line-height: 160px;">
					<hr style="width: 840px; position: relative;  border-top:1px solid #555; border-bottom:1px solid #eaeaea;">
					예매내역이 없습니다.
				</div>
		
		<div class="tit-util">
			<h2 style="float:left;">나의 구매내역</h2>
			<a href="my_member_history.jsp">더보기	
			<img src="./image/ico-arr-right-gray.png"/>
			</a>
		</div>
			<div style="width:840px; height:45px;">
			<hr style="width: 840px; position: absolute; margin-top: 0px; border-top:1px solid #555; border-bottom:1px solid #eaeaea;">
			<p style="text-align:center; padding: 10px; border-bottom: 1px solid #eaeaea; margin:0;">구매내역이 없습니다</p>
			</div>
		<div class="column-mt" style="margin-top: 40px;">
			<div class="column-left">
					<h2 style="float:left;">참여이벤트</h2>
					<a href="#">더보기
					<img src="./image/ico-arr-right-gray.png"/>
					</a>
					<hr style="width: 400px; position: relative;  border-top:1px solid #555; border-bottom:1px solid #eaeaea;">
					<div class="brd-list">참여한 이벤트가 없습니다.</div>
			</div>
			<div class="column-right">
					<h2 style="float:left;">문의내역</h2>
					<a href="#">더보기
					<img src="./image/ico-arr-right-gray.png"/>
					</a>
					<hr style="width: 400px;position: relative;  border-top:1px solid #555; border-bottom:1px solid #eaeaea;">
					<div class="brd-list">문의내역이 없습니다.</div>
			</div>
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