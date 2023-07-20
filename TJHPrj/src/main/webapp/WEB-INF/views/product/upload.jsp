<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 업로드</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" 	src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/productUpload.js" defer="defer"></script>

<link rel="stylesheet" href="/css/productUpload.css">
<link href="/css/header.css" rel="stylesheet">

<!-- Google Icon -->
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,1,200"
	rel="stylesheet" />
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
						<b><a href="/product/upload">판매하기</a></b> 
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

	<div id="wrap">
		<div>
			<!-- <form action="prodcutUploadOk" method="post" enctype="multipart/form-data" name="upload" onSubmit="return checkForm()"> -->
			<!-- <form method="post" class="row g-3 needs-validation" novalidate enctype="multipart/form-data" name="upload" > -->
			<form method="post" enctype="multipart/form-data">
				<table class="table border-3 border-secondary rounded-3" border="1" cellpadding="3" cellspacing="0" width="500px">
					<tr>
						<td align="center" valign="middle" width="100px">제목</td>
						<td colspan="3">
							<input type="text" class="form-control form-control-sm"  name="title" style="width: 98%; height: 30px;" required />
						</td>
					</tr>
					<tr>
						<td align="center" valign="middle">지역</td>
						<td align="center" width="250px">
							<div style="display: inline-block; width: 125px;">
								<select id="postgu" class="form-select form-select-sm" name="gu" style="width: 100%; height: 30px;" required>
									<option value="">선택</option>
									<c:forEach var="gu" items="${guList}">
										<option value="${gu}">${gu}</option>
									</c:forEach>
								</select> 
							</div>
						</td>
						<td align="center" valign="middle" width="80px" >카테고리</td>
						<td align="center" valign="middle" width="120">
							<select name="category" class="form-select form-select-sm" style="width: 95%; height: 30px;"  required>
									<option selected disabled value="">선택</option>
									<option value="clothing">의류</option>
									<option value="accessory">잡화</option>
									<option value="appliances">가전 제품</option>
									<option value="furniture">가구/인테리어</option>
									<option value="hobby">취미</option>
									<option value="book">도서</option>
									<option value="sport">스포츠/레져</option>
									<option value="pet">반려동물 제품</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center" valign="middle">가격</td>
						<td align="center" valign="middle" colspan="3">
							<input class="form-control form-control-sm" type="text" name="price" style="width: 95%; height: 30px;" autocomplete="off" required />
						</td>
					</tr>
					<tr>
						<td align="center">상세설명</td>
						<td colspan="3"></td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<p>
							<textarea id="content" class="form-control form-control-sm" rows="10"
							 name="content" style="width: 98%; resize: none;"  required></textarea>
						 </p>
						
						</td>
					</tr>
					
					<tr>
						<td>첨부파일</td>
						<td colspan='3'>
							<input type="file" multiple="multiple" name="files">
						</td>
						<!-- <td align="center" valign="middle">첨부파일</td>
						<td colspan="3" valign="middle" >
							<div style="width: 500px; vertical-align: middle; position: relative;">
								<input type="file" id="fileSelect" class="btn btn-sm" name="uploadFile" multiple="multiple" accept="image/*" style="visibility: hidden;" required/>
								<label for="fileSelect" >
									<div style="position: absolute; top:0; left: 0;">
											<div class="btn text-white btn-sm" style="background-color: #B88FCC;">파일선택</div>
									</div>
										<div id="filedrag"  contenteditable="true" placeholder="버튼을 클릭하거나 파일을 드래그앤드롭 하세요" ></div>
								</label>
							</div>
						</td> -->
					</tr>
						<td colspan="4" align="center">
							<input type="submit" class="btn text-white btn-sm" value="상품등록" style="background-color: #B88FCC;"  /> 
							<input type="reset" class="btn text-white btn-sm" value="다시쓰기" style="background-color: #B88FCC; "/> 
							<input type="button" class="btn text-white btn-sm" value="돌아가기" onclick="history.back()" style="background-color: #B88FCC;"/></td>
					</tr>
				</table>
				<input type="hidden" name="userId" value="${member.id}"></br>
			</form>
		</div>
	</div>

</body>
</html>