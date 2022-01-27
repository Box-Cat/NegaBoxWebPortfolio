<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.*"%>
<%@ page import= "java.util.Arrays"%> 
<%
String userloginId = (String)(session.getAttribute("member_id"));
String name = (String)(session.getAttribute("name"));
Date today = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
String todate = format.format(today);

//'빠른 예매'페이지로부터 정보를 받는 함수 
request.setCharacterEncoding("UTF-8");
ArrayList<ExitDoorVO> listExitDoorVO = (ArrayList<ExitDoorVO>)request.getAttribute("listExitDoorVO");
ArrayList<String> listPrintStr = (ArrayList<String>)request.getAttribute("listPrintStr");
ArrayList<String> moviePosterJpgs = (ArrayList<String>)request.getAttribute("moviePosterJpgs");
ArrayList<MovieEndTime> movieEndTimeList = (ArrayList<MovieEndTime>)request.getAttribute("movieEndTimeList");
ArrayList<AColsVO> listAColsVO = (ArrayList<AColsVO>)request.getAttribute("listAColsVO");
Set<String> hsetReserved = (Set<String>)request.getAttribute("hsetReserved");
//String[] arrSeats = (String[])request.getAttribute("arrSeats");
int year = (Integer)request.getAttribute("year");
int month = (Integer)request.getAttribute("month");
int date = (Integer)request.getAttribute("date");
int hour = (Integer)request.getAttribute("hour");
int minute = (Integer)request.getAttribute("minute"); 
String movie_name = request.getParameter("movie_name");
String start_time_HM = (String)request.getAttribute("start_time_HM");
String end_time_HM = (String)request.getAttribute("end_time_HM");
String show_type = (String)request.getAttribute("show_type");
String theater_name = (String)request.getAttribute("theater_name");
String theater_showroom_name = (String)request.getAttribute("theater_showroom_name");
String rating = (String)request.getAttribute("rating");
String selectedDate = (String)request.getAttribute("selectedDate");
String fullDate = (String)request.getAttribute("fullDate");
String tmp_theater_name = (String)request.getAttribute("tmp_theater_name");
String tmp_theater_showroom_name = (String)request.getAttribute("tmp_theater_showroom_name");
String tmpRating = (String)request.getAttribute("tmpRating");
String showroom = (String)request.getAttribute("showroom");


/*
String strHour = (hour < 10 ? "0" + hour : hour+"");
String strMinute =  (minute < 10 ? "0" + minute : minute+"");
String strFullHour = strHour + ":" + strMinute;
String strYear = String.valueOf(year);
strYear = strYear.substring(2);
String strMonth = (month < 10 ? "0" + month : month+"");
String strDate = (date < 10 ? "0" + date : date+"");
String strToday = strYear +"/"+ strMonth +"/"+ strDate;
*/

System.out.println("'빠른예매'에서 넘겨 받은 정보");
System.out.println("tmp_theater_name : " + tmp_theater_name);	
System.out.println("loginId :"+userloginId);
System.out.println("start_time_HM : "+start_time_HM);
System.out.println("end_time_HM : "+end_time_HM);
System.out.println("movie_name : "+movie_name);
System.out.println("show_type : "+show_type);
System.out.println("theater_name : "+theater_name);
System.out.println("theater_showroom_name :"+theater_showroom_name);
System.out.println("rating :"+rating);
System.out.println("selectedDate :"+selectedDate);
System.out.println("fullDate :"+fullDate); 
System.out.println("showroom :" + showroom);
System.out.println();


//-------------------------------------------------------------------------------------------------------------------------------------빠른예매에서 받아오는 값들 정리
%>

<%-- 
<%
ArrayList<String> listSeatArrInfo = new ArrayList<String>();
ArrayList<ExitDoorVO> listExitDoorVO = new ArrayList<ExitDoorVO>();
ArrayList<AColsVO> listAColsVO = new ArrayList<AColsVO>();


//▽DBConnection
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String db_id = "megabox";
String db_pw = "user1234";

Connection conn = null;
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, db_id, db_pw);
} catch(Exception e) {   // ClassNotFoundException, SQLException
	e.printStackTrace();
}
//△DBConnection


//DAO1
/* 좌석 출력 */ 
String sql = "select seat_cols FROM seat_arr_info WHERE showroom = ? "; 
PreparedStatement pstmt = conn.prepareStatement(sql);	 
pstmt.setString(1,showroom);
ResultSet rs = pstmt.executeQuery();

while(rs.next()){
	String seatCols = rs.getString("seat_cols");
	String vo = new String(seatCols);
	listSeatArrInfo.add(vo);	
}

//DAO2
// A_LEFT, A_TOP의 정보를 담기 위한 sql문
String sql2 = "SELECT A_LEFT, A_TOP FROM theater_showroom WHERE theater_showroom_code =?"; 
pstmt = conn.prepareStatement(sql2);	 
pstmt.setString(1,showroom);
rs = pstmt.executeQuery();

rs.next();
int aLeft = rs.getInt("A_LEFT");
int aTop = rs.getInt("A_TOP");
/*listAColsVO에 sql값이 잘 들어갔는지, 확인하기  */
/* System.out.println("left: "+aLeft +"//"+"top: "+aTop); */


