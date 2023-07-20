<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->
<script type="text/javascript" src="./js/detailPage.js" defer="defer"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36a0fe67ad31dba87c833fa34314e92c&libraries=services"></script>
<!-- 카카오톡 공유하기 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
	integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx"
	crossorigin="anonymous"></script>

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

<link href="/css/header.css" rel="stylesheet">
<link href="/css/mainPage.css" rel="stylesheet">
<link rel="stylesheet" href="/css/detail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />


</head>
<body>
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
					<a style="color: black"
						href="?gu=전체&q=${selectedQuery}&c=${category}&p=${selectedPage}">
						<li class="div_gu_item dropdown-item"
						style="width: 100%; font-size: 18px;">전체</li>
					</a>
					<c:forEach items="${guList}" var="gu">
						<a style="color: black"
							href="?gu=${gu}&q=${selectedQuery}&c=${category}&p=${selectedPage}">
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
					value="${selectedQuery}" placeholder="상품명 입력" autocomplete="false" />
				<input type="hidden" name="gu" value="${selectedGu}">
				<%-- <input type="hidden" name="c" value="${category}">
						<input type="hidden" name="p" value="${selectedPage}"> --%>
			</form>
		</div>

		<!-- 아이콘 -->
		<div class="div_nav_icons">
			<c:choose>
				<c:when test="${!empty sessionScope.userId}">
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

	<div id="wrap">
		<div
			style="display: flex; justify-content: center; padding-top: 150px;">
			<!-- 상품 이미지 슬라이더 -->
			<c:set var="productImages" value="${fn:split(product.filenames,' ')}" />
			<div class="container">
				<div class="album">
					<div class="images">
						<c:forEach var="image" items="${productImages}">
							<div>
								<img alt="noImage" src="/uploadImages/${image}">
							</div>
						</c:forEach>
					</div>
					<button class="prev">
						<span class="material-symbols-outlined"> arrow_back_ios </span>
					</button>
					<button class="next">
						<span class="material-symbols-outlined"> arrow_forward_ios
						</span>
					</button>
				</div>

			</div>

			<!-- 상품 상세 설명 -->
			<div class="product">
				<div
					style="font-size: 20px; font-weight: 500; margin-bottom: 25px; display: flex; align-items: center;">
					<div class="box"
						style="background: #BDBDBD; width: 40px; height: 40px;">
						<img class="profile" src="/profileImages/${seller.profileImage}">
					</div>
					${seller.nickname}
				</div>
				<hr style="border: 1px solid lightgray;">
				<div style="font-size: 25px; font-weight: 600; margin-bottom: 25px;">
					<c:choose>
						<c:when test="${product.isTrade == 1 }">
							<span style="color: gray">거래완료 </span>
							<!-- <img src="/images/sold-out.png" width="40px" /> -->
						</c:when>
						<c:when test="${product.isTrade == 0 }">
							<span style="color: gray">판매중 </span>
							<!-- <img src="/images/deal.png" width="40px" /> -->
						</c:when>
					</c:choose>
					${product.title}
				</div>
				<div style="margin-bottom: 10px;">
					<span style="color: gray; margin-right: 7px;">작성시간 </span>
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:parseNumber var="nowFmtDay" value="${now.time/1000/60/60/24}"
						integerOnly="true" />
					<fmt:parseNumber var="nowFmtHour" value="${now.time/1000/60/60}"
						integerOnly="true" />
					<fmt:parseNumber var="productFmtDay"
						value="${product.writeDate.time/1000/60/60/24}" integerOnly="true" />
					<fmt:parseNumber var="productFmtHour"
						value="${product.writeDate.time/1000/60/60}" integerOnly="true" />
					<c:choose>
						<c:when test="${(now.time - product.writeDate.time)/1000/60 < 1}">
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

				<div style="margin-bottom: 10px;">
					<span style="color: gray; margin-right: 7px;">거래지역 </span>
					${product.gu}
				</div>
				<div style="font-size: 30px; font-weight: 600;">
					<fmt:formatNumber value="${product.price}" pattern="###,###" />
					원
				</div>
				
				<div style="display:flex; justify-content: space-around; margin-top:100px;,margin:25px;"> 
					<c:if test="${seller.id!=member.id}">
						<div style="background: orangered; cursor: pointer; border-radius:3px; width:176px; height: 56px; color:white; font-weight:bold; display: flex; justify-content: center; align-items: center;">
							찜하기
						</div>
						<div style="background: orange; cursor: pointer; border-radius:3px; width:176px; height: 56px; color:white; font-weight:bold; display: flex; justify-content: center; align-items: center;">
							채팅하기
						</div>
					</c:if>
					<c:if test="${seller.id==member.id}">
						<div style="background: orangered; cursor: pointer; border-radius:3px; width:176px; height: 56px; color:white; font-weight:bold; display: flex; justify-content: center; align-items: center;">
							수정하기
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="detail">
		<div style="width:70%; border-right: 1px solid lightgray;">
			<div calss="productDetail" style="font-size: 20px; font-weight: 600; margin: 25px;">
				상품정보
			</div>
			<hr style="border: 1px solid lightgray; width: 90%; margin:0 auto;">

			<div style="margin: 15px; font-family: sans-serif;">
				<div style="margin-left: 10px;">
					<textarea style="width:570px; margin: auto; overflow: hidden; resize:none;border:none;outline: none;"rows="10"><c:out value="${product.content}"/></textarea>
				</div>
				<div style=" width:100%; display: flex; justify-content: center; padding: 20px; text-align: center;">
					<div style="width: 320px; height: 70px;">
						<div style="margin:15px; display: flex; align-items: center; justify-content: center;">
						<span class="material-symbols-outlined">location_on</span>거래지역</div>
						<hr style="border: 1px solid gray; width: 90%; margin:0 auto;">
						<div style="margin:15px;">${product.gu}</div>
					</div>
					<c:choose>
						<c:when test="${product.category=='clothing'}"><c:set var="category" value="의류"/></c:when>
						<c:when test="${product.category=='accessory'}"><c:set var="category" value="잡화"/></c:when>
						<c:when test="${product.category=='appliances'}"><c:set var="category" value="가전 제품"/></c:when>
						<c:when test="${product.category=='furniture'}"><c:set var="category" value="가구/인테리어"/></c:when>
						<c:when test="${product.category=='hobby'}"><c:set var="category" value="취미"/></c:when>
						<c:when test="${product.category=='book'}"><c:set var="category" value="도서"/></c:when>
						<c:when test="${product.category=='sport'}"><c:set var="category" value="스포츠/레져"/></c:when>
						<c:when test="${product.category=='pet'}"><c:set var="category" value="반려동물 제품"/></c:when>
					</c:choose>
					
					<div style="width: 320px; height: 70px;">
						<div style="margin:15px; display: flex; align-items: center; justify-content: center;"><span class="material-symbols-outlined">menu</span>카테고리</div>
						<hr style="border: 1px solid gray; width: 90%; margin:0 auto;">
						<div style="margin:15px;">${category}</div>
					</div>
				</div>
			</div>
		</div>
		<div style="width:30%; padding: 10px;">
			<div calss="userDetail" style="font-size: 20px; font-weight: 600; margin: 25px;">
				상점 정보
			</div>
			<hr style="border: 1px solid lightgray; width: 80%; margin:0 auto;">
			<div
				style="font-size: 15px; font-weight: 500; display: flex; align-items: center;  font-family: sans-serif;">
				<div class="box"
					style="background: #BDBDBD; width: 40px; height: 40px;">
					<img class="profile" src="/profileImages/${seller.profileImage}">
				</div>
				<div>
					<div><b>${seller.nickname}</b></div>
					<div>상품갯수 <span>${sellerProductsCount}</span></div>
				</div>
			</div>
			<div style="display: flex; flex-wrap: wrap; width: 100%; justify-content: center;">
				<c:forEach var="p" items="${sellerProducts}">
					<div style="position: relative;">
						<a href="#">
							<img style="width:90px; height: 90px; margin:10px;" src="/uploadImages/${fn:split(p.filenames, ' ')[0]}">
						</a>
						<div style="position: absolute; bottom:10px;
    						left: 10px; width:90px; text-align: center; background: rgba(0, 0, 0, 0.25); color:white; font-size: 14px;">
    						<fmt:formatNumber value="${p.price}" pattern="###,###"/>원
    					</div>
					</div>
				</c:forEach>
			</div>
			<div style="margin:10px; font-size: 15px;">
				<a href="/users/${seller.id}?gu=${selectedGu}" style="display: flex; align-items: center; justify-content:center;">
					<span style="color:orangered">${sellerProductsCount}개</span>의 상품 보러가기
					<span class="material-symbols-outlined">arrow_forward_ios</span>
				</a>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	{
		let imageIndex = 0;
		let postion= 0;
		const IMAGE_WIDTH = 600;
		const btnPrevious= document.querySelector(".prev"); // css에서 설정한 width 값과 동일하게 맞춰주세요 document.querySelector(".previous")
		const btnNext = document.querySelector(".next");
		const images = document.querySelector(".images");
		console.log(images);
		function prev(){
			if(imageIndex > 0){
				btnNext.removeAttribute("disabled")
				postion += IMAGE_WIDTH;
				images.style.transform = "translateX(" + postion  + "px)"; 
				imageIndex = imageIndex - 1;
		}
		if(imageIndex == 0){
			btnPrevious.setAttribute('disabled', 'true')
		}
		}
		function next(){
			if(imageIndex < ${fn:length(productImages)-1}){
				btnPrevious.removeAttribute("disabled")
				postion -= IMAGE_WIDTH;
				images.style.transform = "translateX(" + postion  + "px)"; 
				imageIndex = imageIndex + 1;
			}
			if(imageIndex == ${fn:length(productImages)-1}){
				btnNext.setAttribute('disabled', 'true')
			}
		}
		function init(){
			btnPrevious.setAttribute('disabled', 'true')
			btnPrevious.addEventListener("click", prev) 
			btnNext.addEventListener("click", next)
		}
		init();
	}
</script>
</html>