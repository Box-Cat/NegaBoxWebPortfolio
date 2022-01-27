<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%//liginCheckAction에 담겨있음
String loginId = (String)(session.getAttribute("member_id"));
String name = (String)(session.getAttribute("name"));
Date today = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String todate = format.format(today);
%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>
	<script src="./js/jquery.mCustomScrollbar.js" type="text/javascript"></script> 
	<link rel="stylesheet" href="./css/movie-theater-table.css" type="text/css" />
	<link rel="stylesheet" href="./css/movie-time-table-theater.css" type="text/css" />
	<link rel="stylesheet" href="./css/jquery.mCustomScrollbar.css" type="text/css"/>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<link href='css/header_footer.css?aa' rel='stylesheet' type='text/css'>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEET PLAY SHARE, 내가박스</title>
<script>
// jQuery Scroll Plugin 적용
function fn_scroll_plugin() {
	$(".scrollbar").mCustomScrollbar({
		theme : "light-3", // 테마 적용
		mouseWheelPixels : 300, // 마우스휠 속도
		scrollInertia : 400 // 부드러운 스크롤 효과 적용
	});
}


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
	/*  ======================================= ============= =*/
});

</script>
<script type="text/javascript">
var g_list1;	
	

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

		function show_theater_schedule_list(list1) {
g_list1 = list1;			
			previous_movie_name = "";
			previous_theater_showroom = "";
			str = "";
			for(var i=0; i<=list1.length-1; i++) {
				theater_name = list1[i].theaterName;		// 강남 
				rating = list1[i].rating;      // 등급
				movie_name = list1[i].movieName;
				name = list1[i].name;						// 상영관이름
				total_seats = list1[i].totalSeats;
				type = list1[i].type;
				start_time = list1[i].startTime;
				end_time = list1[i].endTime;
				remaining_seats = list1[i].remainingSeats;
				running_time = list1[i].runningTime;

				theater_showroom = name;
				//running_time = list1[i].runningTime;
				//theater_showroom = list1[i].theaterShowroom;

				if(previous_movie_name != movie_name && i>0) {
					str += "	</div>";    // END OF THE .theater-list
				}
				if(previous_movie_name != movie_name) {
					// "유체이탈자" 출력.
					var imgRating = "";
					switch($.trim(rating)) {
					case "12세이상관람가":
						imgRating = "txt-age-small-12";
						break;
					case "15세이상관람가":
						imgRating = "txt-age-small-15";
						break;
					case "전체관람가":
						imgRating = "txt-age-small-all";
						break;
					case "청소년관람불가":
						imgRating = "txt-age-small-19";
						break;
					}
					
					str   +="<div class='theater-title'>" +
							"	<p>" +
							"		<img src='./image/"+imgRating+".png'>" +
							"		<a href='#'>"+movie_name+"</a>" +
							"	</p>" +
							"	<p class='information'>" +
							"		<span>상영중</span>" +
							"		/상영시간"+running_time+"분" +
							"	</p>" +
							"</div>" +
							"<div style='clear:both;'></div>";
				}

				if(previous_movie_name == movie_name && previous_theater_showroom == theater_showroom) {
					
					str +=  "<div class='theater-time-item theater-time-item-border-bottom'>" +
							"	<a href=''>" +
							"		<div class='ico-box'>" +
						 	/* "			<i class='iconset'></i>" */
							"		</div>" +
							"		<p class='time'>"+start_time+"</p>" +
							"		<p class='chair'> "+remaining_seats+"석</p>" +  //show_theater_schedule_list(list1)
							"		<div class='play-time'>" +
							"			<p>"+start_time+"~"+end_time+"</p>" +
							"		</div>" +
							"	</a>" +
							"</div>";   // +
							//"<div style='clear:both;'></div>";
				} 
				
				if(previous_movie_name != movie_name || previous_theater_showroom != theater_showroom) {
					str +=  "<div class='theater-list'>" +
							"<div class='theater-type-box'>" +
							"	<div class='theater-type'>" +
							"		<p class='theater-name'>"+name+"</p>" +
							"		<p class='chair'>총"+total_seats+"석</p>" +  //show_theater_schedule_list(list1)
							"	</div>" +
							"	<div class='theater-type-area'>"+type+"</div>" +
							"	<div class='theater-time-list'>" +
							"		<div class='theater-time-item theater-time-item-border-bottom'>" +
							"			<!--박스당 간격은 100px-->" +
							"			<a href=''>" +
							"				<div class='ico-box'>" +
							/* "					<i class='iconset'></i>" + */ //조조
							"				</div>" +
							"				<p class='time'>"+start_time+"</p>" +
							"				<p class='chair'>"+remaining_seats+"석</p>" +  //show_theater_schedule_list(list1)
							"				<div class='play-time'>" +
							"					<p>"+start_time+"~"+end_time+"</p>" +
							"				</div>" +
							"			</a>" +
							"		</div>";  // +
							//"		<div style='clear:both;'></div>";
					  previous_theater_showroom = theater_showroom;
				}
				previous_movie_name = movie_name;
				//alert("theater_showroom : " + theater_showroom);
				//alert(movie_name + "==" + list1[i+1].movieName + (movie_name == list1[i+1].movieName)); 
				//alert(theater_showroom + "==" + list1[i+1].name + (theater_showroom == list1[i+1].name));
				if(i==list1.length-1 || (movie_name != list1[i+1].movieName) || (theater_showroom != list1[i+1].name)) {
					str += "			</div>" +
							"			<div style='clear:both;'></div>" +
							"		</div>" +
							"	</div>" +
							"</div>";  // +
					if(i==list1.length-1 || (movie_name != list1[i+1].movieName)) {							
						str +=  "<div class='clear-blank-box'></div>";
					}
				}
			}//for문
			str  +=	"	</div>";
			//alert(str);
			$(".theater-list-box").append(str);  //YGYGYGYGYG  
			//$(".theater-list-box").attr('class', 'theater-showroom-list');
			
		}
		function show_movie_schedule_list(list1) {
			previous_theater_name = "";
			previous_theater_showroom = "";
			str = "";
			for(var i=0; i<=list1.length-1; i++) {
				theater_name = list1[i].theaterName;		// 강남
				name = list1[i].name;						// 상영관이름
				start_time = list1[i].startTime;
				end_time = list1[i].endTime;
				type = list1[i].type;
				running_time = list1[i].runningTime;
				total_seats = list1[i].totalSeats;
				remaining_seats = list1[i].remainingSeats;
				theater_showroom = list1[i].theaterShowroom;

				if(previous_theater_name != theater_name && i>0) {
					str += "	</div>";    // END OF THE .theater-list
				}
				if(previous_theater_name != theater_name) {
					// "강남" 출력.
					str   +="	<div class='clear-blank-box'></div>"
						  +	"	<div class='theater-list'>"
						  +	"		<div class='theater-area-click'>"
						  +	"			<a href='#' title='"+theater_name+" 상세보기'>"+theater_name+"</a>"	//<!--  YGYGYGYG -->
						  +	"		</div>";
					previous_theater_name = theater_name;
				}

				if(previous_theater_name == theater_name && previous_theater_showroom == theater_showroom) {
					str +=  "				<div class='theater-time-item theater-time-item-border-bottom'>"
						  +	"					<!--박스당 간격은 100px-->"
						  +	"					<a href=''>"
						  +	"						<div class='ico-box'>"
						 /*  +	"							<i class='ico-sun iconset'></i>" */ //조조
						  +	"						</div>"
						  +	"						<p class='time'>"+start_time+"</p>"
						  +	"						<p class='chair'>"+remaining_seats+"석</p>"  //show_movie_schedule_list
						  +	"						<div class='play-time'>"
						  +	"							<p>"+start_time+"~"+end_time+"</p>"
						  +	"						</div>"
						  +	"					</a>"
						  +	"				</div>";
						  //+	"				<div style='clear:both;'></div>"

				} else {
					str += "	<div class='theater-type-box'>"
					  +	"			<div class='theater-type'>"
					  +	"				<p class='theater-name'>"+name+"</p>"         // name은 상영관이름.
					  +	"				<p class='chair'>총"+total_seats+"석</p>"       //show_movie_schedule_list
					  +	"			</div>"
					  +	"			<div class='theater-type-area'>"+type+"</div>"
					  +	"			<div class='theater-time-list'>"
					  +	"				<div class='theater-time-item theater-time-item-border-bottom'>"
					  +	"					<!--박스당 간격은 100px-->"
					  +	"					<a href=''>"
					  +	"						<div class='ico-box'>"
				/* 	  +	"							<i class='ico-sun iconset'></i>" */
					  +	"						</div>"
					  +	"						<p class='time'>"+start_time+"</p>"
					  +	"						<p class='chair'>"+remaining_seats+"석</p>"  //show_movie_schedule_list
					  +	"						<div class='play-time'>"
					  +	"							<p>"+start_time+"~"+end_time+"</p>"
					  +	"						</div>"
					  +	"					</a>"
					  +	"				<div style='clear:both;'></div>"
					  +	"				</div>";
					  previous_theater_showroom = theater_showroom;
				}
				if(i==list1.length-1 || (theater_name != list1[i+1].theaterName) || (theater_showroom != list1[i+1].theaterShowroom)) {
					  str +="				</div>"
					  	  + "			<div style='clear:both;'></div>"
					 	  +	"		</div>";
				}
			}//for문
			str  +=	"	</div>";
			//$(".theater-list-box").html("");
			$(".theater-list-box .clear-blank-box").remove();
			$(".theater-list-box .theater-type-box").remove();
			$(".theater-list-box").append(str);
		} //function()
		
		var g_list, g_list2;	

			//함수 선언해서, 출력하는 원하는 곳에 나오게 함(id,class값으로 위치 지정)
			//타원에 영화 리스트 출력
		  function showMovieStar(movie_name, _this) {    // "영화별" 클릭시. // 구조상 showMovieStar()는 두 번 중첩적으로 호출하기로.  YGYGYGYG
				if(movie_name==undefined) {    // movie_name의 초기값을 설정함.
					movie_name = "";
				}
		  		if(_this!=undefined) {   // movie_name을 $(this)로부터 가져옴. // $(this)는 _this 파라미터로 받았음.
		  			//alert($.trim(_this.text()));
			  		movie_name = $.trim(_this.text());
		  		}
		  		year = $(".date-button-list button.on").parent().parent().attr("year");
		  		month = $(".date-button-list button.on").parent().parent().attr("month");
		  		date = $.trim($(".date-button-list button.on em").text());
		  		daySelected = year + "/" + (month<10 ? "0"+month : month) + "/" + (date<10 ? "0"+date : date);    // YGYGYGYG
		  		areaSelected = $.trim($(".theater-list-box >.tab-block > div.on > a").text());
		  		theater_showroom_name =$.trim($(this).parent("theater-type-box").find("theater-name").text());
		  		/* alert(areaSelected) */
		  		/* $.trim($(this).parent("theater-type-box").find("theater-name").text()) */
		  		//alert(areaSelected);
			   $.ajax({
			        type:"POST",
			        //url:"MovieTimeListServ",
			        url:"Controller?command=movieTimeList",
			        contentType: "application/x-www-form-urlencoded; charset=utf-8",
			        //data: {'movieNameSelected':"스파이더맨:노웨이홈" , 'daySelected':'22/01/09', 'areaSelected':'서울'},  
  			        data: {'movieNameSelected':movie_name , 'daySelected':daySelected, 'areaSelected':areaSelected}, 
			        datatype:"json",
			        success: function(data) { //출력하는 화면 
			          //alert(areaSelected);    // 처음 호출시에는 빈문자열. 두번째 호출시에는 '서울'.
			          please_once_more = (movie_name=="" ? true : false);
			          $("#movie-category p").html("");	
			          $("#movie-category p").append('<a href="#">전체영화</a>');
			          $("#movie-category p").append('<a href="#">큐레이션</a>');
					  $(".list-section ul").html("");
			          for(var i=0; i<=data.movie_list.length-1; i++) {
			        	  if(i==0 && movie_name=="")
			        		  movie_name = data.movie_list[i];
			        	  age = "age-";
			        	  switch($.trim(data.rating_list[i])) {
			        	  case "12세이상관람가":
			        		  age += "12";
			        		  break;
			        	  case "15세이상관람가":
			        		  age += "15";
			        		  break;
			        	  case "청소년관람불가":
			        		  age += "19";
			        		  break;
			        	  case "전체관람가":
			        		  age += "all";
			        		  break;
			        	  } 
			        	  $(".list-section ul").append('<li><button type="button" class="btn '+(data.movie_list[i]==movie_name ? 'on' : '')+'" photo="'+data.photo_list[i]+'" age="'+age+'">'+data.movie_list[i]+'</button></li>');
			        	  $(".scrollbar").css('width','785px');
			        	  $(".mCSB_draggerRail").css('bottom','170px');
			        	  if(movie_name == data.movie_list[i]) {
			        		  $(".poster-section").css('display', 'block');
			        		  $(".poster-section").css('background', 'url(./movie_photo/'+data.photo_list[i]+') no-repeat 0 0');
			        	  } 
			        	
			          }
			          
			          if(please_once_more) {
			        	  showMovieStar(movie_name);
			          } else {
				          // '신촌 상영시간표' 등 표시를 지움.
	          			  //$("#theater_selected").parent().remove();
						  //$("#movie-timetable-box").prepend("<h3 class='title'><span style='color: #037b94;' id='theater_selected'>"+theater+"</span> 상영시간표</h3>");
				          $("#movie-timetable-box > .title").remove();
				          $(".theater-list-box .theater-list").remove();
				          $(".theater-list-box .theater-title").remove();
				          $(".theater-list-box div[style='clear:both;']").remove();
				          $("#movie-timetable-box").prepend("<h3 class='title'><span style='color: #037b94;'>"+movie_name+"</span> 상영시간표</h3>");
						  //$("#theater_selected").text(theater);
				          
						  movie_name = $.trim($("#movie-theater-list-scroll ul.list li button").eq(0).text());
						  //alert(movie_name);
						  
				          show_movie_schedule_list(data.movie_schedule_list);
				          g_list = data.movie_schedule_list;
				          console.log(data.movie_schedule_list);
			          }
			          //alert("end of the success func.");
			        },
			        error: function(request,status,error){
			            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			            alert("code:"+request.status+"\n");
			            alert("message:"+request.responseText+"\n");
			            alert("error:"+error);
			            console.log(request.responseText);
			        }
			      });
		  }		
	
	  function showTheaterStar(theater, selectedDate) {		// "극장별" 클릭시.   selectedDate : "22/01/06"
		  		if(theater==undefined) {
		  			theater = "강남";
		  		}
	  			if(selectedDate==undefined) {
	  				var today = new Date();
	  				var year = today.getFullYear();
	  				var month = ('0' + (today.getMonth() + 1)).slice(-2);
	  				var day = ('0' + today.getDate()).slice(-2);
					selectedDate = year%100 + "/" + month + "/" + day;
	  			}
//alert(selectedDate + " 봤냐??");	
//url:"TheaterTimeListServ",	
			   $.ajax({
			        type:"POST",
			        url:"Controller?command=theaterTimeList",
			        contentType: "application/x-www-form-urlencoded; charset=utf-8",						// 
			        data: {'theater':theater, "selectedDate":selectedDate },
			        datatype:"json",
			        success: function(data) { //출력하는 화면
			          //alert(theater);
			          g_list = data.districtTheaterCount_list;
			          //alert(data.listTheater);
			          g_list2 = data.listTheater;
			          //alert(data.listTheaterStarScheduleVO[0].name);
			          //g_list = data.listTheaterStarScheduleVO;
					  $("#movie-category p").html("");
			          for(var i=0; i<=data.districtTheaterCount_list.length-1; i++) {
			        	  $("#movie-category p").append('<a href="#">'+data.districtTheaterCount_list[i].area+'('+data.districtTheaterCount_list[i].count+')</a>');
			          }
			          //g2_list = data.listTheater;
			          //alert(g2_list);
			          $(".list-section ul").html("");   
			          $(".scrollbar").css('width','100%');
			          $(".mCSB_draggerRail").css('bottom','124px');
			          for(var i=0;i<=data.listTheater.length-1;i++){
			        	  $(".list-section ul").append('<li><button type="button" class="btn '+((theater==data.listTheater[i]) ? 'on' : '')+'">'+data.listTheater[i]+'</button></li>');
			          }
			         $(".poster-section").css('display', 'none');
		        	 
			          
			          
			          //alert("!!!");
			          //alert( data.listTheaterStarScheduleVO );
			          g_list = data.listTheaterStarScheduleVO;
			          
			          // '신촌 상영시간표' 등 표시.
          			  $("#theater_selected").parent().remove();
			          $("#movie-timetable-box h3.title").remove();
					  $("#movie-timetable-box").prepend("<h3 class='title'><span style='color: #037b94;' id='theater_selected'>"+theater+"</span> 상영시간표</h3>");
			          //$("#theater_selected").text(theater);
			          
			          $(".theater-title").remove();
			          $(".clear-blank-box").remove();
			          $(".theater-list").remove();
			          $(".theater-list-box div[style='clear:both;']").remove();
			          show_theater_schedule_list(data.listTheaterStarScheduleVO);
			        },
			        error: function(request,status,error){
			            alert("code:"+request.status+"\n");
			            alert("message:"+request.responseText+"\n");
			            alert("error:"+error);
			            console.log(request.responseText);
			        }
/* 			        
			        error: function(e) {
			          alert("에러발생");
			        }			
 */			      });
		  }			
		  
		function setup_tab_block() {
			idx_on = $(".inner-left-area.on").index();   // idx_on이 0이면 "영화별", 1이면 "극장별"이다.
			if(idx_on==0) {   // 영화별이면.
				var s = "<div class='tab-block'>" +
						"	<div class='on'>" +
						"		<a class='btn' href='#' title='서울 선택'>서울</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='경기 선택'>경기</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='인천 선택'>인천</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='대전/충청/세종 선택'>대전/충청/세종</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='부산/대구/경상 선택'>부산/대구/경상</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='광주/전라 선택'>광주/전라</a>" +
						"	</div>" +
						"	<div class=''>" +
						"		<a class='btn' href='#' title='강원 선택'>강원</a>" +
						"	</div>" +
						"</div>";
				$(".theater-list-box").prepend(s);
				//alert(s);
			} else {   // 극장별이면.
				$(".theater-list-box .tab-block").remove();
			}
		}
			
		$(function() {
			fn_scroll_plugin();
			
			showMovieStar();
			
			 $(".inner-left-area a").click(function(e) {
				 e.preventDefault();
				var star = $(this).find("span").text().trim();
				if(star.indexOf('영화별')>-1) {
					$(this).parent(".inner-left-area").addClass("on");
				    $(".inner-left-area").not($(this).parent(".inner-left-area")).removeClass("on");
					showMovieStar(); //클릭시 '전체영화 큐레이션' 돌아오도록
				}
			
				 if(star.indexOf('극장별')>-1) {
					$(this).parent(".inner-left-area").addClass("on");
					$(".inner-left-area").not($(this).parent(".inner-left-area")).removeClass("on");
					showTheaterStar(undefined, undefined);
				} 
				setup_tab_block();      // [서울|경기|인천|...] 탭을 그리고 지움.
			 }); 
			
			// 날짜 클릭 이벤트  
			$(".date-button-list").on("click", function(){
				if($(this).find("button").attr('class')=='disabled')     // 비활성화된 날짜버튼은 클릭이 안 되도록.
					return;
				$(this).find("button").toggleClass("on");
				$(".date-button-list button").not($(this).find("button")).removeClass("on");
				//alert(theater);
				// selectedDate 계산 --------------------------------------------------------------------
				date = $.trim($(".date-list").find("button.on > em").text());
				year = $.trim($(".date-list").find("button.on").parent().parent().attr("year"));
				month = $.trim($(".date-list").find("button.on").parent().parent().attr("month"));
				selectedDate = ((Number)(year)%100) + "/" + ((Number)(month)<10 ? "0"+month : month) + "/" + ((Number)(date)<10 ? "0"+date : date);     // "22/01/06";
				// ------------------------------------------------------------------------------------
				var idx_on = $(".inner-left-area.on").index();   // idx_on이 0이면 "영화별", 1이면 "극장별"이다.
				//alert("idx_on : " + idx_on);
				if(idx_on==0) {   // 영화별이면.
					var _this = $("#movie-theater-list-scroll button.btn.on");
					var movie_name = $.trim(_this.text());
					showMovieStar(movie_name, _this);
				} else {   // 극장별이면.
					var theater = $.trim($("#movie-theater-list-scroll button.btn.on").text());
					showTheaterStar(theater, selectedDate);
				}
			})
			
			
			
			//상영시간 클릭 버튼.
			$(document).on('mouseenter', ".theater-time-item", function() {
				$(this).find(".play-time").toggleClass("on");
			});
			$(document).on('mouseleave', ".theater-time-item", function() {
				$(this).find(".play-time").toggleClass("on");
			});
						
			$(document).on("click", "#movie-theater-list-scroll ul.list li button", function() {   // 극장별 - '강남' 등을 클릭시 / 영화별 - '스파이더....' 등을 클릭시.
				var idx_on = $(".inner-left-area.on").index();   // idx_on이 0이면 "영화별", 1이면 "극장별"이다.
				//alert("idx_on : " + idx_on);
				if(idx_on==0) {   // 영화별이면.
					var movie_name = $(this).text();
					//alert("movie_name : " + movie_name);
					showMovieStar(movie_name, $(this));
					//$(this).addClass("on");
					//alert($(this).attr('class'));
				} else if(idx_on==1) {	   // 극장별이면.	
					//alert($.trim($(this).text()));
					theater_selected = $.trim($(this).text());
					// selectedDate 계산 --------------------------------------------------------------------
					date = $.trim($(".date-list").find("button.on > em").text());
					year = $.trim($(".date-list").find("button.on").parent().parent().attr("year"));
					month = $.trim($(".date-list").find("button.on").parent().parent().attr("month"));
					selectedDate = ((Number)(year)%100) + "/" + ((Number)(month)<10 ? "0"+month : month) + "/" + ((Number)(date)<10 ? "0"+date : date);     // "22/01/06";
					// ------------------------------------------------------------------------------------
					showTheaterStar(theater_selected, selectedDate);
					//$("#theater_selected").text(theater_selected);
				}
			});
			
			$(document).on("click", ".theater-time-item", function(e) {
				e.preventDefault();
				
				idx_on = $(".inner-left-area.on").index();   // idx_on이 0이면 "영화별", 1이면 "극장별"이다.
				if(idx_on==0) {   // 영화별이면.
					start_time_HM = $.trim($(this).find("div.play-time > p").text()).split("~")[0];
					end_time_HM = $.trim($(this).find("div.play-time > p").text()).split("~")[1];   // "17:38";
					movie_name = $.trim($("#movie-theater-list-scroll ul.list li button.btn.on").text());
					show_type = $.trim($(this).parent().parent().find(".theater-type-area").text()); //"2D(자막)";
					theater_name = $.trim($(this).parent().parent().parent().find(".theater-area-click").find("a").text());    //"강남";
				 	theater_showroom_name = $.trim($(this).parent().parent().find(".theater-name").text());   // "1관";
//theater_showroom_name = $.trim($(this).parent(".theater-list").find(".theater-name").text());   // "1관";
					rating = $("#movie-theater-list-scroll ul.list li button.btn.on").attr("age");
					// selectedDate 계산 --------------------------------------------------------------------
					date = $.trim($(".date-list").find("button.on > em").text());
					year = $.trim($(".date-list").find("button.on").parent().parent().attr("year"));
					month = $.trim($(".date-list").find("button.on").parent().parent().attr("month"));
					selectedDate = ((Number)(year)%100) + "/" + ((Number)(month)<10 ? "0"+month : month) + "/" + ((Number)(date)<10 ? "0"+date : date);     // "22/01/06";
					// ------------------------------------------------------------------------------------
					day = $.trim($(".date-list").find("button.on").parent().parent().attr("day"));
					fullDate = "20" + ((Number)(year)%100) + "." + ((Number)(month)<10 ? "0"+month : month) + "." + ((Number)(date)<10 ? "0"+date : date)+"("+day+")";  

					sendPost("Controller?command=quickSeatsRev", {
						"start_time_HM" : start_time_HM,
						"end_time_HM" : end_time_HM,
						"movie_name" : movie_name,
						"show_type" : show_type,
						"theater_name" : theater_name,
						"theater_showroom_name" : theater_showroom_name,
						"rating" : rating,
						"selectedDate" : selectedDate,
						"fullDate" : fullDate
					});
				
				} else {     // 극장별이면.
					start_time_HM = $.trim($(this).find("div.play-time > p").text()).split("~")[0];
					end_time_HM = $.trim($(this).find("div.play-time > p").text()).split("~")[1];   // "17:38";
					show_type = $.trim($(this).parent().parent().find(".theater-type-area").text()); //"2D(자막)";
					theater_name = $.trim($(this).parents().find("h3.title > span").text()); //"강남";
					theater_showroom_name = $.trim($(this).parent().parent().find(".theater-name").text());   // "1관";
					rating_element = $(this).parent().parent().parent().prev();
					while(rating_element.attr('class') != 'theater-title') {
						rating_element = rating_element.prev();
					}
					movie_name = $.trim(rating_element.find("p > a").text()); //"스파이더맨: 노 웨이 홈";
					
					rating = rating_element.find("p > img").attr('src'); //"age-12";
					idx1 = rating.lastIndexOf("-");
					idx2 = rating.lastIndexOf(".");
					rating = "age-" + rating.substring(idx1+1, idx2);   // "age-12"

					// selectedDate 계산 --------------------------------------------------------------------
					date = $.trim($(".date-list").find("button.on > em").text());
					year = $.trim($(".date-list").find("button.on").parent().parent().attr("year"));
					month = $.trim($(".date-list").find("button.on").parent().parent().attr("month"));
					selectedDate = ((Number)(year)%100) + "/" + ((Number)(month)<10 ? "0"+month : month) + "/" + ((Number)(date)<10 ? "0"+date : date);     // "22/01/06";
					// ------------------------------------------------------------------------------------
					day = $.trim($(".date-list").find("button.on").parent().parent().attr("day"));
					fullDate = "20" + ((Number)(year)%100) + "." + ((Number)(month)<10 ? "0"+month : month) + "." + ((Number)(date)<10 ? "0"+date : date)+"("+day+")";   

					sendPost("Controller?command=quickSeatsRev", {
						"start_time_HM" : start_time_HM,
						"end_time_HM" : end_time_HM,
						"movie_name" : movie_name,
						"show_type" : show_type,
						"theater_name" : theater_name,
						"theater_showroom_name" : theater_showroom_name,
						"rating" : rating,
						"selectedDate" : selectedDate,
						"fullDate" : fullDate
					});
				}
			});

			setup_tab_block();

		});    // the end of the $(function(){})

	</script>