//DAO3
/* 출입구 출력  */
String sql3 = "SELECT direction, x_left, y_top FROM exit_door WHERE showroom_code=?";
pstmt = conn.prepareStatement(sql3);
pstmt.setString(1,showroom);
rs = pstmt.executeQuery();

while(rs.next()){
	String direction = rs.getString("DIRECTION");
	String xLeft = rs.getString("X_LEFT");
	String yTop = rs.getString("Y_TOP");
	ExitDoorVO vo = new ExitDoorVO(direction, xLeft, yTop);
	listExitDoorVO.add(vo);
}
/*listExitDoorVO에 sql값이 잘 들어갔는지, 확인하기  */
/* for(ExitDoorVO check : listExitDoorVO){
	System.out.println(check);
} */

//DAO4
/* 포스터 출력  */ 
ArrayList<String> moviePosterJpgs = new ArrayList<String> ();
String sql4 = "SELECT movie_photo FROM movie WHERE movie_name like ?";
pstmt = conn.prepareStatement(sql4);
pstmt.setString(1,movie_name);
rs = pstmt.executeQuery();

while(rs.next()){
  String moviePhoto = rs.getString("MOVIE_PHOTO");
  moviePosterJpgs.add(moviePhoto);
}
for(String check2 : moviePosterJpgs){
	System.out.println("moviePosterJpgs : "+ check2);
}


//상영시간표 태그 출력

//DAO5
ArrayList<MovieEndTime> movieEndTimeList = new ArrayList<MovieEndTime>(); 
String sql5 = "SELECT si.time, m.running_time "
		    +" FROM screen_info si, movie m "
			+" WHERE si.movie_code = m.movie_code "
			+" and si.day = '"+selectedDate+"' "
			+" and si.theater_id='"+tmp_theater_name+"' "
			+" and m.movie_name like '%"+movie_name+"%'"
			+ ( strToday.equals(selectedDate) ? " and si.time >= '"+strFullHour+"'" : "") 
			+" order by time asc";

	 	    
	pstmt = conn.prepareStatement(sql5);
	rs= pstmt.executeQuery();

while(rs.next()){ 
	String movieTime = rs.getString("time");
    int runningTime = rs.getInt("running_time");
	int timeH = Integer.parseInt(movieTime.split(":")[0]);
	int timeM = Integer.parseInt(movieTime.split(":")[1]);	
	timeM += runningTime+10;
	timeH += timeM/60;
	timeM = timeM%60;
	String endTime = (timeH < 10 ? "0" : "") + timeH + ":" + (timeM < 10 ? "0" : "") + timeM;
    MovieEndTime vo = new MovieEndTime(movieTime, runningTime, endTime);
    movieEndTimeList.add(vo);  	
}
rs.close();
pstmt.close();


//DAO6
//예약좌석 불러오는 쿼리문  set은 순서 없이 집합덩어리를 불러온다(수학의 정석 1단원의 집합모습). 단, 중복은 허용하지 않는다.
Set<String> hsetReserved = new HashSet<String>();    // ex. {"A1", "A2", ...}
sql = "select r.seat from reservation r, screen_info si where r.screen_info_code = si.movie_info_code"
	+ " and si.day=?"        // '22/01/06'
	+ " and si.time=?"		 // '09:10'
	+ " and si.theater_showroom=?";  // 'GANGNAM1'
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, selectedDate);
pstmt.setString(2, start_time_HM);
pstmt.setString(3, showroom);
rs = pstmt.executeQuery();
while(rs.next()) {
	String seat = rs.getString(1);
	hsetReserved.add(seat);
}
rs.close();
pstmt.close();
%>  
<!--중간삽입 -->	
		<%-- <%
		ArrayList<String> listPrintStr = new ArrayList<String>();
		listPrintStr.add("<div style='position:relative;'>");
	
		String[] arrSeats = new String[listSeatArrInfo.size()];
		int size = 0;							
		for(String temp : listSeatArrInfo ){
			arrSeats[size++] = temp;
		}	

		for(int i=0; i<arrSeats.length; i++) {
			
			int alphabetLeft = 107; 
			int alphabetTop = 20*i + 11; 
			listPrintStr.add("<div col=" + (char)('A'+i) + ">");
			listPrintStr.add("<button type='button' class='btn-seat-row' style'position:absolute; top:"+(aTop+20*i)+"px; left:"+(aLeft)+"px;'>"+(char)('A'+i)+"</button>");
					
			String[] arrRowSeats = arrSeats[i].split(",");
			int left = aLeft + 48; // 219;   // 20씩 증가.
			
			for(int j=0; j<=arrRowSeats.length-1; j++) {
				String strHandi = arrRowSeats[j].startsWith("h") ? "handicap" : "";
				String strCorona = arrRowSeats[j].startsWith("x") ? "corona" : "";
				if(strHandi.equals("handicap")) {
					arrRowSeats[j] = arrRowSeats[j].substring(1);
				}
				if(strCorona.equals("corona")){
					arrRowSeats[j] = " ";
				}
				String seatNumber = ((char)('A'+i)) + "" + arrRowSeats[j]; 
				if(hsetReserved.contains(seatNumber)) {
					listPrintStr.add("<button type='button' class='btn-seat reserved' style='position:absolute; left:" + (left) + "px; top:" + (aTop+20*i) + "px; '>");
					listPrintStr.add("<span class='num'></span>");
					listPrintStr.add("</button>");
		
				} else if(!arrRowSeats[j].equals("") && !arrRowSeats[j].equals("n")) { //질문. n이 뜻이지?/
					/* System.out.println("공석아님 : ." + arrRowSeats[j] + "."); */
					listPrintStr.add("<button type='button' class='btn-seat "+strHandi + " " + strCorona + "' style='position:absolute; left:" + left + "px; top:" + (aTop+20*i) + "px;'>");
					listPrintStr.add("<span class='num'>" + arrRowSeats[j] + "</span>");
					listPrintStr.add("</button>");
			
				} //여기까지, (옆으로 20px씩 이동하면서) 1줄을 설치
				left += 20;
			}
			listPrintStr.add("</div>");
		}
		%>  --%>

