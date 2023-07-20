<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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