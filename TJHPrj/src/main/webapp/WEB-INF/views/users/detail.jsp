<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<!-- Google Icon -->
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />

<link href="/css/header.css" rel="stylesheet">
<link href="/css/userDetail.css" rel="stylesheet">
</head>
<body>
	<!-- 네비바 -->
	<nav class="nav_navbar">
		<div
			style="display: flex; justify-content: center; align-items: center;">
			<!-- 로고 -->
			<a href="/"><img id="logo" alt="no image" src="/images/logo.png"></a>
			<!-- 지역 -->
			<div class="dropdown" style="margin-left: 15px;">
				<button style="background: orangered; border: none;"
					class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">${selectedGu}</button>
				<ul class="dropdown-menu">
					<a style="color: black" href="/전체">
						<li class="div_gu_item dropdown-item"
						style="width: 100%; font-size: 18px;">전체</li>
					</a>
					<c:forEach items="${guList}" var="gu">
						<a style="color: black" href="/${gu}">
							<li class="div_gu_item dropdown-item"
							style="width: 100%; font-size: 18px;">${gu}</li>
						</a>
					</c:forEach>
				</ul>
				<ul class="dropdown-menu">
					<a style="color: black" href="/전체">
						<li class="div_gu_item dropdown-item"
						style="width: 100%; font-size: 18px;">전체</li>
					</a>
					<c:forEach items="${guList}" var="gu">
						<a style="color: black" href="/${gu}">
							<li class="div_gu_item dropdown-item"
							style="width: 100%; font-size: 18px;">${gu}</li>
						</a>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- 검색창 -->
		<div>
			<form action="/product/search" method="get">
				<input id="input_search_post" type="text" name="q"
					placeholder="상품명 입력" autocomplete="false" /> <input type="hidden"
					name="gu" value="${selectedGu}" />
			</form>
		</div>

		<!-- 아이콘 -->
		<div class="div_nav_icons">
			<c:choose>
				<c:when test="${!empty sessionScope.userId}">
					<div>
						<span class="material-symbols-outlined"> chat </span> <b><a
							href="/users/chat"
							onclick="window.open(this.href, '_blank', 'width=623, height=460, location=no, menubar=no'); return false;">
								채팅</a></b>
					</div>
					<div>
						<span class="material-symbols-outlined"> local_mall </span> <b><a
							href="/product/upload">판매하기</a></b>
					</div>
					<div>
						<span id="logout"><b><a href="/users/logout">로그아웃</a></b></span> <span
							class="material-symbols-outlined">logout</span>
					</div>
					<div class="box" style="background: #BDBDBD;">
						<img class="profile" src="/profileImages/${member.profileImage}">
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

	<div class="main">
		<div class="sellerInfo">
			<div class="box"
				style="background: #BDBDBD; width: 230px; height: 230px; margin: 30px;">
				<img class="profile" src="/profileImages/${seller.profileImage}">
			</div>
			<div class="sellerDetail">
				<div class="nickname">
					<span>${seller.nickname}</span>
				</div>
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:parseNumber var="nowFmtDay" value="${now.time/1000/60/60/24}"
					integerOnly="true" />
				<fmt:parseNumber var="nowFmtHour" value="${now.time/1000/60/60}"
					integerOnly="true" />

				<fmt:parseNumber var="openFmtDay"
					value="${seller.opendate.time/1000/60/60/24}" integerOnly="true" />
				<fmt:parseNumber var="openFmtHour"
					value="${seller.opendate.time/1000/60/60}" integerOnly="true" />
				
				<div>
					<c:choose>
						<c:when test="${nowFmtHour - openFmtHour == 0}">
							<fmt:parseNumber var="viewMinute"
								value="${(now.time - seller.opendate.time)/1000/60}"
								integerOnly="true" />
							<span>상점 오픈일 <b>${viewMinute}분 전</b></span>
						</c:when>
						<c:when test="${nowFmtDay - openFmtDay == 0}">
							<span>상점 오픈일 <b>${nowFmtHour - openFmtHour}시간 전</b></span>
						</c:when>
						<c:otherwise>
							<span>상점 오픈일 <b>${nowFmtDay - openFmtDay}일 전</b></span>
						</c:otherwise>
					</c:choose>
					<span>상품 <b>${productCount} 개</b></span>
				</div>
				<div>
					<form>
						<textarea name="content" readonly>${seller.content}</textarea>
						<c:if test="${seller.id==member.id}">					
							<button type="submit" class="btn btn-primary">수정하기</button>
						</c:if>
					</form>
				</div>
			</div>
		</div>
		<div class="sellerProduct">
			<div>
				상품 <span>${productCount}</span>
			</div>
			<hr>
			<div class="div_items">
				<!-- 상품 -->
				<c:forEach var="product" items="${productList}">

					<a class="item" href="/product/${product.idx}?gu=${selectedGu}">
						<!-- 상품 이미지 --> <img alt="no_image"
						src="/uploadImages/${fn:split(product.filenames,' ')[0]}">
						<div style="width: 90%">
							<div style="font-size: 18px;">${product.title}</div>
							<div style="color: gray; font-size: 13px;">
								<span>${product.gu}</span><br>

								<fmt:parseNumber var="productFmtDay"
									value="${product.writeDate.time/1000/60/60/24}"
									integerOnly="true" />
								<fmt:parseNumber var="productFmtHour"
									value="${product.writeDate.time/1000/60/60}" integerOnly="true" />

								<c:choose>
									<c:when
										test="${(now.time - product.writeDate.time)/1000/60 < 1}">
										<span>방금</span>
									</c:when>
									<c:when test="${nowFmtHour - productFmtHour == 0}">
										<fmt:parseNumber var="viewMinute"
											value="${(now.time - product.writeDate.time)/1000/60}"
											integerOnly="true" />
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
								<fmt:formatNumber value="${product.price}" pattern="###,###" />
								원
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
			<div class="pageNums">
				<c:forEach var="pageNum" begin="1"
					end="${(productCount+((12-productCount%12)%12))/12}">
					<a class="${(pageNum==selectedPage)?'selected':''}"
						href="?gu=${selectedGu}&p=${pageNum}"> ${pageNum} </a>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>