<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<link href='css/header_footer.css?aa' rel='stylesheet' type='text/css'>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEET PLAY SHARE, 내가박스</title>
<script src="js/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="css/quick-seat-rev.css" type="text/css" />
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
	/*  ======================================= ============= =*/
});

</script>
<script>
		var g_arr_seats = ['-','-','-','-','-','-','-','-'];//new Array(8);
		var age = "";
		
		//티켓 가격 계산 함수
		function calcPrice() {
			var adultPrice = 10000;
			var teenPrice = 8000;
			var handiPrice = 5000;
			var sumPrice = (Number)($("#show-number1").text())*adultPrice +  (Number)($("#show-number2").text())*teenPrice + (Number)($("#show-number3").text())*handiPrice ;
			$("#money em").text(sumPrice);
		}
		
		function popupByAge(age) {	// 'all', '12', '15', '19' 
		 	$.trim(age);
			if (age == 'all' || age == 'ALL') {
				//my_class = $("#layer_age_alert_19").attr('class');
				$("#layer_age_alert_all").toggleClass('on');
			} else if (age == '12' || age == 12) {
				$("#layer_age_alert_12").toggleClass('on');
			} else if (age == '15' || age == 15) {
				$("#layer_age_alert_15").toggleClass('on');
			} else if (age == '19' || age == 19) {
				$("#layer_age_alert_19").toggleClass('on'); 		
			}
		}
	
		function initial_arr_seats() {
			for(var i=0; i<=7; i++) {
				 g_arr_seats[i]='-';
				 $("div.seat").eq(i).removeClass("choice");
				 $("div.seat").eq(i).text("-");
			}
		}
		function length_of_arr_seats() {
			var cnt = 0;
			for(var i=0; i<=7; i++) {
				if(g_arr_seats[i]=='-')
					break;
				cnt++;
			}
			//alert("length of arr seats --- cnt : " + cnt);
			return cnt;
		}
		function is_empty_arr_seats() {   // is_empty_arr_seats() : g_arr_seats 배열이 비어 있으면 true를 리턴 (아니면 false를 리턴).
			var cnt = 0;
			for(var i=0; i<=7; i++) {
				if(g_arr_seats[i] != '-') cnt++;
			}
			if(cnt==8) return true;
			return false;
		}
		function add_to_arr_seats(seat_number) {
			if(is_empty_arr_seats())
				return;
			for(var i=0; i<=7; i++) {   // i : seat_number가 들어갈 인덱스번호.
				if(g_arr_seats[i]=='-') {
					g_arr_seats[i] = seat_number;
					break;
				}
			}				
		}
		
		function remove_from_arr_seats(seat_number) {
			idx = 0;
			for(var i=0; i<=7; i++) {   // idx : 요소들 중 seat_number가 위치한 인덱스번호.
				if(g_arr_seats[i]==seat_number) {
					idx = i;
					break;
				}
			}
			// ex) idx:4 -------> 0 1 2 3 [4] 5 6 7  ---------> i를 4,5,6으로 반복. ---> [i+1]에 있던 것을 [i]로 복사.  -----> 마지막 [7]은 '-'로 채움.
			for(var i=idx; i<=6; i++) {
				g_arr_seats[i] = g_arr_seats[i+1];
			}
			g_arr_seats[7] = '-';
		}
		function get_maximum_num_of_seats() {
//			alert((Number)($("#show-number1").text())+(Number)($("#show-number2").text())+(Number)($("#show-number3").text()));
			return (Number)($("#show-number1").text())+(Number)($("#show-number2").text())+(Number)($("#show-number3").text());
		}
		
		function show_arr_seats() {
			for(var i=0; i<=7; i++) {
			    if(g_arr_seats[i]!=undefined && g_arr_seats[i]!='-') {
				    $("div.seat").eq(i).text(g_arr_seats[i]);
				    $("div.seat").eq(i).addClass("choice");
				} else {
					$("div.seat").eq(i).text(g_arr_seats[i]);
				    $("div.seat").eq(i).removeClass("choice");
				}
			}
		}
		
		
		function on_click_next() {
			if( $("#after-button").attr('class').indexOf('on') == -1) { return; }
			var str_seats_selected = "";
			var str_seats_price = "";
			var str_seats_age = "";
			$(".selected").each(function(index, item) {
				str_seats_selected += ($(this).parent().attr("col") + $(this).find("span").text()) + "_" ;
			});	                                       /* attr("col")은 알파벳값.  find("span").text()은 좌석번호값 */   
			$("#my-seat .seat").each(function(index, item) {
				if($(this).attr('price')!=undefined) {
					str_seats_price += ($(this).attr('price')) + "_";
					str_seats_age += ($(this).attr('age')) + "_";
				}
			});
			//return;
			
			var loginId = "<%=userloginId%>";
		    var screen_info_code = '<%=selectedDate%>_<%=showroom%>_<%=start_time_HM%>';
		    var checkLoginId = "<%=userloginId%>";
			
	        if(checkLoginId == 'null'){
			    $(".background").addClass('on');
		 		return;
		    }
		 
			
 		   $.ajax({
		        type:"POST",
		        url:"Controller?command=insertSeats",
		        contentType: "application/x-www-form-urlencoded; charset=utf-8",
		        data: {'loginId':loginId, 'seats_selected':str_seats_selected, 'seats_price':str_seats_price, 'seats_age':str_seats_age, 'screen_info_code':screen_info_code}, 
		        
		        datatype:"json",
		        success: function(data) { //출력하는 화면
						$(".alert-popup-background").addClass("on");
		        
		        },
		        error: function(request,status,error){
		            alert("code:"+request.status+"\n");
		            alert("message:"+request.responseText+"\n");
		            alert("error:"+error);
		        }
		      });
		}
		
		function setup_nextpage_btn(total_count) {
			var arr_num_seats = new Array(3); 
			if(total_count==undefined) {
				$(".show-number").each(function(index, item) {
					//alert(index + " / " + $.trim($(this).text()));
					arr_num_seats[index] = Number($.trim($(this).text()));	
				});
				total_count = 0;
				for(var i=0; i<=2; i++) {
					if(arr_num_seats[i]>0)
						total_count+=arr_num_seats[i];
				}
			}
			
			count_selected = $(".btn-seat.selected").length;
			// count_selected vs total_count
			if(count_selected == total_count && total_count>0) {
				$("#after-button").addClass("on");
			} else {
				$("#after-button").removeClass("on");
			}
		}

		function setup_right_panel() {
			// 1. 성인 10,000원 / 청소년8,000원 / 우대5,000원
			var arr_num_seats = new Array(3);
			//var arr_price = [10000,8000,5000];
			//var arr_age = ['성인', '청소년', '우대'];
			var arr_age = new Array($("#seat-count .cell > span").length);
			var arr_price = new Array($("#seat-count .cell > span").length);

			$("#seat-count .cell > span").each(function(index, item) {
				age_title = $.trim($(this).text());
				arr_age[index] = age_title;
				price = 0;
				switch(age_title) {
				case "성인": price = 10000; break;
				case "청소년": price = 8000; break;
				case "우대" : price = 5000; break;
				}
				arr_price[index] = price;
			});
			
			$(".show-number").each(function(index, item) {
				arr_num_seats[index] = $.trim($(this).text());
			});
			// 2 3 2
			$("#my-seat .seat").removeClass('possible');
			$("#my-seat .seat").removeAttr('price');
			$("#my-seat .seat").removeAttr('age');
			
			var idxRightPanel = 0;
			for(var i=0; i<=2; i++) {   // i가 0이면 성인. i는 arr_num_seats 배열에 사용할 인덱스번호.
				while(arr_num_seats[i]>0) {
					$("#my-seat .seat").eq(idxRightPanel).addClass('possible');
					$("#my-seat .seat").eq(idxRightPanel).attr('price', arr_price[i]);
					$("#my-seat .seat").eq(idxRightPanel).attr('age', arr_age[i]);
					idxRightPanel++;
					
					arr_num_seats[i]--;
				}
			}
			
			// 2. 우측패널 성인/청소년/우대 개수 셋팅.
			$("#people-count > span > em").text("0");
			$(".show-number").each(function(index, item) {
				arr_num_seats[index] = Number($.trim($(this).text()));	
			});
			var total_count = 0;
			for(var i=0; i<=2; i++) {
				if(arr_num_seats[i]>0)
					total_count+=arr_num_seats[i];
			}
			if(total_count==0) {
				$("#people-count").css("visibility","hidden");
			} else {
				$("#people-count").css("visibility","visible");
				for(var i=0; i<=2; i++) {
					if(arr_num_seats[i]>0) {
						if("성인"==arr_age[i])
							$("#people-count > span > em").eq(0).text(arr_num_seats[i]);
						else if("청소년"==arr_age[i])
							$("#people-count > span > em").eq(1).text(arr_num_seats[i]);
						else if("우대"==arr_age[i])
							$("#people-count > span > em").eq(2).text(arr_num_seats[i]);
						
					}
				}
			}	
			
			// 3. 우측패널 '다음' 버튼 색상 처리.
			setup_nextpage_btn(total_count);
		}

		$(function () { 
			show_arr_seats();
			age = "<%=tmpRating%>";
			popupByAge(age);

			//나이 팝업창 종료 '엑스' 버튼
			$(".btn-modal-close").on("click", function () {
				$(".modal-layer").removeClass("on");
			});
			//나이 팝업창 종료 '확인' 버튼
			$(".button.purple.close-layer").on("click", function () {
				$(".modal-layer").removeClass("on");
			});
			//자리 제한 파업창 종료 '엑스' 버튼
			$(".button.purple.confirm").on("click", function () {
				$(".alert-popup-background").removeClass("on");
				location.href = "index.jsp";
			});
			//나이 팝업창 종료 '확인' 버튼
			$(".btn-layer-close").on("click", function () {
				$(".alert-popup-background").removeClass("on");
			});
			
			
			//좌석 초기화 버튼 클릭시.
			$(document).on("click", ".initial", function(){ 
				$(this).parents("#seat-sum-selection").find(".show-number").html(0);	
				$(".btn-seat").removeClass("selected");
				$("#my-seat .seat").removeClass("possible");
				$("#money em").text(0);
				initial_arr_seats();
				setup_nextpage_btn();
			})
		
				
				
			
			$(".plus").click(function(e) {
				var sum =0;
				
				var qty = Number($(this).parent().find(".show-number").html());
				qty = qty + 1;
				$(this).parent().find(".show-number").text(qty);
				
				youth = (Number)($(this).parent().find("#show-number1").text());
				adult = (Number)($(this).parent().find("#show-number2").text());
				handi = (Number)($(this).parent().find("#show-number3").text());
				
				
				$(".show-number").each(function() {  
					peopleNumber = $(this).text();
					sum += Number(peopleNumber);
				});
				if(sum>8){
					sum = 8;
					qty = qty - 1;
					$(this).parent().find(".show-number").text(qty);
				}
				calcPrice();
				var peopleType = $(this).parent().parent().find("span").text();
				
				setup_right_panel();   // 성인,청소년,우대 숫자 읽어서 오른쪽 8개 칸에 가격 등을 셋팅.
			});
		
			$(".minus").click(function(e) {
				var sum = 0;
				var qty = Number($(this).parent().find(".show-number").html());
				qty = qty - 1;
				if(qty<=0)
					qty=0;
				$(this).parent().find(".show-number").text(qty);
				$(".show-number").each(function() {  
					peopleNumber = $(this).text();
				});
				if(sum>8){
					sum = 8;
				}
				calcPrice();
				var peopleType = $(this).parent().parent().find("span").text();
				
				setup_right_panel();   // 성인,청소년,우대 숫자 읽어서 오른쪽 8개 칸에 가격 등을 셋팅.
			});
			
			//좌석 클릭
			$(".btn-seat").on("click", function(e){
				if($(this).hasClass("corona")){ 
                    e.preventDefault;						
				}else{
					toggle_to_on = false;    // off에서 on으로 가는 것이면, true.
					if($(this).hasClass("selected")==false) {
						toggle_to_on = true;
					} else {
						toggle_to_off = false;
					}
				    seat_number = $(this).parent().attr("col") + $.trim($(this).find("span.num").text());
				    
				    if(toggle_to_on==true && length_of_arr_seats()<get_maximum_num_of_seats()) {		// off에서 on으로 바뀐 상황.
				    	add_to_arr_seats(seat_number);
						$(this).toggleClass("selected");
				    } 
				    else if(toggle_to_on==false){
				    	remove_from_arr_seats(seat_number);
						$(this).toggleClass("selected");
				    }
				    //$("div.seat").eq(0).text(seat_number);
				    //$("div.seat").eq(0).addClass("choice"); 
				    
				    // g_arr_seats
				    show_arr_seats();   // show_arr_seats() : g_arr_seats 배열을 토대로 오른편 패널에 좌석 번호 그림!
				    setup_nextpage_btn();  // 버튼 클릭에 따라, '다음' 버튼 활성화 여부 처리.
				}		
			});
			
			
			
			/* 상영시간표 태그 버튼 */
			 $(".now").on("click",function(){
				 $(".other").toggleClass("on");
				 $(".now").toggleClass("on");
				 $(".arr").toggleClass("on");
			 });
			
		});

	</script>
