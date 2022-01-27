
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEET PLAY SHARE, 네가박스</title>
<link rel="stylesheet" href="./css/information.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
	b=0;
			
	function validate() {
		 var re = /((?=.{8,})(?=.*[0-9])(?=.*[a-zA-Z]).*$)/;
		 var re2 = /((?=.{8,})(?=.*[~!@#$%^&*+=-]).*$)/;
		 var id = document.getElementById("id");
		 if(!re.test(id.value)) {		 
			 document.querySelector(".alert").style.display = "block";
			 return false;
		 }
		 else if(re2.test(id.value)) {
			 document.querySelector(".alert").style.display = "block";
			 return false;
		 }
		 else {
			 document.querySelector(".alert").style.display = "none";
			 return true;
		 }
	}
			
	function validate2() {
		 pw = $("#pw").val();
		 var num = pw.search(/[0-9]/g);
		 var eng = pw.search(/[a-z]/ig);
		 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		 if(pw.length < 10 || pw.length > 16){
			 document.querySelector(".alert2").style.display = "block";				 
			 return false;
		 }else if(pw.search(/\s/) != -1){
			 document.querySelector(".alert2").style.display = "block";
		     return false;
		 }else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
			 document.querySelector(".alert2").style.display = "block";
		     return false;
		 }else {
			 document.querySelector(".alert2").style.display = "none";
			 return true; 
		 }

	}
			
	function confirm2() {
		var pw2 = document.getElementById("confirm");
		if(pw2.value != pw) {
			document.querySelector(".alert3").style.display = "block";
			return false;
		}
		else {
			document.querySelector(".alert3").style.display = "none";
			return true;
		}
	}
			
	function validate3() {
		var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
		var email = document.getElementById("email");
		if(!emailRegExp.test(email.value)) {
			document.querySelector(".alert4").style.display = "block";
		}else {
			document.querySelector(".alert4").style.display = "none";
			
		}
	}
			
	function validate4() {
		var phoneregExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = document.getElementById("phone");
		if(!phoneregExp.test(phone.value)) {
			document.querySelector(".alert5").style.display = "block";
		}
		else {
			document.querySelector(".alert5").style.display = "none";
		}
	}
			
	function insert() {
		a = 0;
		var name = document.getElementById("name");
		if(name.value == "") {
			a += 0;
		}else {a++;}
		var birth = document.getElementById("birth");
		if(birth.value == "") {
			a += 0;
		}else {a++;}
		var phoneregExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = document.getElementById("phone");
		if(!phoneregExp.test(phone.value)) {
			document.querySelector(".alert5").style.display = "block";
		}else {
			document.querySelector(".alert5").style.display = "none";
			a++;
		}
				
	    var re = /((?=.{8,})(?=.*[0-9])(?=.*[a-zA-Z]).*$)/;
	    var re2 = /((?=.{8,})(?=.*[~!@#$%^&*+=-]).*$)/;
	    var id = document.getElementById("id");
		 if(!re.test(id.value)) {		 
			 document.querySelector(".alert").style.display = "block";
	     }else if(re2.test(id.value)) {
			 document.querySelector(".alert").style.display = "block";
		 }else if(re.test(id.value)) {
			 document.querySelector(".alert").style.display = "none";
			 a++;
		 }
		 pw = $("#pw").val();
		 var num = pw.search(/[0-9]/g);
		 var eng = pw.search(/[a-z]/ig);
		 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		 if(pw.length < 10 || pw.length > 16){
			 document.querySelector(".alert2").style.display = "block";	
		 }else if(pw.search(/\s/) != -1){
			 document.querySelector(".alert2").style.display = "block";
		 }else if( (num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0) ){
			 document.querySelector(".alert2").style.display = "block";
		 }else {
			 document.querySelector(".alert2").style.display = "none";
			 a++;
		 }
			 
		 var pw2 = document.getElementById("confirm");
	 	 if(pw2.value != pw) {
				document.querySelector(".alert3").style.display = "block";
	  	 }
		 else {
				document.querySelector(".alert3").style.display = "none";
				a++;
	   	}
		var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
		var email = document.getElementById("email");
		if(!emailRegExp.test(email.value)) {
				document.querySelector(".alert4").style.display = "block";
		}else {
				document.querySelector(".alert4").style.display = "none";
				a++;
		}
		
		if(a == 7 && b == 1) {
			alert('회원가입이 완료되었습니다');
			 location.href = "main_page.jsp";
			return true;
		}else if(b == 0) {
			$(".alert-popup-background4").addClass("on4");	
			$(function(){
				$(".button5.purple5").on("click",function(){
					$(".alert-popup-background4").removeClass("on4");
				})
				$("#close4").click(function(){
  						$(".alert-popup-background4").removeClass("on4");
   				})
			})
			return false;
		}else if(a != 7 && b == 1){
			$(".alert-popup-background").addClass("on");	
			$(function(){
				$(".button2.purple").on("click",function(){
					$(".alert-popup-background").removeClass("on");
				})
					$("#close").click(function(){
   						$(".alert-popup-background").removeClass("on");
   					})
			})
			return false;
		}
	}
		
	$(function(){
		$("#doubleCheck").click(function(){
				let userID = $('#id').val();
				$.ajax({ 
					url: "Controller?command=idCheck",
					type: "post",
					data: {userID: userID},
					dataType: 'json',
					success: function(data) {
							if(data.result >= 1) {
								$(".alert-popup-background2").addClass("on2");	 //alert-popup-background2 중복되었습니다.
									
								$(".button3.purple3.confirm").click(function(){
									$(".alert-popup-background2").removeClass("on2");
								})
								$("#close2").click(function(){
						   			$(".alert-popup-background2").removeClass("on2");
						   		})
								b = 0;
							}
										
							if(data.result == 0) {
								$(".alert-popup-background3").addClass("on3"); //alert-popup-background3: 중복되지 않았습니다.
								$(".button4.purple4").click(function(){
									$(".alert-popup-background3").removeClass("on3");
						  	 	}) 
						   		$("#close3").click(function(){
						   			$(".alert-popup-background3").removeClass("on3");
						   		})
						  	}
							b = 1;
					}
				
				});
			})
		
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth() + 1; //January is 0!
			var yyyy = today.getFullYear();

			if (dd < 10) { dd = '0' + dd; }
			if (mm < 10) { mm = '0' + mm; } 
			    
			today = yyyy + '-' + mm + '-' + dd;
			document.getElementById("birth").setAttribute("max", today);

			$('#radio1').click(function(){
				var checked = $('#radio1').is(':checked');
				if(checked) {
					$('#checkbox1').prop('checked', true);
					$('#checkbox2').prop('checked', true);
					$('#checkbox3').prop('checked', true);
				}
			})
			$('#radio2').click(function(){
				var checked = $('#radio2').is(':checked');
				if(checked) {
					$('#checkbox1').prop('checked', false);
					$('#checkbox2').prop('checked', false);
					$('#checkbox3').prop('checked', false);
				}
			})
			$('#checkbox1, #checkbox2, #checkbox3').change(function(){
				var checked = $('#checkbox1').is(':checked');					
				var checked2 = $('#checkbox2').is(':checked');
				var checked3 = $('#checkbox3').is(':checked');
				
				if(checked || checked2 || checked3) {
					$('#radio1').prop('checked', true);
				}
			})
			$('#checkbox1, #checkbox2, #checkbox3').change(function(){
				var checked = $('#checkbox1').is(':checked');					
				var checked2 = $('#checkbox2').is(':checked');
				var checked3 = $('#checkbox3').is(':checked');
				
				if(!checked && !checked2 && !checked3) {
					$('#radio2').prop('checked', true);
				}
			})	
	})
			
				
</script>
</head>
<body>
	<div class="container">
		<div class="ci">
			<a href="main_page.jsp" class="logo">				
			</a>
		</div>
		<ol>
			<li style="margin-left:0">
				<p class="step">
				<span>STEP1.</span>
				<span>본인인증</span>
			    </p>
			</li>
			<li>
				<p class="step">
				<span>STEP2.약관동의</span>
				</p>
			</li>
			<li>
				<p class="stepon">
				<span>STEP3.정보입력</span>
				</p>
			</li>
			<li>
				<p class="step">
				<span>STEP4.가입완료</span>
				</p>
			</li>
		</ol>
		<div class="page-info-txt">
			<span style="display:block; letter-spacing:-2px;">회원정보를 입력해주세요.</span>
		</div>
		<form action="Controller?command=register" method="post" accept-charset="utf-8">
			<div class="table-wrap">
				<table>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>이름</b></td>
						<td><input type="text" name="name" id="name" class="input"></td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>생년월일</b></td>
						<td><input type="date" name="birth" id="birth" class="input" max=""></td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>휴대폰 번호</b></td>
						<td style="font-weight:400"><input type="text" placeholder="'-'없이 입력하세요." name="phone" id="phone" class="input" onkeyup="validate4(this);">
						<div id="error5" class="alert5">올바른 형식으로 입력해주세요.</div>
						</td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>아이디</b></td>
						<td style="font-weight:400">
							<input maxlength="12" type="text" placeholder="영문,숫자 조합(8~12자)" name="id" id="id" class="input" onkeyup="validate(this);">
							<button type="button" class="button" id="doubleCheck">중복확인</button>
							<div id="error" class="alert">아이디는 영문,숫자 조합 8자리 이상 12자리 이하 입니다.</div>
						</td>
						
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>비밀번호</b></td>
						<td style="font-weight:400">
							<input maxlength="16" type="password" name="password" id="pw" placeholder="영문,숫자,특수기호 중 2가지 이상 조합" class="input" onkeyup="validate2(this);">
							<div id="error2" class="alert2">비밀번호는 영문,숫자,특수기호 중 2가지 이상 조합하여 10자리 이상 16자리 이하 입니다.</div>
						</td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>비밀번호 확인</b></td>
						<td style="font-weight:400">
							<input maxlength="16" type="password" name="confirm" id="confirm" placeholder="영문,숫자,특수기호 중 2가지 이상 조합" class="input" onkeyup="confirm2(this);">
							<div id="error3" class="alert3">비밀번호와 비밀번호 확인의 입력값이 일치하지 않습니다.</div>
						</td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>이메일 주소</b></td>
						<td style="font-weight:400">
							<input maxlength="50" type="text" name="email" id="email" placeholder="이메일주소를 입력해주세요" class="input" onkeyup="validate3(this);">
							<div id="error4" class="alert4">올바른 이메일 형식으로 입력해주세요.</div>
						</td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>무인발권기<br>기능 설정</b></td>
						<td style="font-weight:400"><input type="radio" style="height:16px; width:16px; margin:0;" name="issueing" checked><span style="position: relative; bottom: 2px; left: 2px;">사용</span>
						<input type="radio" style="height:16px; width:16px; margin:0;" name="issueing"><span style="position: relative; bottom: 2px; left: 2px;">사용안함</span><span style="letter-spacing:-2px">&nbsp; &nbsp;※ '생년월일 + 휴대폰번호로' 티켓출력</span>
						</td>
					</tr>
					<tr>
						<td style="background: #f7f8f9; width:130px"><b>나만의 메가박스</b></td>
						<td style="font-weight:400"><span style="letter-spacing:-2px">자주 방문하는 메가박스를 등록해 주세요!</span>
							<a href="#">설정</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="main">
				<div class="tit">
					<p style="margin:0">마케팅 활용을 위한 개인정보 수집 이용 안내(선택)</p>
				</div>
				<div class="cont">
					<dl>
						<dt>수집목적</dt>
						<dd>고객맞춤형 상품 및 서비스 추천, 당사 신규 상품/서비스 안내 및 권유, 사은/할인 행사 등 각종 이벤트 정보 등의 안내 및 권유</dd>
						<dt>수집항목</dt>
						<dd>이메일, 휴대폰번호, 주소, 생년월일, 선호영화관, 문자/이메일/앱푸쉬 정보수신동의여부, 서비스 이용기록, 포인트 적립 및 사용 정보, 접속로그</dd>
						<dt>보유기간</dt>
						<dd>회원 탈퇴 시 혹은 이용 목적 달성 시 까지</dd>
					</dl>
					<div class="radio-agree">
						<input type="radio" style="height:16px; width:16px; margin:0;" name="agree" id="radio1"><span style="position: relative; bottom: 2px; left: 2px;">동의 &nbsp; &nbsp;</span>
						<input type="radio" style="height:16px; width:16px; margin:0;" name="agree" id="radio2" checked="true"><span style="position: relative; bottom: 2px; left: 2px;">미동의</span>
					</div>
					<div class="mt30">
						<p>혜택 수신설정</p>
					</div>
					<div class="radio-agree">
						<input type="checkbox" id="checkbox1" style="height:16px; width:16px; margin:0;"><span style="position: relative; bottom: 2px; left: 2px;">알림 &nbsp; &nbsp;</span>
						<input type="checkbox" id="checkbox2" style="height:16px; width:16px; margin:0;"><span style="position: relative; bottom: 2px; left: 2px;">SMS &nbsp; &nbsp;</span>
						<input type="checkbox" id="checkbox3" style="height:16px; width:16px; margin:0;"><span style="position: relative; bottom: 2px; left: 2px;">이메일</span>
					</div>
					<p class="mt20">
						※ 이벤트, 신규 서비스, 할인 혜택 등의 소식을 전해 드립니다.<br>
						(소멸포인트 및 공지성 안내 또는 거래정보와 관련된 내용은 수신 동의 여부와 상관없이 발송됩니다.)
					</p>
				</div>
			</div>
			<div class="bottom">
				<input type="submit" id="submit" class="button1" value="회원가입" onclick="return insert();"/>
			</div>
		</form>
	</div>
	<div class="alert-popup-background">
		<section class="alert-popup">
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">알림</h3>
				</header>
				<div class="layer-con" style="height:200px">
					<p class="txt-common">올바른 값을 입력하세요.</p>
					<div class="btn-group">
						<button type="button" class="button2" style="display: none;"></button>
						<button type="button" class="button2 purple confirm">확인</button>
					</div>
				</div>
				<button type="button" id="close" class="btn-layer-close">레이어 닫기</button>
			</div>
		</section>
	</div>	
	<div class="alert-popup-background2 ">
		<section class="alert-popup2">
			<div class="wrap">
				<header class="layer-header2">
					<h3 class="tit2">알림</h3>
				</header>
				<div class="layer-con2" style="height:200px">
					<p class="txt-common2">중복되었습니다.</p>
					<div class="btn-group2">
						<button type="button" class="button3" style="display: none;"></button>
						<button type="button" class="button3 purple3 confirm">확인</button> <!-- 작업중 -->
					</div>
				</div>
				<button type="button" id="close2" class="btn-layer-close2">레이어 닫기</button>
			</div>
		</section>
	</div>	
	
	<div class="alert-popup-background3 ">
		<section class="alert-popup3">
			<div class="wrap">
				<header class="layer-header3">
					<h3 class="tit3">알림</h3>
				</header>
				<div class="layer-con3" style="height:200px">
					<p class="txt-common3">중복되지 않았습니다.</p>
					<div class="btn-group3">
						<button type="button" class="button4" style="display: none;"></button>
						<button type="button" class="button4 purple4 confirm">확인</button>
					</div>
				</div>
				<button type="button" id="close3" class="btn-layer-close3">레이어 닫기</button>
			</div>
		</section>
	</div>	
	
	<div class="alert-popup-background4 ">
		<section class="alert-popup4">
			<div class="wrap">
				<header class="layer-header4">
					<h3 class="tit4">알림</h3>
				</header>
				<div class="layer-con4" style="height:200px">
					<p class="txt-common4">중복확인을 눌러주세요.</p>
					<div class="btn-group4">
						<button type="button" class="button5" style="display: none;"></button>
						<button type="button" class="button5 purple5 confirm">확인</button>
					</div>
				</div>
				<button type="button" id="close4" class="btn-layer-close4">레이어 닫기</button>
			</div>
		</section>
	</div>	

	
</body>
</html>