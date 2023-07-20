<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main Page</title>

<!-- BootStrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Google Icon -->
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />
<!-- SockJS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>

<link href="/css/header.css" rel="stylesheet">
<link href="/css/mainPage.css" rel="stylesheet">

</head>

<body>
	<!-- 네비바 -->
	<nav class="nav_navbar">
		<div style="display: flex; justify-content: center; align-items: center;">
			<!-- 로고 -->
			<a href="/"><img id="logo" alt="no image" src="/images/logo.png"></a>
			<!-- 지역 -->
			<div class="dropdown" style="margin-left: 15px;">
				<button style="background: orangered; border:none;" class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">${selectedGu}</button>
				<ul class="dropdown-menu">
					<a style="color:black" href="/전체">
						<li class="div_gu_item dropdown-item" style="width: 100%; font-size: 18px;">
							전체
						</li>
					</a>
					<c:forEach items="${guList}" var="gu">
						<a style="color:black" href="/${gu}">
							<li class="div_gu_item dropdown-item" style="width: 100%; font-size: 18px;">
							${gu}
							</li>
						</a>
					</c:forEach>
				</ul>
				<ul class="dropdown-menu">
					<a style="color:black" href="/전체">
						<li class="div_gu_item dropdown-item" style="width: 100%; font-size: 18px;">
							전체
						</li>
					</a>
					<c:forEach items="${guList}" var="gu">
						<a style="color:black" href="/${gu}">
							<li class="div_gu_item dropdown-item" style="width: 100%; font-size: 18px;">
							${gu}
							</li>
						</a>
					</c:forEach>
				</ul>
			</div>
		</div>
			<!-- 검색창 -->
			<div>
				<form action="/product/search" method="get">
					<input id="input_search_post" type="text" name="q" placeholder="상품명 입력" autocomplete="false"/>
					<input type="hidden" name="gu"value="${selectedGu}"/>
				</form>
			</div>
	
		<!-- 아이콘 -->
		<div class="div_nav_icons">
			<c:choose>
				<c:when test="${!empty sessionScope.userId}">
					<div>
						<span class="material-symbols-outlined"> chat </span>
						<a href ="/users/chat" 
						onclick="window.open(this.href, '_blank', 'width=623, height=460, location=no, menubar=no'); return false;">
						<b>채팅</b></a>
					</div>
					<div>
						<span class="material-symbols-outlined"> local_mall </span>
						<b><a href="/product/upload?gu=${selectedGu}">판매하기</a></b> 
					</div>
					<div>
						<span id="logout"><b><a href="/users/logout">로그아웃</a></b></span> <span
							class="material-symbols-outlined">logout</span>
					</div>
					<div class="box" style="background: #BDBDBD;">
						<a href="/users/${member.id}?gu=${selectedGu}">
							<img class="profile" src="/profileImages/${member.profileImage}">
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div>
						<span class="login"><b><a href="/users/login">로그인</a></b></span> <span
							class="material-symbols-outlined">login</span>
					</div>
				</c:otherwise>
			</c:choose>			
		</div>
	</nav>

	<!-- body -->
	<div class="div_body">
		<!-- 뒷 배경 -->
		<div class="div_bg">
			<!-- <img class="" alt="no image"
				src="https://static.wixstatic.com/media/fc7570_cfaf1cf72d3948d0b8c28290ba288269~mv2_d_3521_1344_s_2.jpg/v1/fill/w_1241,h_474,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/fc7570_cfaf1cf72d3948d0b8c28290ba288269~mv2_d_3521_1344_s_2.jpg">-->
			<img src="https://media.bunjang.co.kr/images/nocrop/1008193264_w1197.jpg">
		</div>

		<!-- <div class="div_name">세상의 사람과 물건이 새롭게 만나는 곳</div> -->

		<div class="div_main">
			<!-- 카테고리 -->
			<div class="div_category">
				<!-- 상품 카테고리 -->
				<div class="div_category_item">
					<span class="material-symbols-outlined">
						local_fire_department </span>
					<div>인기상품</div>
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=clothing">
						<span class="material-symbols-outlined"> checkroom</span>
						<div>의류</div>
					</a>
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=accessory">
						<span class="material-symbols-outlined"> business_center </span>
						<div>잡화</div>
					</a>	
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=appliances">
						<span class="material-symbols-outlined"> local_laundry_service </span>
						<div>생활 가전</div>
					</a>	
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=furniture">
						<span class="material-symbols-outlined"> light </span>
						<div>가구/인테리어</div>
					</a>
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=hobby">
						<span class="material-symbols-outlined"> stadia_controller </span>
						<div>게임/취미</div>
					</a>
				</div>
				<div class="div_category_item">
					<a href="/product/search?gu=${selectedGu}&c=book">
						<span class="material-symbols-outlined"> auto_stories </span>
						<div>도서</div>
					</a>
				</div>
				<div class="div_category_item">
				
						<span class="material-symbols-outlined"> pedal_bike </span>
						<div>스포츠/레져</div>
					
				</div>
				<div class="div_category_item">
				
						<span class="material-symbols-outlined"> pets </span>
						<div>반려동물 제품</div>
						
				</div>
				<div class="div_category_item">
					<span class="material-symbols-outlined"> volunteer_activism </span>
					<div>나눔</div>
				</div>

			</div>
			<div class="div_items">
				<!-- 상품 -->
			<jsp:useBean id="now" class="java.util.Date"/>
			<fmt:parseNumber var="nowFmtDay" value="${now.time/1000/60/60/24}" integerOnly="true"/>
			<fmt:parseNumber var="nowFmtHour" value="${now.time/1000/60/60}" integerOnly="true"/>
			<c:forEach var="product" items="${productList}">
				
				<a class="item" href="/product/${product.idx}?gu=${selectedGu}">
					<!-- 상품 이미지 -->
					<img alt="no_image" src="/uploadImages/${fn:split(product.filenames,' ')[0]}">
					<div style="width: 90%">
						<div style="font-size: 18px;">${product.title}</div>
						<div style="color: gray; font-size: 13px;">
							<span>${product.gu}</span><br>
							
							<fmt:parseNumber var="productFmtDay" value="${product.writeDate.time/1000/60/60/24}" integerOnly="true"/>
							<fmt:parseNumber var="productFmtHour" value="${product.writeDate.time/1000/60/60}" integerOnly="true"/>

							<c:choose>
								<c:when test="${(now.time - product.writeDate.time)/1000/60 < 1}">
									<span>방금</span>
								</c:when>
								<c:when test="${nowFmtHour - productFmtHour == 0}">
									<fmt:parseNumber var="viewMinute" value="${(now.time - product.writeDate.time)/1000/60}" integerOnly="true"/>
									<span>${viewMinute} </span> 분 전
								</c:when>
								<c:when test="${nowFmtDay - productFmtDay == 0}">
									<span>${nowFmtHour - productFmtHour}</span> 시간 전
								</c:when>
								<c:otherwise>
									<span>${nowFmtDay - productFmtDay}</span> 일 전
								</c:otherwise>
							</c:choose>
						</div>
						<div style="font-size: 18px;">
							<fmt:formatNumber value="${product.price}" pattern="###,###"/> 원
						</div>
					</div>
				</a>
			</c:forEach>
			</div>
		</div>
	</div>

</body>

</html>