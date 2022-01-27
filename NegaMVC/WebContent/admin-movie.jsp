<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script src="js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="./css/admin.css">
<script>
	$(function(){
		$(".menu-list").on("click",function(e){
			$(this).toggleClass("on");
			if($(this).has(e.target).length==0)
				$(".menu-list").not(this).removeClass("on");	
		})
	})
	/*.length는 선택한 요소의 개수를 구하는 속성입니다 */

</script>
</head>
<body>
	<div class="container">
		<div class="header">
			<a class="left" href="MainPage(Remake).jsp"><img src="./image/logo_nega_yg.png"></a>
			<h1>관리자 페이지</h1>
		</div>
		
			<div class="left nav">
			<ul>
				<li>
					<div class="menu-list">MEMBERVO(회원)</div>
				</li>			
				<li>
					<div class="menu-list on">MOVIE(영화)</div>
				</li>			
				<li>
					<div class="menu-list ">
							스틸컷
					</div>
				</li>			
				<li>
					<div class="menu-list ">
						SCREEN_INFO<br/>
						(영화 상영 시간표)
					</div>
				</li>			
				<li>
					<div class="menu-list ">
						공지사항(notice)
					</div>
				</li>			
				<li>
					<div class="menu-list ">
						스토어(store)
					</div>
				</li>			
			</ul>
		</div>
		</div>
		
		<div class="left contents">
			<form action="admin-movieP2.jsp" method="post" accept-charset="utf-8">
				<table>
				
						<tr>
							<td>
								1.MOIVE_CODE	
							</td>
							<td>
								 <input type="text" name="movie_code"/>
							</td>
						</tr>
						
						<tr>
							<td>
								2.MOVIE_NAME
							</td>
							<td>
								 <input type="text" name="movie_name"/>
							</td>
						</tr>

						<tr>
							<td>
								3.MOVIE_PHOTO(포스터))
							</td>
							<td>
								 <input type="text" name="movie_photo"/>
							</td>
						</tr>
						
						<tr>
							<td>
								4.DOLBY	(0/1로 입력) (해당시1, 아니면 0)
							</td>
							<td>
								 <input type="text" name="dolby"/>
							</td>
						</tr>
						
						<tr>
							<td>
								5.MX (0/1로 입력) (해당시1, 아니면 0)
							</td>
							<td>
								 <input type="text" name="mx"/>
							</td>
						</tr>
						
						
						<tr>
							<td>
								6.RATING(상영등급)
							</td>
							<td>
								 <input type="text" name="rating"/>
							</td>
						</tr>
						
						<tr>
							<td>
								7.OPENING_DAY(상영일) ex)2021/12/15
							</td>
							<td>
								 <input type="text" name="opening_day"/>
							</td>
						</tr>
					
						
						<tr>
							<td>
								8.TAG(해시태그)
							</td>
							<td>
								 <input type="text" name="tag"/>
							</td>
						</tr>
					
						
						<tr>
							<td>
								9.ENG_NAME(영어제목)
							</td>
							<td>
								 <input type="text" name="eng_name"/>
							</td>
						</tr>
					
						
						<tr>
							<td>
								10.MINI_TITLE(영화 소제목)
							</td>
							<td>
								 <textarea type="text" name="mini_title" rows="4"></textarea>
							</td>
						</tr>
					
						
						<tr>
							<td>
								11.PLOT(줄거리)
							</td>
							<td>
								 <textarea type="text" name="plot" rows="4"/></textarea>
							</td>
						</tr>
					
						<tr>
							<td>
								12.ALLTYPE(상영타입)
							</td>
							<td>
								 <input type="text" name="alltype"/>
							</td>
						</tr>
					
						<tr>
							<td>
								13.DIRECTOR(감독)
							</td>
							<td>
								 <input type="text" name="director"/>
							</td>
						</tr>
					
						<tr>
							<td>
								14.GENRE(장르)
							</td>
							<td>
								 <input type="text" name="genre"/>
							</td>
						</tr>
					
						<tr>
							<td>
								15.RUNNING_TIME(상영시간)  (정수로 입력할 것!)
							</td>
							<td>
								 <input type="text" name="running_time"/>
							</td>
						</tr>
					
						<tr>
							<td>
								16.CASTING(출연진)
							</td>
							<td>
								 <textarea type="text" name="casting" rows="4"/></textarea>
							</td>
						</tr>
					
						<tr>
							<td>
								17.TRAILER(트레일러 영상)
							</td>
							<td>
								 <input type="text" name="trailer"/>
							</td>
						</tr>
	
						<tr>
							<td>
								18.TRAILER_SUB(트레일러 자막)
							</td>
							<td>
								 <textarea type="text" name="trailer_sub" rows="4"></textarea>
							</td>
						</tr>
	
						 <tr>
							<td>
								19.STEALCUT(스틸컷 이미지 모음)<br/>
							</td>
							<td>
								 <input type="text" name="stealcut"/>
							</td>
						</tr> 
					
						
				</table>
						<input type="submit" value="작성완료"/>
			</form>
		
		
		</div>
		<div style="clear:both;"></div>
	</div>
</body>
</html>