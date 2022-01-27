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
var a = 0;
var b = 0;
function validate3() {
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	var email = document.getElementById("email2");
	if(!emailRegExp.test(email.value)) {
		document.querySelector(".alert4").style.display = "block";
		//return false;
		//alert4: 올바른 이메일....
	}
	else {
		document.querySelector(".alert4").style.display = "none";
		//return true;
		
	}
}
//post 이메일을 보내는 것
//네이버 이메일 주소의 인증
	$(function(){
		$("#certify").click(function(){         // 이메일 송신 버튼 클릭시.
			var email3 = $('#email2').val();
			var password3 = $('#pw2').val();
			$.ajax({
				url: "Controller?command=sendEmail",
				type: "post",
				data: {email4:email3, pw4:password3},
				dataType: 'json',
				success: function(data) {
					if(data.result == 1) {
						$(".alert-popup-background2").addClass("on2");	 //background2 메일이 보내졌습니다.
						$(".button3.purple3.confirm").click(function(){
							$(".alert-popup-background2").removeClass("on2");
						})
						a = 1;
					}	
					else { //alert-popup-background3는 메일송신 실패 팝업창
						$(".alert-popup-background3").addClass("on3");	 
						$(".button4.purple4.confirm").click(function(){
							$(".alert-popup-background3").removeClass("on3");
						})
						a = 0;
					}
					
				}
			})
			
		});
		
		//일치 비교
		//인증번호의 번호체크
		$('#certify2').click(function(){
			$.ajax({
				url: "Controller?command=checkEmailNumber",
				type: "get",
				data: {"email4":$('#email2').val()},
				dataType: 'json',
				success: function(data) {
					var num = data.result2;
					var num2 = $('#confirm').val();
					
					
					if(num == num2) {
						$(".alert-popup-background").addClass("on");	 //alert-popup-background는 "인증완료 되었습니다." 팝업창
					
						$(".button2.purple.confirm").click(function(){
							$(".alert-popup-background").removeClass("on");
						})
						b = 1;
					}
					else {
						$(".alert-popup-background4").addClass("on4");	 //불일치합니다.
						//현재, 값을 입력 한 후에, 초기화가 안되는 것 같다.
					/* 	$(".alert-popup-background2").toggleClass("on2") */
					
						$(".button5.purple5.confirm").click(function(){
							$(".alert-popup-background4").removeClass("on4");
						})
						b = 0;
					}
				},
				error: function(a,b,c) {
					alert("ERROR: " + a + b + c);
				}
			});
		});

		
	
		$('#submit').click(function(){
			if(a == 1 && b == 1) {
				$(location).attr("href", "agreement.jsp")

				return true;
			}
			else {
				$(".alert-popup-background5").addClass("on5");	 //background2 중복되었습니다. .alert-popup-background5 역할 일일히 주석달기
				//현재, 값을 입력 한 후에, 초기화가 안되는 것 같다.
			/* 	$(".alert-popup-background2").toggleClass("on2") */
			
				$(".button6.purple6.confirm").click(function(){
					$(".alert-popup-background5").removeClass("on5");
				})
				return false;
			}
		})
	});    // the end of the $(function)
	
</script>
<style>
	.container{
		box-sizing: border-box;
	    width: 710px;
	    min-height: 100%;
	    margin: 0 auto;
	    padding: 80px 100px;
	    background-color: #fff;
	    display: block;
	    height: 988px;
	}
</style>

</head>
<body>
	<div class="container">
		<div class="ci">
			<a href="main_page.jsp" class="logo">				
			</a>
		</div>
		<ol>
			<li style="margin-left:0">
				<p class="stepon">
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
				<p class="step">
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
			
			<span style="display:block; letter-spacing:-2px;">이메일 인증을 해주세요</span>
		</div>
		<div class="table-wrap">
		<form>
			<table>
				<tr>
					<td style="background: #f7f8f9; width:130px"><b>구글<br/> 이메일 주소</b></td>
					<td style="font-weight:400">
						<input maxlength="50" type="text" name="email2" id="email2" placeholder="이메일주소를 입력해주세요" class="input" onkeyup="validate3(this);">
						<button type="button" class="button" id="certify">인증</button>
						<div id="error4" class="alert4">올바른 이메일 형식으로 입력해주세요.</div>
					</td>
				</tr>
				<tr>
					<td style="background: #f7f8f9; width:130px"><b>인증번호</b></td>
					<td style="font-weight:400">
						<input maxlength="16" type="password" name="confirm" id="confirm" placeholder="인증번호를 입력해주세요" class="input">
						<button type="button" class="button" id="certify2">번호체크</button>
					</td>
				</tr>
			</table>
			</form>
			
		</div>
		<div class="bottom">
			<input type="button" id="submit" class="button1" value="인증완료"/>
		</div>
		
</div>
<div class="alert-popup-background2">
		<section class="alert-popup2">
			<div class="wrap">
				<header class="layer-header2">
					<h3 class="tit2">알림</h3>
				</header>
				<div class="layer-con2" style="height:200px">
					<p class="txt-common2">메일이 보내졌습니다.</p>
					<div class="btn-group2">
						<button type="button" class="button3" style="display: none;"></button>
						<button type="button" class="button3 purple3 confirm">확인</button> <!-- 작업중 -->
					</div>
				</div>
				<button type="button" class="btn-layer-close2">레이어 닫기</button>
			</div>
		</section>
	</div>
<div class="alert-popup-background3 ">
		<section class="alert-popup3"> <!--alert-popup-background3는 메일송신 실패 팝업창  -->
			<div class="wrap">
				<header class="layer-header3">
					<h3 class="tit3">알림</h3>
				</header>
				<div class="layer-con3" style="height:200px">
					<p class="txt-common3">메일 송신에 실패했습니다.</p>
					<div class="btn-group3">
						<button type="button" class="button4" style="display: none;"></button>
						<button type="button" class="button4 purple4 confirm">확인</button>
					</div>
				</div>
				<button type="button" class="btn-layer-close3">레이어 닫기</button>
			</div>
		</section>
	</div>	
	<div class="alert-popup-background">
		<section class="alert-popup">
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">알림</h3>
				</header>
				<div class="layer-con" style="height:200px">
					<p class="txt-common">인증완료 되었습니다.</p>
					<div class="btn-group">
						<button type="button" class="button2" style="display: none;"></button>
						<button type="button" class="button2 purple confirm">확인</button>
					</div>
				</div>
				<button type="button" class="btn-layer-close">레이어 닫기</button>
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
					<p class="txt-common4">인증번호가 불일치합니다.</p>
					<div class="btn-group4">
						<button type="button" class="button5" style="display: none;"></button>
						<button type="button" class="button5 purple5 confirm">확인</button>
					</div>
				</div>
				<button type="button" class="btn-layer-close4">레이어 닫기</button>
			</div>
		</section>
	</div>	
	<div class="alert-popup-background5 ">
		<section class="alert-popup5">
			<div class="wrap">
				<header class="layer-header5">
					<h3 class="tit5">알림</h3>
				</header>
				<div class="layer-con5" style="height:200px">
					<p class="txt-common5">이메일 인증을 모두 완료해주세요.</p>
					<div class="btn-group5">
						<button type="button" class="button6" style="display: none;"></button>
						<button type="button" class="button6 purple6 confirm">확인</button>
					</div>
				</div>
				<button type="button" class="btn-layer-close5">레이어 닫기</button>
			</div>
		</section>
	</div>	
</body>
</html>