<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String likeId = request.getParameter("id");
String loginId = (String)(session.getAttribute("member_id"));
%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<link href='css/header_footer.css?' rel='stylesheet' type='text/css'>
<link href='css/movie_info.css?' rel='stylesheet' type='text/css'>
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
			<a href="상영시간표" class="link-ticket" title="상영시간표">상영시간표</a>
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
						<a id="exitButton" href="#" class="fr"><img src="image/login_img/btn-layer-close.png"/></a>
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
						<img src="image/login_img/I.png" style="margin: -9px; margin-left: -20px; margin-right: -25px;"/>
						<a href="" style="text-decoration: none; color:#666666">회원가입</a>
						<img src="image/login_img/I.png" style="margin: -9px; margin-right: -25px; margin-left: -20px;"/>
						<a href="" style="text-decoration: none; color:#666666">비회원 에매확인</a>
					</div>
					<div class="sns-login">
						<a href="">
						<img src="image/login_img/ico-facebook.png">
						</a>
						<a href="">
						<img src="image/login_img/ico-naver.png">
						</a>
						<a href="">
						<img src="image/login_img/ico-kakao.png">
						</a>
						<a href="">
						<img src="image/login_img/ico-payco.png">
						</a>
					</div>
					<div class="col-right">
					</div>
				</div>
				</form>
				<div class="right-login">
					<div class="login-ad">
						<a href="">
							<img src="image/login_img/fecf1f96c23d2dfc4deaeba5b8c33828.jpg">
						</a>
					</div>
				</div>
			</div>
		</div>
	<!-- △로그인 창 -->
	
	<!-- ▽main  -->
	
	<div class="movie-detail-page">
	<div class="bg-img" style="background-image:url(./image/movie_info/thewarofflowerPoster.jpg)"></div>
	<div class="bg-pattern"></div>
	<div class="bg-mask"></div>
	<div class="movie-detail-cont">
		<p class="d-day default">예매 D-5</p>
		<p class="contents-type">#돌비시네마</p>
		<P class="title">스파이더맨: 노 웨이 홈</P>
		<p class="title-eng">Spider-Man: No Way Home</p>
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
				<p class="cont">
					<em>1</em>
					위 (85.8%)
				</p>
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
					<em>0</em>
					명
				</p>
			</div>
		</div>
		<div class="poster">
			<div class="wrap">
				<p class="movie-grade age-12">12세 이상 관람가</p>
				<img src="image/movie_info/iec4gByIz1OuAACskdZ0t4i4PfglBgK6_420.jpg">
				<a href="#" class="btn-poster-down" title="포스터 다운로드">포스터 다운로드</a>
			</div>
		</div>
		<div class="reserve screen-type col-2">
			<div class="reserve">
				<a href="#" class="btn reserve" title="영화 예매하기">예매</a>
				<a href="#" class="btn dolby">
					<img src="image/movie_info/mov_detail_db_btn.png">
				</a>
			</div>
		</div>
	</div>
</div>
<div class="inner-wrap">
	<div class="tab-list fixed">
		<ul>
			<li>
				<a href="movie_info.jsp" title="주요정보 탭으로 이동">주요정보</a>
			</li>
			<li >
				<a href="movie_info_review.jsp" title="실관람평 탭으로 이동">실관람평</a>
			</li>
			<li class="on">
				<a href="movie_info_poster.jsp" title="무비포스트 탭으로 이동">무비포스트</a>
			</li>
			<li>
				<a href="movie_info_stillcut.jsp" title="예고편/스틸컷 탭으로 이동">예고편/스틸컷</a>
			</li>
		</ul>
	</div>
	<div class="movie-detail-poster bg-white">
		<div class="tit-util">
		<h2 class="tit small">스파이더맨: 노 웨이 홈에 대한
			<span class="font-gblue" id="postTotalcnt">774건</span>
			의 무비 포스트가 있어요!
		</h2>
		<a href="#" id="goMoviePost" title="무비포스트 페이지로 이동" class="more">
			더보기
			<i class="iconset ico-arr-right-gray"></i>
		</a>
		</div>
		<div class="box">
			<!-- 로그인 한 후 -->
			<div class="poster-write">
        		<a href="#" title="무비포스트 쓰기" class="tooltip-click">
        			<i class="iconset ico-story-write">
        			</i>
        			무비포스트 쓰기
        		</a>   
        	</div>
		</div>
	</div>
	
	<div class="board-list-tuil">
	<p class="result-count" id="postToCut">
	<strong>
		전체 (
		<b class="resultCountCut">766</b>
		건)
	</strong>
	</p>
</div>
	<div class="movie-post-list">
			<div class="grid-item">
					<div class="img">
						<a href="#" class="post-open">
						<img src="./image/movie_post/movie_long/OSwPwX3tSSnxJZMGljSs2tZESq6uFliO_230.jpg">
						</a>
					</div>
					<div class="post-cont">
						<a href="#" class="writer">
							blingjeehy** <!-- 아이디 -->
						</a>
						<a href="#" class="movie-post-tit">
							킬링 카인드: 킬러의 수제자	<!--  영화 이름 -->
						</a>
						<a href="#" class="movie-post-txt">
							친숙한 재밌는 영화..	<!-- 무비포스트 내용 -->
						</a>
						<a href="#" class="time">
							18 분전	<!--  작성 시간 -->
						</a>
						<div class="condition">
							<button class="like-btn">
							<i class="icon-like"></i>
							<span style="font-size:15px;">0</span>
							</button>
							<a class="post-comment">
							<i class="icon-reply"></i>
							<span>0</span>
							</a>
						</div>
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