</head>
<body>
	<!-- header -->
	<header id="header" class="main-header no-bg" style="height:92px;">
		<div class="ci">
		<a href="index.jsp" title="내가박스 메인으로 가기"></a>
		</div>
		<div class="util-area">
			<div class="left-link">
				<a href="#" title="VIP LOUNGE">VIP LOUNGE</a>
				<a href="#" title="맴버십">맴버십</a>
				<a href="centerhome.jsp" title="고객센터">고객센터</a>
			</div>
			<div class="right-link">
				<%if(userloginId == null) { %>
				<a href="#" title="로그인" id="loginBox">로그인</a>
				<%} else { %>
				<a href="logout.jsp" title="로그아웃" id="loginBox">로그아웃</a>
				<% } %> 
				<%if (userloginId == null) { %>
				<a href="Controller?command=sendEmail" title="회원가입">회원가입</a>
				<%} else { %>
				<!-- <a href="#" title="알림">알림</a> -->
				<% } %>
				<a href="Controller?command=fastRev.jsp" title="빠른예매">빠른예매</a>
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
					<a href="Controller?command=fastRev.jsp" class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=fastRev.jsp" title="빠른예매">빠른예매</a></li>
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
					<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
					<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
					<li><a href="javascript:void(0)" title="영화제">영화제</a></li>
					<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
				</ul>
			</div>
			<div class="list position-2">
				<p class="tit-depth">예매</p>
				<ul class="list-depth">
					<li><a href="Controller?command=fastRev.jsp" title="빠른예매">빠른예매</a></li>
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
					<li><a href="javascript:void(0)" title="기프트카드">기프트카드</a></li>
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
				<%if(userloginId == null) { %>
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
					빠른 예매
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
	<div id='inner-wrap'>
		<div id='quick-rev'>
			<h2>빠른예매</h2>
			<div id='seat-sum-selection'>
				<div class='tit-util'>
					<h3 style='display: inline; font-weight: 400; font-size: 17px;'>관람인원선택</h3>
					<div style='float: right;'>
						<button class='normal-button initial'>
							<img src='./image/ico-reset-small.png'>초기화
						</button>
					</div>
					<div style='clear:both;'></div>
				</div>
				

				<div id='seat-area'>
					<div id='seat-count'>
						<script> 
						 for(var i=0;i<=2;i++){ 
							 var peopleType;	
						     var teenCheck = 19;
							 if(i==0) peopleType="성인";
							 if(i==1){peopleType="청소년";} 
							 if(i==1 && teenCheck == "<%=tmpRating%>"){continue;}
							 if(i==2) peopleType="우대";
							 
							 str = "<div class='cell'>"
								 +		"<span style='margin-left: 20px;'>"+peopleType+"</span>"
								 +		"<div class='count'>"
								 +			"<button class='minus'>-</button>"
								 +			"<button class='show-number' id='show-number"+(i+1)+"'>0</button>"
								 +			"<button class='plus'>+</button>"
								 + 		"</div>"
								 + "</div>";
							 document.write(str);	 
						 }
						
						 if(i==1 && teenCheck == "<%=tmpRating%>" ){
							 peopleType="청소년";
						 } 
						 
						</script>	
							
						<div style="clear:both;"></div>
					</div>
					<div id='seat-layout' style="height:450px;">
						<div class="seat-count-before">관람인원을 선택하십시요</div>
						
						<div style='padding: 40px 0;'>
							<img src='./image/img-theater-screen.png'>
								
<%
for(ExitDoorVO vo : listExitDoorVO){ 
	String str = "<img src='./image/img-door-"+vo.getDirection()+".png' style='position:absolute; left:"+vo.getX_left()+"; top:"+vo.getY_top()+"; width:16px; height: 16px;'>";
%>
	<%=str%>
<%
}
%>				
		<%-- <%
		ArrayList<String> listPrintStr = new ArrayList<String>();
		listPrintStr.add("<div style='position:relative;'>");
	
		String[] arrSeats = new String[listSeatArrInfo.size()];
		int size = 0;							
		for(String temp : listSeatArrInfo ){
			arrSeats[size++] = temp;
		}	
		%>
								
		<!-- 좌석 정보를 뿌리는 코드                                                                                               ㅡ-->
		<%	
		for(int i=0; i<arrSeats.length; i++) {
			//System.out.print((char)('A'+i) + " - ");
			//System.out.println(arrSeats[i]);								
			
			int alphabetLeft = 107; 
			int alphabetTop = 20*i + 11; 
			listPrintStr.add("<div col=" + (char)('A'+i) + ">");
			listPrintStr.add("<button type='button' class='btn-seat-row' style'position:absolute; top:"+(aTop+20*i)+"px; left:"+(aLeft)+"px;'>"+(char)('A'+i)+"</button>");
					
			String[] arrRowSeats = arrSeats[i].split(",");
			int left = aLeft + 48; // 219;   // 20씩 증가.
			
			for(int j=0; j<=arrRowSeats.length-1; j++) {
				String strHandi = arrRowSeats[j].startsWith("h") ? "handicap" : "";
				String strCorona = arrRowSeats[j].startsWith("x") ? "corona" : "";
				if(strHandi.equals("handicap")) {
					arrRowSeats[j] = arrRowSeats[j].substring(1);
				}
				if(strCorona.equals("corona")){
					arrRowSeats[j] = " ";
				}
				String seatNumber = ((char)('A'+i)) + "" + arrRowSeats[j]; 
				if(hsetReserved.contains(seatNumber)) {
					listPrintStr.add("<button type='button' class='btn-seat reserved' style='position:absolute; left:" + (left) + "px; top:" + (aTop+20*i) + "px; '>");
					listPrintStr.add("<span class='num'></span>");
					listPrintStr.add("</button>");
		
				} else if(!arrRowSeats[j].equals("") && !arrRowSeats[j].equals("n")) { //질문. n이 뜻이지?/
					/* System.out.println("공석아님 : ." + arrRowSeats[j] + "."); */
					listPrintStr.add("<button type='button' class='btn-seat "+strHandi + " " + strCorona + "' style='position:absolute; left:" + left + "px; top:" + (aTop+20*i) + "px;'>");
					listPrintStr.add("<span class='num'>" + arrRowSeats[j] + "</span>");
					listPrintStr.add("</button>");
			
				} //여기까지, (옆으로 20px씩 이동하면서) 1줄을 설치
				left += 20;
			}
			listPrintStr.add("</div>");
			%>
		<%
		}
		%> --%>
		<%
			for(String s : listPrintStr) {
		%>						
			<%=s %>
		<%
			}
		%> 
							</div>

						</div>
					</div>
				</div>

			</div>
		</div>

		<div id='seat-result'>
			<div id='wrap'>
				<div id='title-area'>
					<img id='rate' src='./image/txt-age-small-<%=tmpRating%>.png'> <!--text를 어떻게 이미지 바꿀까??  -->
					<span id='movie-title'><%=movie_name%></span>  
					<span id='movie-type'><%=show_type%></span>
				</div>
				<div style='clear:both;'></div>
				<div id='info-area'>
					<div style='margin-top:10px; float:left;'>
						<span><%=theater_name%></span>
						<span style='display:block;'><%=theater_showroom_name%></span>
					</div>
					<div style='clear:both'></div>
					<div class='date'>
						<span><%=fullDate%></span>
						<em></em>
					</div>

					<div id='poster'>
						<img style='width:70px; height:100px;' src='./movie_photo/<%=moviePosterJpgs.get(0)%>'/>
					</div>
					
					<!-- 시간표 태그 출력 -->
					<div id="time-selector">
						<button class="now"><%=start_time_HM %>~<%=end_time_HM %>
							<i class="arr"></i>
						</button>
						<ul class="other ">
						<%      
							for(MovieEndTime list : movieEndTimeList){
							    String str = "<li><button type='button' class='btn '>"+list.getTime()+"~"+list.getEndTime()+"</button></li>";
						%>
						
						<%=str %>
							
						<%	} %>	
						</ul>
					</div>
					<div style='clear:both'></div>
				</div>

				<div id='choice-seat-area'>
					<div id='seat-type'>
						<div>
							<img style='width:14px; height:14px;' src='./image/bg-seat-condition-choice.png'>
							<span>선택</span>
						</div>
						<div>
							<img src='./image/bg-seat-condition-finish-s.png'>
							<span>예매완료</span>
						</div>
						<div>
							<img src='./image/bg-seat-condition-impossible-s.png'>
							<span>선택불가</span>
						</div>
						<div>
							<img src='./image/bg-seat-condition-corona.png'>
							<span>띄어앉기석</span>
						</div>
						<div>
							<img src='./image/bg-seat-condition-common-s.png'>
							<span>일반</span>
						</div>
						<div>
							<img src='./image/bg-seat-condition-disabled-s.png'>
							<span>장애인석</span>
						</div>
					</div>
					<div id='seat-num'>
						<span style='position: relative; bottom: 26px; left: 17px;'>선택좌석</span>
						<div id='my-seat'>
						
							<div class="seat ">-</div>  <!--보라색  -->
							<div class='seat '>-</div>
							<div style='clear:both'></div>
							
							<div class='seat '>-</div>
							<div class='seat '>-</div>
							<div style='clear:both'></div>
							
							<div class='seat '>-</div>
							<div class='seat '>-</div>
							<div style='clear:both'></div>
							
							<div class='seat '>-</div>
							<div class='seat '>-</div>
							<div style='clear:both'></div>
						</div>
					</div>
					<div style="clear:both;"></div>

				</div>
			
				<div id='pay-area'> 
					 <div id='people-count'>
						<span>성인<em></em></span> 
						<span>청소년<em></em></span> 
						<span>우대<em></em></span> 
					</div> 
					<div class="pay">
						<p class="tit">최종결제금액</p>
						<div id='money'>
							<span>원</span>
							<em>0</em>
						</div> 
					</div>	
				</div>
			</div>
			<div style="clear:both"></div>
			<div id='btn-group'>
				<a href='#' title='이전' id='before-button'>이전</a>
				<a href='javascript:on_click_next()' title='다음' id='after-button'>다음</a>
			</div>
		</div>

	</div>
	
	<!--inner-wrap-->

		<section id="layer_age_alert_all" class="modal-layer" style="z-index: 900">
		<div class="wrap" style="width: 750px; height: 350px;">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con">

				<div class="alert-age-layer ageall">
					<div class="age-box age-all">
						<div class="left">
							<p class="circle">All</p>
						</div>
						<div class="right">
							<p class="tit">전체관람가</p>
							<p class="txt">
							<p>특별방역대책으로 방역패스 영화관 의무적용되어<br>12월 6일부터 전 상영관이 [백신패스관]으로 운영됩니다<br><strong>
									<font color="red">※접종완료자만 입장가능※(접종증빙서류 필참)</font><br>- 띄어앉기 적용 / 상영관내 물,음료만 취식가능
								</strong><br>* 접종완료기준 : 얀센 1차 접종, 그외 2차 접종 후 14일 경과자<br>* PCR검사 음성자(48시간), 만18세 이하,
								완치자, 의학적 접종 불가자의 경우 예외적으로 허용(단, 관련증빙서류 지참시)<br><strong>
									<font color="orange">*만 18세 미만의 경우 접종유무에 관계없이 이용가능</font>
								</strong></p>
							</p>
						</div>
					</div>
				</div>


			</div>
			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">확인</button>
			</div>
			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
	</section>




	<section id="layer_age_alert_12" class="modal-layer" style="z-index: 900">
		<div class="wrap" style="width: 750px; height: 350px; ">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con">

				<!-- 12세이용가 	<div class="alert-age-layer age12   ">에서 on으로 조정 -->
				<div class="alert-age-layer age12">
					<div class="age-box age-12">
						<div class="left">
							<p class="circle">12</p>
						</div>
						<div class="right">
							<p class="tit">12세이상관람가</p>
							<p class="txt">
							<p>만 12 세 미만의 고객님은(영,유아 포함) 반드시 성인 보호자의 동반하에 관람이 가능합니다.(확인불가 시 입장제한)<br><br>특별방역대책으로 방역패스
								영화관 의무적용되어<br>12월 6일부터 전 상영관이 [백신패스관]으로 운영됩니다<br><strong>
									<font color="red">※접종완료자만 입장가능※(접종증빙서류 필참)</font><br>- 띄어앉기 적용 / 상영관내 물,음료만 취식가능
								</strong><br>* 접종완료기준 : 얀센 1차 접종, 그외 2차 접종 후 14일 경과자<br>* PCR검사 음성자(48시간), 만18세 이하, 완치자,
								의학적 접종 불가자의 경우 예외적으로 허용(단, 관련증빙서류 지참시)<br><strong>
									<font color="orange">*만 18세 미만의 경우 접종유무에 관계없이 이용가능</font>
								</strong></p>
							</p>
						</div>
					</div>
				</div>


			</div>
			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">확인</button>
			</div>
			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
	</section>




	<section id="layer_age_alert_15" class="modal-layer" style="z-index: 900">
		<div class="wrap" style="width: 750px; height: 350px;">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con">


				<div class="alert-age-layer age15  ">
					<div class="age-box age-15">
						<div class="left">
							<p class="circle">15</p>
						</div>
						<div class="right">
							<p class="tit">15세이상관람가</p>
							<p class="txt">
							<p>만 15 세 미만의 고객님은(영,유아 포함) 반드시 성인 보호자의 동반하에 관람이 가능합니다.(확인 불가 시 입장제한)<br><br>특별방역대책으로 방역패스
								영화관 의무적용되어<br>12월 6일부터 전 상영관이 [백신패스관]으로 운영됩니다<br><strong>
									<font color="red">※접종완료자만 입장가능※(접종증빙서류 필참)</font><br>- 띄어앉기 적용 / 상영관내 물,음료만 취식가능
								</strong><br>* 접종완료기준 : 얀센 1차 접종, 그외 2차 접종 후 14일 경과자<br>* PCR검사 음성자(48시간), 만18세 이하, 완치자,
								의학적 접종 불가자의 경우 예외적으로 허용(단, 관련증빙서류 지참시)<br><strong>
									<font color="orange">*만 18세 미만의 경우 접종유무에 관계없이 이용가능</font>
								</strong></p>
							</p>
						</div>
					</div>
				</div>


			</div>
			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">확인</button>
			</div>
			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
	</section>




	<section id="layer_age_alert_19" class="modal-layer" style="z-index: 900"><a href="" class="focus">레이어로 포커스 이동
			됨</a>
		<div class="wrap" style="width: 750px; height: 350px;">
			<header class="layer-header">
				<h3 class="tit">알림</h3>
			</header>
			<div class="layer-con">


				<div class="alert-age-layer age19  ">
					<div class="age-box age-19">
						<div class="left">
							<p class="circle">19</p>
						</div>
						<div class="right">
							<p class="tit">청소년관람불가</p>
							<p class="txt">
							<p><b>입장 시, 신분증을 반드시 지참해주세요!</b><br>만 18세 미만의 고객님은(영,유아포함) 보호자를 동반하여도 관람이 불가하며, 만18세 이상이라도
								고등학교 재학중인 고객님은 관람이 불가합니다<br><br>특별방역대책으로 방역패스 영화관 의무적용되어<br>12월 6일부터 전 상영관이 [백신패스관]으로
								운영됩니다<br><strong>
									<font color="red">※접종완료자만 입장가능※(접종증빙서류 필참)</font><br>- 띄어앉기 적용 / 상영관내 물,음료만 취식가능
								</strong><br>* 접종완료기준 : 얀센 1차 접종, 그외 2차 접종 후 14일 경과자<br>* PCR검사 음성자(48시간), 만18세 이하, 완치자,
								의학적 접종 불가자의 경우 예외적으로 허용(단, 관련증빙서류 지참시)<br><strong>
									<font color="orange">*만 18세 미만의 경우 접종유무에 관계없이 이용가능</font>
								</strong></p>
							</p>
						</div>
					</div>
				</div>

			</div>
			<div class="btn-group-fixed">
				<button type="button" class="button purple close-layer">확인</button>
			</div>
			<button type="button" class="btn-modal-close">레이어 닫기</button>
		</div>
	</section>


	<!--결제 완료 팝업창  -->
	<div class="alert-popup-background ">
		<section class="alert-popup">
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">알림</h3>
				</header>
				<div class="layer-con" style="height:200px">
					<p class="txt-common">결제가 완료되었습니다.</p>
					<div class="btn-group">
						<button type="button" class="button lyclose" style="display: none;"></button>
						<button type="button" class="button purple confirm">확인</button>
					</div>
				</div>
				<button type="button" class="btn-layer-close">레이어 닫기</button>
			</div>
		</section>
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