</head>
<body>
	<!-- header -->
	<header id="header" class="main-header no-bg">
		<div class="ci">
		<a href="Controller?command=main" title="내가박스 메인으로 가기"></a>
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
				<a href="Controller?command=sendEmail" title="회원가입">회원가입</a>
				<%} else { %>
				<!-- <a href="#" title="알림">알림</a> -->
				<% } %>
				<a href="Controller?command=fastRev" title="빠른예매">빠른예매</a>
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
					<a href="Controller?command=allMovie" class="gnb-txt-movie" title="영화"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
							<li><a href="#" title="N스크린">N스크린</a></li>
							<li><a href="#" title="큐레이션">큐레이션</a></li>
							<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="Controller?command=fastRev" class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
							<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="#" class="gnb-txt-theater" title="극장"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=allMovie" title="전체극장">전체극장</a></li>
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
					<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
					<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
					<li><a href="javascript:void(0)" onclick="javascript:MegaboxUtil.Common.moveMovieFilmCheck();"
							title="영화제">영화제</a></li>
					<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
				</ul>
			</div>
			<div class="list position-2">
				<p class="tit-depth">예매</p>
				<ul class="list-depth">
					<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
					<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
					<li><a href="javascript:void(0);" title="더 부티크 프라빗 예매">더 부티크 프라이빗 예매</a></li>
				</ul>
			</div>

			<div class="list position-3">
				<p class="tit-depth">극장</p>

				<ul class="list-depth">
					<li><a href="#" title="전체극장">전체극장</a></li>
					<li><a href="javascript:void(0);" title="특별관">특별관</a></li>
				</ul>
			</div>

			<div class="list position-4">
				<p class="tit-depth">이벤트</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0)" title="진행중 이벤트">진행중 이벤트</a></li>
					<li><a href="javascript:void(0)" title="지난 이벤트">지난
							이벤트</a></li>
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
					<li><a href="javascript:void(0)"  title="기프트카드">기프트카드</a></li>
				</ul>
			</div>

			<div class="list position-6">
				<p class="tit-depth">나의 내가박스</p>
				<ul class="list-depth mymage">


					<li><a href="javascript:void(0);" title="나의 내가박스 홈">나의 내가박스 홈</a></li>
					<li><a href="javascript:void(0);" title="예매/구매내역">예매/구매내역</a></li>
					<li><a href="javascript:void(0);" title="영화관람권">영화관람권</a></li>
					<li><a href="javascript:void(0);" title="스토어교환권">스토어교환권</a></li>
					<li><a href="javascript:void(0);" title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>

					<li><a href="javascript:void(0);" title="멤버십포인트">멤버십포인트</a></li>
					<li><a href="javascript:void(0);" title="나의 무비스토리">나의 무비스토리</a></li>
					<li><a href="javascript:void(0);" title="나의 이벤트 응모내역">나의 이벤트 응모내역</a></li>
					<li><a href="javascript:void(0);" title="나의 문의내역">나의 문의내역</a></li>
					<li><a href="javascript:void(0);" title="자주쓰는 할인 카드">자주쓰는 할인 카드</a></li>
					<li><a href="javascript:void(0);" title="회원정보">회원정보</a></li>
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
					<a href="Controller?command=sendEmail" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직 회원이 아니신가요?</a>
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
					예매
				</a>
				<a href="#" title="페이지 이동">
					상영시간표
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
				<form method="post" action="Controller?command=loginCheck">
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
							<a href="Controller?command=sendEmail" style="text-decoration: none; color:#666666">회원가입</a>
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
	<div class='container'>
		<div id='contents'>
			<div id='inner-wrap'>

				<div id="choice-area">

					<div id="left-area">
						<div class='inner-left-area on'>
							<a href=''><img src='./image/ico-tab-movie.png'><span>영화별</span></a>
						</div>
						<div class='inner-left-area'>
							<a href=''><img src='./image/ico-tab-theater-on.png'><span>극장별</span></a>
						</div>
						<div class='inner-left-area'>
							<a href=''><img src='./image/ico-tab-special.png'><span>특별관</span></a>
						</div>
					</div>
					<div id='right-area'>
						<div id='movie-category'>
							<p>
								<a href='#' class='on'>전체영화</a>
								<a href='#'> 큐레이션</a>

							</p>
						</div>

						<div class='list-section'>
							<div id="movie-theater-list-scroll" class="scrollbar">
								<ul class="list" style="padding-top: 125px;">
					
											
											
											
								</ul>
							</div>
						<div class='scroll'>

						</div>
						</div>
						<div class='poster-section'>


						</div>


					</div>
				</div>

				
				
				<!-- 상영 시간표 -->
					
				
				
				<div id='movie-timetable-box'>  
					<!-- <h3 class='title'><span style='color: #037b94;'>고스트버스터즈 라이즈</span> 상영시간표</h3> 질문 -->
					<div class='wrap'>
						<button class='btn-pre'><img src='./image/ico-cld-pre.png'></button>
						<div class='date-list'>
	
						<script>
							let today = new Date();
							let year = today.getFullYear(); 
							let month = today.getMonth() + 1;
							let date = today.getDate();
							let day = today.getDay(); // 요일  day:0 일요일/ day:6:토요일
							
							str = year + "." + month;
							document.write("<div class='year-box'>"+str+"</div>");
						</script>
						
						<script>
						//var arr_date = [5,6,7,8,9,10,11,12,13,14,15,16,17,18];   // 일
						//var arr_day = ['오늘', '내일', '화', '수','목','금','토','일','월','화','수','목','금','토'];    // 요일
						var arr_date = new Array(14);
						var arr_day = new Array(14);     // 요일
						var arr_year = new Array(14);
						var arr_month = new Array(14);

						
						for(var i=0;i<14;i++){ // 일단, arr_day[] 에 0~6를 넣어놓고.  (i가 0이면 '오늘'임.) %는 몫이 아니라, 나머지를 구하는 것
							arr_day[i] = (day+i)%7;	
						
							today = new Date();
							the_day = new Date(today.setDate(today.getDate() + i));
							arr_year[i] = the_day.getFullYear();
							arr_month[i] = the_day.getMonth()+1;
							arr_date[i] = the_day.getDate();
						}
						for(var i=0;i<14;i++){
							switch(arr_day[i]){
								case 0: arr_day[i] = '일'; break;
								case 1: arr_day[i] = '월'; break;
								case 2: arr_day[i] = '화'; break;
								case 3: arr_day[i] = '수'; break;
								case 4: arr_day[i] = '목'; break;
								case 5: arr_day[i] = '금'; break;
								case 6: arr_day[i] = '토'; break;
							}
						}
						for(var i=0;i<14;i++){
							 today = new Date();
							arr_date[i] = new Date(today.setDate(today.getDate()+i)).getDate();
						}			
						
						
						
						for(var i=0;i<14;i++){ 
							var str =	"<div class='date-button-list' year='"+arr_year[i]+"' month='"+arr_month[i]+"' day='"+arr_day[i]+"'>"  
									+		"<div class='wrap'>"
									+			"<button class=''>"
									/* +               "<span class='ir'></span>"	 */									
									+				"<em>"
									+					arr_date[i]
									+				"</em>"
									+			"<span style='display: inline-block;'>"+arr_day[i]+"</span>"
									+			"</button>"
									+		"</div>"
									+	"</div>";
									document.write(str);
									if(arr_day[i]=="토"){
										$(".date-button-list .wrap button").eq(i).attr('class','sat');
									}
									else if (arr_day[i]=="일"){
										$(".date-button-list .wrap button").eq(i).attr('class','holi');
									}
									if(i>=12){
										$(".date-button-list .wrap button").eq(i).attr('class','disabled');
									}
									if(i==0) {
										$(".date-button-list .wrap button").eq(i).addClass('on');
									}
									if(i==0) {
										$(".date-button-list .wrap button span").eq(i).text('오늘');
									}
									if(i==1) {
										$(".date-button-list .wrap button span").eq(i).text('내일');
									}
						}
						</script>
				
						
						</div>
						<button class='btn-next'><img src='./image/ico-cld-next.png'></button>
						<button class='btn-calendar-large'></button>
						<div style='clear:both;'></div>
					</div>
					<div style='clear:both;'></div>
				</div>
				<div id='movie-icon'>
					<div style='float:left;'>
						<img src='./image/ico-greeting-option01.png'>무대인사
						<img src='./image/ico-greeting-option02.png'>회원시사
						<img src='./image/ico-greeting-option03.png'>오픈시사
						<img src='./image/ico-greeting-option04.png'>굿즈패키지
						<img src='./image/ico-greeting-option05.png'>싱어롱
						<img src='./image/ico-greeting-option06.png'>GV
						<img src='./image/ico-greeting-option-sun.png'>조조
						<img src='./image/ico-time-brunch.png'>브런치
						<img src='./image/ico-greeting-option-moon.png'>심야
					</div>
					<div style='float:right;'>
						<a id='rate-label' href='#'><img src='./image/ico-exclamation.png'><span
								style='position: relative; bottom: 4px;'> 관람등급안내</span></a>
					</div>
				</div>
				<div style='clear:both;'></div>


				<!-- 상영 시간표 -->

				<div class='theater-list-box'>
<!--
 					<div class='tab-block'>
						<div class='on'>
							<a class='btn' href='#' title='서울 선택'>서울</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='경기 선택'>경기</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='인천 선택'>인천</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='대전/충청/세종 선택'>대전/충청/세종</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='부산/대구/경상 선택'>부산/대구/경상</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='광주/전라 선택'>광주/전라</a>
						</div>
						<div class=''>
							<a class='btn' href='#' title='강원 선택'>강원</a>
						</div>
					</div>
 -->
				</div>
			</div>
		</div>
		<!--contents-->
	</div>
	<!--container-->


	<!--퀵 버튼  -->
	<div class="quick-area" style="display: block;">
		<a href="" class="btn-go-top" title="top" style="position: absolute;">top</a>
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
					<a href="javascript:void(0);">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-appstore.png)">
						</div>
					</a>
					<a href="https://play.google.com/store/apps/details?id=com.megabox.mop">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-googleplay.png)">
						</div>
					</a>
					<a href="https://www.instagram.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-instagram.png)">
						</div>
					</a>
					<a href="https://www.facebook.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-facebook.png)">
						</div>
					</a>
					<a href="https://twitter.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-twitter.png)">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>